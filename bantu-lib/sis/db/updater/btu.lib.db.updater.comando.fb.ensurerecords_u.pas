unit btu.lib.db.updater.comando.fb.ensurerecords_u;

interface

uses btu.lib.db.updater.comando, System.Classes,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u,
  btu.lib.db.updater.operations,
  btu.sis.ui.io.log, btu.sis.ui.io.output;

type
  TComandoFBEnsureRecords = class(TComandoFB)
  private
    FNomeTabela: string;
    FaTitulos: TArray<string>;
    FRegistrosSL: TStringList;
    FTemDBQuery: IDBQuery;
    FInsDBExec: IDBExec;
    FUpdDBExec: IDBExec;
    FiQtdIndices: integer;

    procedure InicializeSqlOperations;
    procedure PreencherQtdIndices;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses btu.lib.db.updater.constants_u, System.SysUtils,
  btu.lib.db.updater.factory, btn.lib.types.strings, btu.sis.db.updater.utils,
  System.StrUtils, btu.lib.db.firebird.GetSql,
  btu.lib.db.updater.firebird.GetSql_u, btu.lib.db.factory;

{ TComandoFBEnsureRecords }

constructor TComandoFBEnsureRecords.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLog, pOutput);
  FRegistrosSL := TStringList.Create;
end;

destructor TComandoFBEnsureRecords.Destroy;
begin
  FRegistrosSL.Free;
  inherited;
end;

function TComandoFBEnsureRecords.Funcionou: boolean;
begin
  Result := True;
end;

function TComandoFBEnsureRecords.GetAsSql: string;
var
  I: integer;
  sReg: string;
  aValores: TArray<string>;
  iParamIndice: integer;
  bRegistroTem: boolean;
  J: integer;
  sErro: string;
  sLog: string;
  iPasso: integer;
  s: string;
  perc: double;
begin
  Result := '';
  Output.Exibir(AsText + ' Inicio');
  Log.Exibir(AsText + ' Inicio');
  Log.Exibir('StartTransaction');
//  DBConnection.StartTransaction;
  if FRegistrosSL.count < 100 then
    iPasso := 0;

  Output.Exibir('Processando '+FRegistrosSL.count.ToString+' registros');
  try
    try
      for I := 0 to FRegistrosSL.count - 1 do
      begin
        sLog := I.ToString;
        try
        sReg := FRegistrosSL[I];

        AjusteAsciiCodeToChar(sReg);

        aValores := sReg.Split([';']);

        for J := 0 to FiQtdIndices - 1 do
        begin
          //sLog := sLog + ';' + aValores[J];
          FTemDBQuery.Params[J].Value := aValores[J];
        end;

        FTemDBQuery.Open;
        try
          bRegistroTem := FTemDBQuery.DataSet.Fields[0].AsInteger = 1;
        finally
          FTemDBQuery.Close;
        end;

        if bRegistroTem then
        begin
          //sLog := sLog + ';TY';
          iParamIndice := 0;
          for J := FiQtdIndices to Length(aValores) - 1 do
          begin
            FUpdDBExec.Params[iParamIndice].Value := aValores[J];
            inc(iParamIndice);
          end;
          for J := 0 to FiQtdIndices - 1 do
          begin
            FUpdDBExec.Params[iParamIndice].Value := aValores[J];
            inc(iParamIndice);
          end;
          FUpdDBExec.Execute;
        end
        else
        begin
          //sLog := sLog + ';TN';
          for J := 0 to Length(aValores) - 1 do
          begin
            FInsDBExec.Params[J].Value := aValores[J];
          end;
          FInsDBExec.Execute;
        end;
        finally
//          Log.Exibir(sLog);
        end;
      end;
    except
      on E: Exception do
      begin
        sErro := AsText + ' Erro ' + E.ClassName + ' ' + E.Message;
        Log.Exibir(sErro);
        output.Exibir(sErro);
        //DBConnection.Rollback;
        raise Exception.Create(sErro);
      end;
    end;
  finally
//    DBConnection.Commit;
    Log.Exibir('Commit');
    Log.Exibir('');
//    DBConnection.Abrir;
//    DBConnection.Fechar;
    Output.Exibir('Terminado');
  end;
end;

function TComandoFBEnsureRecords.GetAsText: string;
begin
  Result := 'ENSURE RECORDS ' + FNomeTabela;
end;

procedure TComandoFBEnsureRecords.InicializeSqlOperations;
var
  sSqlTem: string;
  sSqlIns: string;
  sSqlUpd: string;

  I: integer;
  sCampos, sValues: string;

  sUpdCamposSet: string;
  sWhere: string;

  sErro: string;
begin
  sCampos := '';
  sValues := '';
  sUpdCamposSet := '';
  sWhere := '';

  sSqlTem := 'SELECT ' + FaTitulos[0] + ' FROM ' + FNomeTabela + ' WHERE ';

  for I := 0 to FiQtdIndices - 1 do
  begin
    if sWhere <> '' then
      sWhere := sWhere + ' AND ';
    sWhere := sWhere + '(' + FaTitulos[I] + '= :' + FaTitulos[I] + ')';
  end;

  sSqlTem := sSqlTem + sWhere;

  sSqlTem := GetSQLExists(sSqlTem);
  FTemDBQuery := DBQueryCreate(DBConnection, sSqlTem, log, output);
  try
    FTemDBQuery.Prepare;
  except
    on E: Exception do
    begin
      sErro := E.Message + ' ao preparar ' + sSqlTem;
      log.Exibir(sErro);
      output.Exibir(sErro);
      raise Exception.Create(sErro);
    end;
  end;

  sSqlIns := 'INSERT INTO ' + FNomeTabela + '(';
  sSqlUpd := 'UPDATE ' + FNomeTabela + ' SET ';

  for I := 0 to Length(FaTitulos) - 1 do
  begin
    if sCampos <> '' then
      sCampos := sCampos + ',';
    sCampos := sCampos + FaTitulos[I];

    if sValues <> '' then
      sValues := sValues + ',';

    sValues := sValues + ':' + FaTitulos[I];

    if I > (FiQtdIndices - 1) then
    begin
      if sUpdCamposSet <> '' then
        sUpdCamposSet := sUpdCamposSet + ',';
      sUpdCamposSet := sUpdCamposSet + FaTitulos[I] + ' = :' + FaTitulos[I];
    end;
  end;

  sSqlIns := sSqlIns + sCampos + ') values (' + sValues + ');';
  sUpdCamposSet := sUpdCamposSet + ' WHERE ' + sWhere + ';';
  sSqlUpd := sSqlUpd + sUpdCamposSet;

  FInsDBExec := DBExecCreate(DBConnection, sSqlIns, log, output);
  try
    FInsDBExec.Prepare;
  except
    on E: Exception do
    begin
      sErro := E.Message + ' ao preparar ' + sSqlTem;
      log.Exibir(sErro);
      output.Exibir(sErro);
      raise Exception.Create(sErro);
    end;
  end;

  FUpdDBExec := DBExecCreate(DBConnection, sSqlUpd, log, output);
  try
    FUpdDBExec.Prepare;
  except
    on E: Exception do
    begin
      sErro := E.Message + ' ao preparar ' + sSqlTem;
      log.Exibir(sErro);
      output.Exibir(sErro);
      raise Exception.Create(sErro);
    end;
  end;
end;

procedure TComandoFBEnsureRecords.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  bPegandoRegistros: boolean;

  sObjetoNome: string;
  iQtdRegs: integer;
begin
  bPegandoRegistros := false;
  iQtdRegs := 0;
  while piLin < pSL.count - 1 do
  begin
    inc(piLin);

    sLinha := pSL[piLin];
    if Trim(sLinha) = '' then
      Continue;

    if bPegandoRegistros then
    begin
      if sLinha = DBATUALIZ_CSV_FIM_CHAVE then
      begin
        bPegandoRegistros := false;
        break;
      end;
      if iQtdRegs = 0 then
        FaTitulos := sLinha.Split([';'])
      else
        FRegistrosSL.Add(sLinha);
      inc(iQtdRegs);
    end
    else if sLinha = DBATUALIZ_CSV_INI_CHAVE then
    begin
      bPegandoRegistros := True;
    end
    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;

  PreencherQtdIndices;
  InicializeSqlOperations;
end;

procedure TComandoFBEnsureRecords.PegarObjeto(pNome: string);
begin
  // inherited;
  FNomeTabela := pNome;
end;

procedure TComandoFBEnsureRecords.PreencherQtdIndices;
var
  sIndexFieldNames: string;
  aFieldNames: TArray<string>;
begin
  sIndexFieldNames := DBUpdaterOperations.GetIndexFieldNames
    (DBUpdaterOperations.NomeTabelaToPKName(FNomeTabela));
  aFieldNames := sIndexFieldNames.Split([',']);
  FiQtdIndices := Length(aFieldNames);
end;

end.

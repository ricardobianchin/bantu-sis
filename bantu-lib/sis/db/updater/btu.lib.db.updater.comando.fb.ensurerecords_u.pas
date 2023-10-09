unit btu.lib.db.updater.comando.fb.ensurerecords_u;

interface

uses btu.lib.db.updater.comando, System.Classes,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u, btu.lib.db.updater.operations,
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

    procedure InicializeSqlOperations;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
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
  btu.lib.db.updater.factory, btn.lib.types.strings, btu.sis.db.updater.utils
  , System.StrUtils, btu.lib.db.firebird.GetSql,
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
  I: Integer;
  sReg: string;
  aValores: TArray<string>;
  sIndexFieldNames: string;
  aFieldNames: TArray<string>;
  iQtdIndices: integer;
  iParamIndice: integer;
  bRegistroTem: boolean;
  J: Integer;
begin
  Result := '';

  sIndexFieldNames := DBUpdaterOperations.GetIndexFieldNames
    (DBUpdaterOperations.NomeTabelaToPKName(FNomeTabela));
  aFieldNames := sIndexFieldNames.Split([',']);
  iQtdIndices := Length(aFieldNames);

  for I := 0 to FRegistrosSL.count - 1 do
  begin
    sReg := FRegistrosSL[I];

    AjusteAsciiCodeToChar(sReg);

    aValores := sReg.Split([';']);

    for J := 0 to iQtdIndices - 1 do
    begin
      FTemDBQuery.Params[J].AsString := aValores[J];
    end;

    FTemDBQuery.Open;
    try
      bRegistroTem := FTemDBQuery.DataSet.Fields[0].AsInteger = 1;
    finally
      FTemDBQuery.Close;
    end;

    if bRegistroTem then
    begin
      iParamIndice := 0;
      for J := iQtdIndices to Length(aValores) - 1 do
      begin
        FUpdDBExec.Params[iParamIndice].AsString := aValores[J];
        inc(iParamIndice);
      end;
      for J := 0 to iQtdIndices - 1 do
      begin
        FUpdDBExec.Params[iParamIndice].AsString := aValores[J];
        inc(iParamIndice);
      end;
      FUpdDBExec.Execute;
    end
    else
    begin
      for J := 0 to Length(aValores) - 1 do
      begin
        FInsDBExec.Params[J].AsString := aValores[J];
      end;
      FInsDBExec.Execute;
    end;
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

  sUpdSet: string;
  s: string;
begin
  sCampos := '';
  sValues := '';
  sUpdSet := '';

  sSqlTem :=
    'SELECT ' + FaTitulos[0]
    +' FROM ' + FNomeTabela
    +' WHERE ' + FaTitulos[0] + '= :' + FaTitulos[0]
    ;

  sSqlTem := GetSQLExists(sSqlTem);
  FTemDBQuery := DBQueryCreate(DBConnection, sSqlTem, Log, Output);
  try
    FTemDBQuery.Prepare;
  except on E: Exception do
  begin
    s := e.Message + ' ao preparar ' + sSqlTem;
    Log.Exibir(s);
    Output.Exibir(s);
    raise Exception.Create(s);
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

    if I > 0 then
    begin
      if sUpdSet <> '' then
        sUpdSet := sUpdSet + ',';
      sUpdSet := sUpdSet + FaTitulos[I] + ' = :' + FaTitulos[I];
    end;
  end;

  sSqlIns := sSqlIns + sCampos
    + ') values ('
    + sValues
    + ');'
    ;

  FInsDBExec := DBExecCreate(DBConnection, sSqlIns, Log, Output);
  try
    FInsDBExec.Prepare;
  except on E: Exception do
  begin
    s := e.Message + ' ao preparar ' + sSqlTem;
    Log.Exibir(s);
    Output.Exibir(s);
    raise Exception.Create(s);
  end;
  end;

  sUpdSet := sUpdSet + ' WHERE ' + FaTitulos[0] + ' = :' + FaTitulos[0] + ';';
  sSqlUpd := sSqlUpd + sUpdSet;

  FUpdDBExec := DBExecCreate(DBConnection, sSqlUpd, Log, Output);
  try
    FUpdDBExec.Prepare;
  except on E: Exception do
  begin
    s := e.Message + ' ao preparar ' + sSqlTem;
    Log.Exibir(s);
    Output.Exibir(s);
    raise Exception.Create(s);
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
  while piLin < pSL.Count - 1 do
  begin
    inc(piLin);

    sLinha := pSL[piLin];
    if Trim(sLinha) = '' then
      Continue;

    if bPegandoRegistros then
    begin
      if sLinha = DBATUALIZ_CSV_FIM_CHAVE then
      begin
        bPegandoRegistros := False;
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

  InicializeSqlOperations;
end;

procedure TComandoFBEnsureRecords.PegarObjeto(pNome: string);
begin
//  inherited;
  FNomeTabela := pNome;
end;

end.

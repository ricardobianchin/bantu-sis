unit Sis.DB.Updater.Comando.FB.EnsureRecords_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

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
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.strings_u, System.Math,
  Sis.DB.Firebird.GetSQL_u, Sis.DB.Factory, Sis.DB.Updater.Constants_u,
  Sis.Types.TStrings_u;

{ TComandoFBEnsureRecords }

constructor TComandoFBEnsureRecords.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
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
  iQtdRegs: integer;
  iRegAtual: integer;
begin
  Result := '';
  ProcessLog.PegueLocal('TComandoFBEnsureRecords.GetAsSql');
  try
    Output.Exibir(AsText + ' Inicio');
    ProcessLog.RegistreLog(AsText + ' Inicio');
    // ProcessLog.RegistreLog('StartTransaction');
    // DBConnection.StartTransaction;


    Output.Exibir('Processando ' + FRegistrosSL.count.ToString + ' registros');
    ProcessLog.RegistreLog('Processando ' + FRegistrosSL.count.ToString +
      ' registros');
    try
      try

//        {$IFDEF DEBUG}
//        iQtdRegs := Min(25, FRegistrosSL.count - 1);
//        {$ELSE}
//        iQtdRegs := FRegistrosSL.count - 1;
//        {$ENDIF}

        iQtdRegs := FRegistrosSL.count - 1;

        if iQtdRegs < 100 then
          iPasso := 0
        else
          iPasso := 50;

        for I := 0 to iQtdRegs do
        begin
          if iPasso > 0 then
          begin
           if (I mod iPasso) = 0 then
              Output.Exibir('Processando ' + I.ToString + ' / ' + FRegistrosSL.count.ToString + ' registros');
          end;

          sLog := I.ToString;
          try
            sReg := FRegistrosSL[I];

            AjusteAsciiCodeToChar(sReg);

            aValores := sReg.Split([';']);

            for J := 0 to FiQtdIndices - 1 do
            begin
              // sLog := sLog + ';' + aValores[J];
              FTemDBQuery.Params[J].Value := aValores[J];
            end;

            FTemDBQuery.Open;
            try
              bRegistroTem := FTemDBQuery.DataSet.Fields[0].AsInteger = 1;
            finally
              FTemDBQuery.Close;
            end;

            if bRegistroTem and assigned(FUpdDBExec) then
            begin
              // sLog := sLog + ';TY';
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
              // sLog := sLog + ';TN';
              for J := 0 to Length(aValores) - 1 do
              begin
                FInsDBExec.Params[J].Value := aValores[J];
              end;
              FInsDBExec.Execute;
            end;
          finally
            // ProcessLog.RegistreLog(sLog);
          end;
        end;
      except
        on E: Exception do
        begin
          sErro := AsText + 'TComandoFBEnsureRecords.GetAsSql Erro ' +
            E.ClassName + ' ' + E.Message;
          ProcessLog.RegistreLog(sErro);
          Output.Exibir(sErro);
          // DBConnection.Rollback;
          raise Exception.Create(sErro);
        end;
      end;
    finally
      // DBConnection.Commit;
      // ProcessLog.RegistreLog('Commit');
      // DBConnection.Abrir;
      // DBConnection.Fechar;
    end;
  finally
    Output.Exibir('Terminado');
    ProcessLog.RegistreLog('Terminado');
    ProcessLog.RetorneLocal;
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
  ProcessLog.PegueLocal('TComandoFBEnsureRecords.InicializeSqlOperations');
  try
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
    FTemDBQuery := DBQueryCreate('EnsureRecTemQ', DBConnection, sSqlTem,
      ProcessLog, Output);
    try
      FTemDBQuery.Prepare;
    except
      on E: Exception do
      begin
        sErro := E.Message + ' ao preparar ' + sSqlTem;
        ProcessLog.RegistreLog(sErro);
        Output.Exibir(sErro);
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

    if Length(FaTitulos) = FiQtdIndices then
    begin
      sSqlUpd := '';
    end;

    FInsDBExec := DBExecCreate('EnsureRecInsQ',DBConnection, sSqlIns, ProcessLog, Output);
    try
      FInsDBExec.Prepare;
    except
      on E: Exception do
      begin
        sErro := E.Message + ' ao preparar ' + sSqlTem;
        ProcessLog.RegistreLog(sErro);
        Output.Exibir(sErro);
        raise Exception.Create(sErro);
      end;
    end;

    FUpdDBExec := nil;

    if sSqlUpd <> '' then
    begin
      FUpdDBExec := DBExecCreate('EnsureRecUpdQ', DBConnection, sSqlUpd,
        ProcessLog, Output);
      try
        FUpdDBExec.Prepare;
      except
        on E: Exception do
        begin
          sErro := E.Message + ' ao preparar ' + sSqlTem;
          ProcessLog.RegistreLog(sErro);
          Output.Exibir(sErro);
          raise Exception.Create(sErro);
        end;
      end;
    end;
  finally
    ProcessLog.RetorneLocal;
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

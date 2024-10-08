unit App.DB.Utils;

interface

uses Sis.Config.SisConfig, App.AppInfo, Sis.DB.DBTypes, Data.DB,
  Sis.Entities.Types, Sis.Entities.TerminalList, Sis.Entities.Terminal,
  Sis.Entities.Factory;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;

procedure PreencherTerminalList(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pDBMS: IDBMS; pDBConnectionParams: TDBConnectionParams;
  pNomeDaMaquina: string; pTerminalList: ITerminalList);

implementation

uses Sis.Sis.Constants, Sis.DB.Factory, System.SysUtils;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig): TDBConnectionParams;
begin
  if pTerminalId <= TERMINAL_ID_NAO_INDICADO then
  begin
    Result.Server := '';
    Result.Arq := '';
    Result.Database := '';
    exit;
  end;

  if pTerminalId = TERMINAL_ID_RETAGUARDA then
  begin
    Result.Server := pSisConfig.ServerMachineId.Name;
    Result.Arq := pAppInfo.PastaDados + 'RETAG.FDB';
    Result.Database := Result.Server + ':' + Result.Arq;
    exit;
  end;

  Result.Server := '';
  Result.Arq := '';
  Result.Database := '';
end;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;
begin
  case pDataSetState of
    dsInactive:
      Result := 'Inativo';
    dsBrowse:
      Result := 'Navegando';
    dsEdit:
      Result := 'Alterando';
    dsInsert:
      Result := 'Inserindo';
    dsSetKey:
      ;
    dsCalcFields:
      ;
    dsFilter:
      ;
    dsNewValue:
      ;
    dsOldValue:
      ;
    dsCurValue:
      ;
    dsBlockRead:
      ;
    dsInternalCalc:
      ;
    dsOpening:
      ;
  else
    Result := '';
  end;
end;

procedure PreencherTerminalList(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pDBMS: IDBMS; pDBConnectionParams: TDBConnectionParams;
  pNomeDaMaquina: string; pTerminalList: ITerminalList);
var
  sSql: string;
  oDBConnectio: IDBConnection;
  q: TDataSet;
  oTerminal: ITerminal;
  sNomeArq: string;
begin
  pTerminalList.Clear;
  oDBConnectio := DBConnectionCreate('PreencherTerminalList.conn', pSisConfig,
    pDBMS, pDBConnectionParams, nil, nil);
  if not oDBConnectio.Abrir then
    exit;
  try
    sSql := 'SELECT'#13#10 //
      + 'TERMINAL_ID'#13#10 // 0
      + ', APELIDO'#13#10 // 1
      + ', NOME_NA_REDE'#13#10 // 2
      + ', IP'#13#10 // 3
      + ', NF_SERIE'#13#10 // 4
      + ', LETRA_DO_DRIVE'#13#10 // 5
      + ', GAVETA_TEM'#13#10 // 6
      + ', BALANCA_MODO_ID'#13#10 // 7
      + ', BALANCA_ID'#13#10 // 8
      + ', BARRAS_COD_INI'#13#10 // 9
      + ', BARRAS_COD_TAM'#13#10 // 10
      + ', CUPOM_NLINS_FINAL'#13#10 // 11
      + ', SEMPRE_OFFLINE'#13#10 // 12
      + ' FROM TERMINAL'#13#10 // 13
      + ' where NOME_NA_REDE=' + pNomeDaMaquina.QuotedString // 14
      + 'ORDER BY TERMINAL_ID'#13#10; // 15

    oDBConnectio.QueryDataSet(sSql, q);
    while not q.Eof do
    begin
      oTerminal := TerminalCreate;
      pTerminalList.Add(oTerminal);
      oTerminal.TerminalId := q.Fields[0].AsInteger;
      oTerminal.Apelido := Trim(q.Fields[1].AsString);
      oTerminal.NomeNaRede := pNomeDaMaquina;
      oTerminal.NFSerie := q.Fields[4].AsInteger;
      oTerminal.LetraDoDrive := Trim(q.Fields[5].AsString);

      sNomeArq := pAppInfo.PastaDados + 'Term' +
        oTerminal.TerminalId.ToStrZero + '.fdb';
      sNomeArq[1] := oTerminal.LetraDoDrive[1];

      oTerminal.LocalArqDados := sNomeArq;
      oTerminal.Database := oTerminal.NomeNaRede+':'+sNomeArq;

      q.Next;
    end;
  finally
    oDBConnectio.Fechar;
  end;
end;

end.

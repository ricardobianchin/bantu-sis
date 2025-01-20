unit App.DB.Utils;

interface

uses App.AppObj, Sis.DB.DBTypes, Data.DB,
  Sis.Entities.Types, Sis.Entities.TerminalList, Sis.Entities.Terminal,
  Sis.Entities.Factory;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppObj: IAppObj): TDBConnectionParams;

function DataSetStateToTitulo(pDataSetState: TDataSetState): string;

procedure PreencherTerminalList(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pTerminalList: ITerminalList; pNomeDaMaquina: string = '');

procedure DataSetToTerminal(Q: TDataSet; pTerminal: ITerminal;
  pAppObj: IAppObj);

implementation

uses Sis.Sis.Constants, Sis.DB.Factory, System.SysUtils, App.AppInfo.Types;

function TerminalIdToDBConnectionParams(pTerminalId: TTerminalId;
  pAppObj: IAppObj): TDBConnectionParams;
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
    Result.Server := pAppObj.SisConfig.ServerMachineId.Name;
    Result.Arq := pAppObj.AppInfo.PastaDados + //
      'Dados_' + //
      AtividadeEconomicaSisDescr[pAppObj.AppInfo.AtividadeEconomicaSis] + //
      '_Retaguarda.FDB' //
      ;

    Result.Arq[1] := pAppObj.SisConfig.ServerLetraDoDrive;
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

procedure PreencherTerminalList(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pTerminalList: ITerminalList; pNomeDaMaquina: string);
var
  sSql: string;
  Q: TDataSet;
  oTerminal: ITerminal;
begin
  pTerminalList.Clear;
  if not pDBConnection.Abrir then
    exit;
  try
    sSql := 'SELECT'#13#10 //
      + 'TERMINAL_ID'#13#10 // 0

      + ', APELIDO'#13#10 // 1
      + ', NOME_NA_REDE'#13#10 // 2
      + ', IP'#13#10 // 3
      + ', LETRA_DO_DRIVE'#13#10 // 4

      + ', NF_SERIE'#13#10 // 5

      + ', GAVETA_TEM'#13#10 // 6
      + ', GAVETA_COMANDO'#13#10 // 7
      + ', GAVETA_IMPR_NOME'#13#10 // 8

      + ', BALANCA_MODO_USO_ID'#13#10 // 9
      + ', BALANCA_ID'#13#10 // 10

      + ', BARRAS_COD_INI'#13#10 // 11
      + ', BARRAS_COD_TAM'#13#10 // 12

      + ', IMPRESSORA_MODO_ENVIO_ID'#13#10 // 13
      + ', IMPRESSORA_MODELO_ID'#13#10 // 14
      + ', IMPRESSORA_NOME'#13#10 // 15
      + ', IMPRESSORA_COLS_QTD'#13#10 // 16

      + ', CUPOM_QTD_LINS_FINAL'#13#10 // 17

      + ', SEMPRE_OFFLINE'#13#10 // 18
      + ', ATIVO'#13#10 // 19
      + ' FROM TERMINAL'#13#10 // 13
      + 'WHERE TERMINAL_ID > 0'#13#10 // 13
      ;

    if pNomeDaMaquina <> '' then
      sSql := sSql + 'AND NOME_NA_REDE=' + pNomeDaMaquina.QuotedString
        + #13#10 //
        ;

    sSql := sSql + 'ORDER BY TERMINAL_ID'#13#10; //

    pDBConnection.QueryDataSet(sSql, Q);
    while not Q.Eof do
    begin
      oTerminal := TerminalCreate;
      pTerminalList.Add(oTerminal);

      DataSetToTerminal(Q, oTerminal, pAppObj);

      Q.Next;
    end;
  finally
    pDBConnection.Fechar;
  end;
end;

procedure DataSetToTerminal(Q: TDataSet; pTerminal: ITerminal;
  pAppObj: IAppObj);
var
  sLetraDoDrive: string;
  sNomeArq: string;
  sFormat: string;
  sPasta: string;
  sAtiv: string;
  iTerm: TTerminalId;
begin
  pTerminal.TerminalId := Q.FieldByName('TERMINAL_ID').AsInteger;

  pTerminal.Apelido := Trim(Q.FieldByName('APELIDO').AsString);
  pTerminal.NomeNaRede := Trim(Q.FieldByName('NOME_NA_REDE').AsString);
  pTerminal.IP := Trim(Q.FieldByName('IP').AsString);

  sLetraDoDrive := Q.FieldByName('LETRA_DO_DRIVE').AsString.Trim;
  if sLetraDoDrive = '' then
    sLetraDoDrive := 'C';
  pTerminal.LetraDoDrive := sLetraDoDrive[1];

  pTerminal.NFSerie := Q.FieldByName('NF_SERIE').AsInteger;

  pTerminal.GavetaTem := Q.FieldByName('GAVETA_TEM').AsBoolean;
  pTerminal.GavetaComando := Q.FieldByName('GAVETA_').AsString.Trim;
  pTerminal.GavetaImprNome := Q.FieldByName('GAVETA_').AsString.Trim;

  pTerminal.BalancaModoUsoId := Q.FieldByName('BALANCA_MODO_ID').AsInteger;
  pTerminal.BalancaModoUsoDescr := Q.FieldByName('BALANCA_').AsString.Trim;

  pTerminal.BalancaId := Q.FieldByName('BALANCA_ID').AsInteger;
  pTerminal.BalancaFabricante := Q.FieldByName('BALANCA_').AsString.Trim;
  pTerminal.BalancaModelo := Q.FieldByName('BALANCA_').AsString.Trim;

  pTerminal.BarCodigoIni := Q.FieldByName('BARRAS_COD_INI').AsInteger;
  pTerminal.BarCodigoTam := Q.FieldByName('BARRAS_COD_TAM').AsInteger;

  pTerminal.CupomQtdLinsFinal := Q.FieldByName('CUPOM_NLINS_FINAL').AsInteger;
  pTerminal.SempreOffLine := Q.FieldByName('SEMPRE_OFFLINE').AsBoolean;

  pTerminal.ImpressoraModoEnvioId := Q.FieldByName('IMPRESSORA_').AsInteger;
  pTerminal.ImpressoraModoEnvioDescr := Q.FieldByName('IMPRESSORA_').AsString.Trim;

  pTerminal.ImpressoraModeloId := Q.FieldByName('IMPRESSORA_').AsInteger;
  pTerminal.ImpressoraModeloDescr := Q.FieldByName('IMPRESSORA_').AsString.Trim;
  pTerminal.ImpressoraNome := Q.FieldByName('IMPRESSORA_').AsString.Trim;
  pTerminal.ImpressoraColsQtd := Q.FieldByName('IMPRESSORA_').AsInteger;

  pTerminal.CupomQtdLinsFinal := Q.FieldByName('IMPRESSORA_').AsInteger;
  pTerminal.SempreOffLine := Q.FieldByName('GAVETA_TEM').AsBoolean;
  pTerminal.Ativo := Q.FieldByName('GAVETA_TEM').AsBoolean;


  sFormat := '%sDados_%s_Terminal_%.3d.fdb';
  sPasta := pAppObj.AppInfo.PastaDados;
  sAtiv := AtividadeEconomicaSisDescr[pAppObj.AppInfo.AtividadeEconomicaSis];
  iTerm := pTerminal.TerminalId;

  sNomeArq := Format(sFormat, [sPasta, sAtiv, iTerm]);
  sNomeArq[1] := pTerminal.LetraDoDrive[1];

  pTerminal.LocalArqDados := sNomeArq;
  pTerminal.Database := pTerminal.NomeNaRede + ':' + sNomeArq;

end;

end.

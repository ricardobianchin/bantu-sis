unit Sis.Terminal.Utils_u;

interface

uses Data.DB, Sis.Terminal;

procedure DataSetToTerminal(Q: TDataSet; pTerminal: ITerminal;
  pPastaDados, pAtivDescr: string);

function GetTermLocalArqDados(pPastaDados: string; pTerminalId: SmallInt; pAtivDescr: string): string;

implementation

uses Sis.Entities.Types, System.SysUtils;

function GetTermLocalArqDados(pPastaDados: string; pTerminalId: SmallInt; pAtivDescr: string): string;
var
  sLetraDoDrive: string;
  sFormat: string;
begin
  sFormat := '%sDados_%s_Terminal_%.3d.fdb';

  Result := Format(sFormat, [pPastaDados, pAtivDescr, pTerminalId]);
end;

procedure DataSetToTerminal(Q: TDataSet; pTerminal: ITerminal;
  pPastaDados, pAtivDescr: string);
var
  sLetraDoDrive: string;
  sNomeArq: string;
  sFormat: string;
  sPasta: string;
  iTerm: TTerminalId;
  oFieldLetraDrive: TField;
begin
  pTerminal.TerminalId := Q.FieldByName('TERMINAL_ID').AsInteger;

  pTerminal.Apelido := Trim(Q.FieldByName('APELIDO').AsString);
  pTerminal.NomeNaRede := Trim(Q.FieldByName('NOME_NA_REDE').AsString);
  pTerminal.IP := Trim(Q.FieldByName('IP').AsString);

  oFieldLetraDrive := Q.FindField('LETRA_DO_DRIVE');
  if not Assigned(oFieldLetraDrive) then
    oFieldLetraDrive := Q.FindField('LETRADRIVE');

  sLetraDoDrive := oFieldLetraDrive.AsString.Trim;
  if sLetraDoDrive = '' then
    sLetraDoDrive := 'C';
  pTerminal.LetraDoDrive := sLetraDoDrive[1];

  pTerminal.NFSerie := Q.FieldByName('NF_SERIE').AsInteger;

  pTerminal.GavetaTem := Q.FieldByName('GAVETA_TEM').AsBoolean;
  pTerminal.GavetaComando := Q.FieldByName('GAVETA_COMANDO').AsString.Trim;
  pTerminal.GavetaImprNome := Q.FieldByName('GAVETA_IMPR_NOME').AsString.Trim;

  pTerminal.BalancaModoUsoId := Q.FieldByName('BALANCA_MODO_USO_ID').AsInteger;
  pTerminal.BalancaModoUsoDescr := Q.FieldByName('BALANCA_MODO_USO_DESCR')
    .AsString.Trim;

  pTerminal.BalancaId := Q.FieldByName('BALANCA_ID').AsInteger;
  pTerminal.BalancaFabrModelo := Q.FieldByName('BALANCA_FABR_MODELO')
    .AsString.Trim;

  pTerminal.BarCodigoIni := Q.FieldByName('BARRAS_COD_INI').AsInteger;
  pTerminal.BarCodigoTam := Q.FieldByName('BARRAS_COD_TAM').AsInteger;

  pTerminal.ImpressoraModoEnvioId := Q.FieldByName('IMPRESSORA_MODO_ENVIO_ID')
    .AsInteger;
  pTerminal.ImpressoraModoEnvioDescr :=
    Q.FieldByName('IMPRESSORA_MODO_ENVIO_DESCR').AsString.Trim;

  pTerminal.ImpressoraModeloId := Q.FieldByName('IMPRESSORA_MODELO_ID')
    .AsInteger;
  pTerminal.ImpressoraModeloDescr := Q.FieldByName('IMPRESSORA_MODELO_DESCR')
    .AsString.Trim;
  pTerminal.ImpressoraNome := Q.FieldByName('IMPRESSORA_NOME').AsString.Trim;
  pTerminal.ImpressoraColsQtd := Q.FieldByName('IMPRESSORA_COLS_QTD').AsInteger;
  if pTerminal.ImpressoraColsQtd = 0 then
    pTerminal.ImpressoraColsQtd := 40;

  pTerminal.CupomQtdLinsFinal := Q.FieldByName('CUPOM_QTD_LINS_FINAL')
    .AsInteger;
  pTerminal.SempreOffLine := Q.FieldByName('SEMPRE_OFFLINE').AsBoolean;
  pTerminal.Ativo := Q.FieldByName('ATIVO').AsBoolean;

  pTerminal.BALANCA_PORTA := Q.FieldByName('BALANCA_PORTA').AsInteger;
  pTerminal.BALANCA_BAUDRATE := Q.FieldByName('BALANCA_BAUDRATE').AsInteger;
  pTerminal.BALANCA_DATABITS := Q.FieldByName('BALANCA_DATABITS').AsInteger;
  pTerminal.BALANCA_PARIDADE := Q.FieldByName('BALANCA_PARIDADE').AsInteger;
  pTerminal.BALANCA_STOPBITS := Q.FieldByName('BALANCA_STOPBITS').AsInteger;
  pTerminal.BALANCA_HANDSHAKING := Q.FieldByName('BALANCA_HANDSHAKING')
    .AsInteger;

  if pPastaDados = '' then
    exit;

  sFormat := '%sDados_%s_Terminal_%.3d.fdb';
  sPasta := pPastaDados;
  iTerm := pTerminal.TerminalId;

  sNomeArq := Format(sFormat, [sPasta, pAtivDescr, iTerm]);
  sNomeArq[1] := pTerminal.LetraDoDrive[1];

  pTerminal.LocalArqDados := sNomeArq;
  pTerminal.Database := pTerminal.NomeNaRede + ':' + sNomeArq;
end;

end.

unit App.UI.Form.Config.Ambi.Terminal.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.Types.Integers,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Mask, CustomEditBtu, CustomNumEditBtu,
  NumEditBtu;

type
  TTerminalEdDiagForm = class(TDiagBtnBasForm)
    ObjetivoLabel: TLabel;
    TerminalIdTitLabel: TLabel;
    TerminalIdEdit: TEdit;
    ApelidoLabel: TLabel;
    ApelidoEdit: TEdit;
    BalloonHint1: TBalloonHint;
    ApelidoAjudaLabel: TLabel;
    NomeNaRedeLabel: TLabel;
    NomeNaRedeEdit: TEdit;
    LetraDoDriveLabel: TLabel;
    LetraDoDriveAjudaLabel: TLabel;
    LetraDoDriveComboBox: TComboBox;
    NFSerieEdit: TEdit;
    NFSerieLabel: TLabel;
    NFSerieAjudaLabel: TLabel;
    BalancaGroupBox: TGroupBox;
    BalancaModoUsoLabel: TLabel;
    BalancaAjudaLabel: TLabel;
    BalModoUsoComboBox: TComboBox;
    BalancaLabel: TLabel;
    BalComboBox: TComboBox;
    BarCodigoGroupBox: TGroupBox;
    BarCodigoIniEdit: TEdit;
    BarCodigoIniLabel: TLabel;
    BarCodigoTamEdit: TEdit;
    BarCodigoTamLabel: TLabel;
    SempreOffLineCheckBox: TCheckBox;
    BarCodigoAjudaLabel: TLabel;
    TerminalIdObrigatorioLabel: TLabel;
    NomeNaRedeAjudaLabel: TLabel;
    IPLabel: TLabel;
    IPEdit: TEdit;
    AtivoCheckBox: TCheckBox;
    GavetaGroupBox: TGroupBox;
    GavTemCheckBox: TCheckBox;
    GavComandoEdit: TEdit;
    GavComandoLabel: TLabel;
    ImpressoraGroupBox: TGroupBox;
    ImprModoEnvioComboBox: TComboBox;
    GavComandoToolBar: TToolBar;
    GavetaCopiarToolButton: TToolButton;
    GavetaColarToolButton: TToolButton;
    GavetaTestarToolButton: TToolButton;
    GavImprNomeLabel: TLabel;
    GavImprNomeEdit: TEdit;
    Label1: TLabel;
    ImprNomeEdit: TEdit;
    Label2: TLabel;
    ImprModoEnvioLabel: TLabel;
    ImprModeloComboBox: TComboBox;
    ImprModeloLabel: TLabel;
    ImprQtdColunasEdit: TEdit;
    ImprQtdColunasLabel: TLabel;
    CupomQtdLinsFinal1Label: TLabel;
    CupomQtdLinsFinal2Label: TLabel;
    CupomQtdLinsFinalEdit: TEdit;
    Label3: TLabel;

    BaudRateLabel: TLabel;
    DataBitsLabel: TLabel;
    ParidadeLabel: TLabel;
    StopBitsLabel: TLabel;
    HandShakingLabel: TLabel;

    BalPortaComboBox: TComboBox;
    BaudRateComboBox: TComboBox;
    DataBitsComboBox: TComboBox;
    ParidadeComboBox: TComboBox;
    StopBitsComboBox: TComboBox;
    HandShakingComboBox: TComboBox;

    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure TerminalIdEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomeNaRedeEditKeyPress(Sender: TObject; var Key: Char);
    procedure SempreOffLineCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure BalModoUsoComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure BarCodigoIniEditKeyPress(Sender: TObject; var Key: Char);
    procedure BarCodigoTamEditKeyPress(Sender: TObject; var Key: Char);
    procedure NFSerieEditKeyPress(Sender: TObject; var Key: Char);
    procedure LetraDoDriveComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure GavTemCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure IPEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImprModoEnvioComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure GavetaComandoCopiarToolButtonClick(Sender: TObject);
    procedure CavetaComandoColarToolButtonClick(Sender: TObject);
    procedure GavComandoEditKeyPress(Sender: TObject; var Key: Char);
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure BalComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure GavImprNomeEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImprModeloComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ImprQtdColunasEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImprNomeEditKeyPress(Sender: TObject; var Key: Char);
    procedure CupomQtdLinsFinalEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FTerminaisDataSet: TDataSet;
    FState: TDataSetState;

    procedure Zerar;

    function TerminaIdOk: Boolean;
    function NomeNaRedeOk: Boolean;

    procedure Gravar;

    procedure ControlesToDataSet;
    procedure DataSetToControles;

    function TerminalIdMaior: integer;
    function TerminaIdTem(pTerminalId: integer): Boolean;

    procedure AjudaHintsAjuste;
    procedure LetraDoDriveComboPreencha;
    procedure BalComboBoxPreencha;
    procedure BalModoUsoComboBoxPreencha;

    procedure PosicioneLetraDoDrive(pText: string);

  protected
    procedure AjusteControles; override;
    function PodeOk: Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTerminaisDataSet: TDataSet;
      pDataSetState: TDataSetState); reintroduce;
  end;

var
  TerminalEdDiagForm: TTerminalEdDiagForm;

implementation

{$R *.dfm}

uses System.Math, Sis.Types.Utils_u, Sis.Types.strings_u, Sis.Win.Utils_u,
  Sis.UI.ImgDM, Sis.UI.IO.Serial.Utils_u;

{ TTerminalEdDiagForm }

procedure TTerminalEdDiagForm.AjudaHintsAjuste;
var
  s: string;
begin
  s := 'Pode ser deixado em branco.' +
    ' É um apelido ou número que ajude a identificar o terminal.';
  ApelidoAjudaLabel.Hint := WrapText(s);

  s := 'Letra do Drive no terminal onde o sistema'#13#10 +
    'foi instalado. Geralmente C:';
  LetraDoDriveAjudaLabel.Hint := WrapText(s);

  s := 'Série das notas fiscais eletrônicas emitidas neste terminal. Deixando zero, será usado o mesmo número do Código do Terminal. Geralmente é deixado, mesmo, como zero';
  NFSerieAjudaLabel.Hint := WrapText(s);

  s := 'Modo em que o sistema receberá o peso do item vendido. Não se refere à balança que imprime etiquetas';
  BalancaAjudaLabel.Hint := WrapText(s);

  s := 'As etiquetas de peso tem o código do produto dentro do código de barras. Aqui você indica a casa do código de barras onde inicia o código do produto e quantas casas ele ocupa';
  BarCodigoAjudaLabel.Hint := WrapText(s);

  s := 'Ou o ''Nome na Rede'' ou o IP devem ser preenchidos. Ou ambos. IP pode ser IPv4 ou IPv6';
  NomeNaRedeAjudaLabel.Hint := s;
end;

procedure TTerminalEdDiagForm.AjusteControles;
var
  i: integer;
begin
  inherited;
  AjudaHintsAjuste;
  LetraDoDriveComboPreencha;
  BalComboBoxPreencha;
  BalModoUsoComboBoxPreencha;

  if FState = dsInsert then
  begin
    Zerar;
    ObjetivoLabel.Caption := 'Inserindo Terminal';

    TerminalIdEdit.Enabled := True;

    i := TerminalIdMaior + 1;
    TerminalIdEdit.Text := i.ToString;
  end
  else
  begin
    DataSetToControles;
    ObjetivoLabel.Caption := 'Alterando Terminal ' + TerminalIdEdit.Text;

    TerminalIdEdit.Enabled := False;
  end;
end;

procedure TTerminalEdDiagForm.ApelidoEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    NomeNaRedeEdit.SetFocus;
    exit;
  end;
  inherited;

end;

procedure TTerminalEdDiagForm.AtivoCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    OkAct_Diag.Execute;
    exit;
  end;
end;

procedure TTerminalEdDiagForm.BalComboBoxPreencha;
begin
  BalComboBox.Items.Clear;
  // BalComboBox add ini
  BalComboBox.Items.Add('NAO INDICADO'); // 0 - balNenhum
  BalComboBox.Items.Add('FILIZOLA'); // 1 - balFilizola
  BalComboBox.Items.Add('TOLEDO'); // 2 - balToledo
  BalComboBox.Items.Add('TOLEDO2090'); // 3 - balToledo2090
  BalComboBox.Items.Add('TOLEDO2180'); // 4 - balToledo2180
  BalComboBox.Items.Add('URANO'); // 5 - balUrano
  BalComboBox.Items.Add('LUCASTEC'); // 6 - balLucasTec
  BalComboBox.Items.Add('MAGNA'); // 7 - balMagna
  BalComboBox.Items.Add('DIGITRON'); // 8 - balDigitron
  BalComboBox.Items.Add('MAGELLAN'); // 9 - balMagellan
  BalComboBox.Items.Add('URANOPOP'); // 10 - balUranoPOP
  BalComboBox.Items.Add('LIDER'); // 11 - balLider
  BalComboBox.Items.Add('RINNERT'); // 12 - balRinnert
  BalComboBox.Items.Add('MULLER'); // 13 - balMuller
  BalComboBox.Items.Add('SATURNO'); // 14 - balSaturno
  BalComboBox.Items.Add('AFTS'); // 15 - balAFTS
  BalComboBox.Items.Add('GENERICA'); // 16 - balGenerica
  BalComboBox.Items.Add('LIBRATEK'); // 17 - balLibratek
  BalComboBox.Items.Add('MICHELETTI'); // 18 - balMicheletti
  BalComboBox.Items.Add('ALFA'); // 19 - balAlfa
  BalComboBox.Items.Add('TOLEDO9091_8530_8540'); // 20 - balToledo9091_8530_8540
  BalComboBox.Items.Add('WEIGHTECHWT1000'); // 21 - balWeightechWT1000
  BalComboBox.Items.Add('MARELCG62XL'); // 22 - balMarelCG62XL
  BalComboBox.Items.Add('WEIGHTECHWT3000_ABS'); // 23 - balWeightechWT3000_ABS
  BalComboBox.Items.Add('TOLEDO2090N'); // 24 - balToledo2090N
  BalComboBox.Items.Add('TOLEDOBCS21'); // 25 - balToledoBCS21
  BalComboBox.Items.Add('PRECISION'); // 26 - balPrecision
  BalComboBox.Items.Add('DIGITRON_UL'); // 27 - balDigitron_UL
  BalComboBox.Items.Add('LIBRATEKWT3000IR'); // 28 - balLibratekWT3000IR
  BalComboBox.Items.Add('TOLEDOTI420'); // 29 - balToledoTi420
  BalComboBox.Items.Add('WEIGHTECHWT27R_ETH'); // 30 - balWeightechWT27R_ETH
  BalComboBox.Items.Add('CAPITAL'); // 31 - balCapital
  BalComboBox.Items.Add('MARTE'); // 32 - balMarte
  BalComboBox.Items.Add('LENKELK2500'); // 33 - balLenkeLK2500
  BalComboBox.Items.Add('WEIGHTRUTEST'); // 34 - balWeighTRUTest
  BalComboBox.Items.Add('URANOUDC'); // 35 - balUranoUDC
  BalComboBox.Items.Add('SICILIANO'); // 36 - balSiciliano
  // BalComboBox add fim
end;

procedure TTerminalEdDiagForm.BalModoUsoComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    if BalComboBox.Visible then
      BalComboBox.SetFocus
    else
      BarCodigoIniEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.BalComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    BarCodigoIniEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.BalModoUsoComboBoxPreencha;
begin
  BalModoUsoComboBox.Items.Clear;

  BalModoUsoComboBox.Items.Add('SEM BALANCA');
  BalModoUsoComboBox.Items.Add('BALANCA CONECTADA');
  BalModoUsoComboBox.Items.Add
    ('BALANCA NAO CONECTADA. O USUARIO VAI DIGITAR O PESO');
  BalModoUsoComboBox.Items.Add
    ('O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO');
end;

procedure TTerminalEdDiagForm.BarCodigoIniEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    BarCodigoTamEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.BarCodigoTamEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    GavTemCheckBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.CavetaComandoColarToolButtonClick
  (Sender: TObject);
begin
  inherited;
  GavComandoEdit.Text := GetClipboardText;
end;

procedure TTerminalEdDiagForm.GavetaComandoCopiarToolButtonClick
  (Sender: TObject);
begin
  inherited;
  SetClipboardText(GavComandoEdit.Text);
end;

procedure TTerminalEdDiagForm.GavImprNomeEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    GavComandoEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.GavComandoEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    ImprModoEnvioComboBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ControlesToDataSet;
var
  i: integer;
  s: string;
begin
  i := StrToInteger(TerminalIdEdit.Text);
  FTerminaisDataSet.FieldByName('TERMINAL_ID').AsInteger := i;

  FTerminaisDataSet.FieldByName('APELIDO').AsString := ApelidoEdit.Text;
  FTerminaisDataSet.FieldByName('NOME_NA_REDE').AsString := NomeNaRedeEdit.Text;
  FTerminaisDataSet.FieldByName('IP').AsString := IPEdit.Text;
  FTerminaisDataSet.FieldByName('LETRA_DO_DRIVE').AsString :=
    LetraDoDriveComboBox.Text;

  i := StrToInteger(NFSerieEdit.Text);
  NFSerieEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('NF_SERIE').AsInteger := i;

  FTerminaisDataSet.FieldByName('GAVETA_TEM').AsBoolean :=
    GavTemCheckBox.Checked;
  FTerminaisDataSet.FieldByName('GAVETA_COMANDO').AsString :=
    GavComandoEdit.Text;
  FTerminaisDataSet.FieldByName('GAVETA_IMPR_NOME').AsString :=
    Trim(GavImprNomeEdit.Text);

  FTerminaisDataSet.FieldByName('BALANCA_MODO_USO_ID').AsInteger :=
    BalModoUsoComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_MODO_USO_DESCR').AsString :=
    Trim(BalModoUsoComboBox.Text);

  FTerminaisDataSet.FieldByName('BALANCA_ID').AsInteger :=
    BalComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_FABR_MODELO').AsString :=
    BalComboBox.Text;

  i := StrToInteger(BarCodigoIniEdit.Text);
  BarCodigoIniEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('BARRAS_COD_INI').AsInteger := i;

  i := StrToInteger(BarCodigoTamEdit.Text);
  BarCodigoTamEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('BARRAS_COD_TAM').AsInteger := i;

  i := ImprModoEnvioComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('IMPRESSORA_MODO_ENVIO_ID').AsInteger := i;

  s := ImprModoEnvioComboBox.Text;
  FTerminaisDataSet.FieldByName('IMPRESSORA_MODO_ENVIO_DESCR').AsString := s;

  i := ImprModeloComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('IMPRESSORA_MODELO_ID').AsInteger := i;

  s := ImprModeloComboBox.Text;
  FTerminaisDataSet.FieldByName('IMPRESSORA_MODELO_DESCR').AsString := s;

  s := Trim(ImprNomeEdit.Text);
  FTerminaisDataSet.FieldByName('IMPRESSORA_NOME').AsString := s;

  i := StrToInteger(ImprQtdColunasEdit.Text);
  ImprQtdColunasEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('IMPRESSORA_COLS_QTD').AsInteger := i;

  i := StrToInteger(CupomQtdLinsFinalEdit.Text);
  FTerminaisDataSet.FieldByName('CUPOM_QTD_LINS_FINAL').AsInteger := i;

  // FTerminaisDataSet.FieldByName('CAMINHO_DE_REDE_DO_SISTEMA').AsString := LetraDoDriveComboBox.Text;

  FTerminaisDataSet.FieldByName('SEMPRE_OFFLINE').AsBoolean :=
    SempreOffLineCheckBox.Checked;
  FTerminaisDataSet.FieldByName('ATIVO').AsBoolean := AtivoCheckBox.Checked;

  FTerminaisDataSet.FieldByName('BALANCA_PORTA').AsInteger :=
    BalPortaComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_BAUDRATE').AsInteger :=
    BaudRateComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_DATABITS').AsInteger :=
    DataBitsComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_PARIDADE').AsInteger :=
    ParidadeComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_STOPBITS').AsInteger :=
    StopBitsComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_HANDSHAKING').AsInteger :=
    HandShakingComboBox.ItemIndex;

end;

constructor TTerminalEdDiagForm.Create(AOwner: TComponent;
  pTerminaisDataSet: TDataSet; pDataSetState: TDataSetState);
begin
  inherited Create(AOwner);
  FTerminaisDataSet := pTerminaisDataSet;
  FState := pDataSetState;
//  NomeNaRedeEdit.Text := 'TERM1';

  PortaSLPreencher(BalPortaComboBox.Items);
end;

procedure TTerminalEdDiagForm.CupomQtdLinsFinalEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    NFSerieEdit.SetFocus;
    exit;
  end;
  inherited;

end;

procedure TTerminalEdDiagForm.DataSetToControles;
var
  i: integer;
begin
  i := FTerminaisDataSet.FieldByName('TERMINAL_ID').AsInteger;
  TerminalIdEdit.Text := i.ToString;

  ApelidoEdit.Text := Trim(FTerminaisDataSet.FieldByName('APELIDO').AsString);
  NomeNaRedeEdit.Text := Trim(FTerminaisDataSet.FieldByName('NOME_NA_REDE')
    .AsString);
  IPEdit.Text := Trim(FTerminaisDataSet.FieldByName('IP').AsString);
  PosicioneLetraDoDrive(FTerminaisDataSet.FieldByName('LETRA_DO_DRIVE')
    .AsString);

  i := FTerminaisDataSet.FieldByName('NF_SERIE').AsInteger;
  NFSerieEdit.Text := i.ToString;

  GavTemCheckBox.Checked := FTerminaisDataSet.FieldByName('GAVETA_TEM')
    .AsBoolean;
  GavComandoEdit.Text := FTerminaisDataSet.FieldByName
    ('GAVETA_COMANDO').AsString;
  GavImprNomeEdit.Text := FTerminaisDataSet.FieldByName
    ('GAVETA_IMPR_NOME').AsString;

  BalModoUsoComboBox.ItemIndex := FTerminaisDataSet.FieldByName
    ('BALANCA_MODO_USO_ID').AsInteger;

  BalComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_ID')
    .AsInteger;

  i := FTerminaisDataSet.FieldByName('BARRAS_COD_INI').AsInteger;
  BarCodigoIniEdit.Text := i.ToString;

  i := FTerminaisDataSet.FieldByName('BARRAS_COD_TAM').AsInteger;
  BarCodigoTamEdit.Text := i.ToString;

  i := FTerminaisDataSet.FieldByName('IMPRESSORA_MODO_ENVIO_ID').AsInteger;
  ImprModoEnvioComboBox.ItemIndex := i;

  i := FTerminaisDataSet.FieldByName('IMPRESSORA_MODELO_ID').AsInteger;
  ImprModeloComboBox.ItemIndex := i;

  ImprNomeEdit.Text := FTerminaisDataSet.FieldByName('IMPRESSORA_NOME')
    .AsString;

  i := FTerminaisDataSet.FieldByName('IMPRESSORA_COLS_QTD').AsInteger;
  ImprQtdColunasEdit.Text := i.ToString;

  i := FTerminaisDataSet.FieldByName('CUPOM_QTD_LINS_FINAL').AsInteger;
  CupomQtdLinsFinalEdit.Text := i.ToString;

  SempreOffLineCheckBox.Checked := FTerminaisDataSet.FieldByName
    ('SEMPRE_OFFLINE').AsBoolean;

  AtivoCheckBox.Checked := FTerminaisDataSet.FieldByName('ATIVO').AsBoolean;

  BalPortaComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_PORTA').AsInteger;
  BaudRateComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_BAUDRATE').AsInteger;
  DataBitsComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_DATABITS').AsInteger;
  ParidadeComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_PARIDADE').AsInteger;
  StopBitsComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_STOPBITS').AsInteger;
  HandShakingComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_HANDSHAKING').AsInteger;

end;

procedure TTerminalEdDiagForm.ImprModeloComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    ImprQtdColunasEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ImprModoEnvioComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    ImprModoEnvioComboBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ImprNomeEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    CupomQtdLinsFinalEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ImprQtdColunasEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    ImprNomeEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.IPEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    SempreOffLineCheckBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.GavTemCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    GavImprNomeEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.Gravar;
begin
  if FState = dsInsert then
  begin
    FTerminaisDataSet.Append;
  end
  else
  begin
    FTerminaisDataSet.Edit;
  end;
  ControlesToDataSet;
end;

procedure TTerminalEdDiagForm.LetraDoDriveComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    GavTemCheckBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.LetraDoDriveComboPreencha;
var
  c: Char;
  s: string;
begin
  LetraDoDriveComboBox.ItemIndex := -1;
  LetraDoDriveComboBox.Text := '';
  LetraDoDriveComboBox.Items.Clear;

  for c := 'A' to 'Z' do
  begin
    s := c + ':';
    LetraDoDriveComboBox.Items.Add(s);
  end;
end;

procedure TTerminalEdDiagForm.NFSerieEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    LetraDoDriveComboBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.NomeNaRedeEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    IPEdit.SetFocus;
    exit;
  end;
  CharSemAcento(Key);
  inherited;
end;

function TTerminalEdDiagForm.NomeNaRedeOk: Boolean;
var
  sNome, sIP: string;
  sTit: string;
begin
  Result := ActiveControl = CancelBitBtn_DiagBtn;
  if Result then
    exit;

  Result := ActiveControl = MensCopyBitBtn_DiagBtn;
  if Result then
    exit;

  sTit := NomeNaRedeLabel.Caption;
  sNome := Trim(NomeNaRedeEdit.Text);
  sIP := Trim(IPEdit.Text);

  NomeNaRedeEdit.Text := sNome;
  IPEdit.Text := sIP;

  Result := (sNome <> '') or (sIP <> '');
  if not Result then
  begin
    ErroOutput.Exibir
      ('Ou o ''Nome na Rede'' ou o ''IP'' devem ser preenchidos');
    NomeNaRedeEdit.SetFocus;
  end;
end;

procedure TTerminalEdDiagForm.TerminalIdEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    ApelidoEdit.SetFocus;
    exit;
  end;
  inherited;
end;

function TTerminalEdDiagForm.TerminalIdMaior: integer;
var
  b: TBookmark;
  Tab: TDataSet;
begin
  Result := 0;
  Tab := FTerminaisDataSet;
  b := Tab.GetBookmark;
  Tab.DisableControls;
  try

    Tab.First;
    while not Tab.Eof do
    begin
      Result := Max(Result, Tab.FieldByName('TERMINAL_ID').AsInteger);
      Tab.Next;
    end;
  finally
    Tab.GotoBookmark(b);
    Tab.FreeBookmark(b);
    Tab.EnableControls;
  end;
end;

function TTerminalEdDiagForm.PodeOk: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := TerminaIdOk;
  if not Result then
    exit;

  Result := NomeNaRedeOk;
  if not Result then
    exit;

  Gravar;
end;

procedure TTerminalEdDiagForm.PosicioneLetraDoDrive(pText: string);
var
  c: Char;
  s: string;
  i: integer;
begin
  s := Trim(pText);
  if s = '' then
    s := 'C:';

  c := s[1];
  i := ord(c) - ord('A');
  LetraDoDriveComboBox.ItemIndex := i;
end;

procedure TTerminalEdDiagForm.SempreOffLineCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    BalModoUsoComboBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //
end;

function TTerminalEdDiagForm.TerminaIdOk: Boolean;
var
  i: integer;
  sTit: string;
  sMens: string;
begin
  Result := ActiveControl = CancelBitBtn_DiagBtn;
  if Result then
    exit;

  Result := ActiveControl = MensCopyBitBtn_DiagBtn;
  if Result then
    exit;

  Result := FState = dsEdit;
  if Result then
    exit;

  sTit := QuotedStr(Trim(TerminalIdTitLabel.Caption));

  try
    i := StrToInteger(TerminalIdEdit.Text);
    Result := i > 0;
    if not Result then
    begin
      sMens := sTit + ' deve ser maior do que zero';
      exit;
    end;

    Result := not TerminaIdTem(i);
    if not Result then
    begin
      sMens := 'Já existe um registro com este ' + sTit;
      exit;
    end;
  finally
    if not Result then
    begin
      ErroOutput.Exibir(sMens);
      TerminalIdEdit.SetFocus;
    end;
  end;
end;

function TTerminalEdDiagForm.TerminaIdTem(pTerminalId: integer): Boolean;
var
  b: TBookmark;
  Tab: TDataSet;
begin
  Result := False;
  Tab := FTerminaisDataSet;
  b := Tab.GetBookmark;
  Tab.DisableControls;
  try
    Tab.First;
    while not Tab.Eof do
    begin
      Result := Tab.FieldByName('TERMINAL_ID').AsInteger = pTerminalId;
      if Result then
        break;

      Tab.Next;
    end;
  finally
    Tab.GotoBookmark(b);
    Tab.FreeBookmark(b);
    Tab.EnableControls;
  end;
end;

procedure TTerminalEdDiagForm.Zerar;
begin
  TerminalIdEdit.Clear;
  ApelidoEdit.Clear;
  NomeNaRedeEdit.Clear;
  IPEdit.Clear;
  SempreOffLineCheckBox.Checked := False;

  ImprModoEnvioComboBox.ItemIndex := 0;
  BalModoUsoComboBox.ItemIndex := 0;
  BalComboBox.ItemIndex := 0;
  BalPortaComboBox.ItemIndex := 0;
  BaudRateComboBox.ItemIndex := 0;
  DataBitsComboBox.ItemIndex := 0;
  ParidadeComboBox.ItemIndex := 0;
  StopBitsComboBox.ItemIndex := 0;
  HandShakingComboBox.ItemIndex := 0;

  BarCodigoIniEdit.Text := '2';
  BarCodigoTamEdit.Text := '6';

  GavTemCheckBox.Checked := False;
  GavImprNomeEdit.Text := '';
  GavComandoEdit.Text := '';

  ImprModoEnvioComboBox.ItemIndex := 0;
  ImprModeloComboBox.ItemIndex := 0;
  // ImprQtdColunasEdit.Valor := 40;
  ImprNomeEdit.Text := '';

  CupomQtdLinsFinalEdit.Text := '0';
  NFSerieEdit.Clear;
  LetraDoDriveComboBox.ItemIndex := 2;
end;

end.

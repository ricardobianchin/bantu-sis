unit App.UI.Form.Config.Ambi.Terminal.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.Types.Integers;

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
    Label1: TLabel;
    LetraDoDriveAjudaLabel: TLabel;
    LetraDoDriveComboBox: TComboBox;
    NFSerieEdit: TEdit;
    NFSerieLabel: TLabel;
    NFSerieAjudaLabel: TLabel;
    GavetaTemCheckBox: TCheckBox;
    BalancaGroupBox: TGroupBox;
    BalancaModoLabel: TLabel;
    BalancaAjudaLabel: TLabel;
    BalancaModoComboBox: TComboBox;
    BalancaLabel: TLabel;
    BalancaComboBox: TComboBox;
    BarCodigoGroupBox: TGroupBox;
    BarCodigoIniEdit: TEdit;
    BarCodigoIniLabel: TLabel;
    BarCodigoTamEdit: TEdit;
    BarCodigoTamLabel: TLabel;
    CuponNLinsFinalEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    SempreOffLineCheckBox: TCheckBox;
    BarCodigoAjudaLabel: TLabel;
    TerminalIdObrigatorioLabel: TLabel;
    NomeNaRedeObrigatorioLabel: TLabel;
    procedure TerminalIdEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoEditKeyPress(Sender: TObject; var Key: Char);
    procedure BalancaModoComboBoxChange(Sender: TObject);
    procedure NomeNaRedeEditKeyPress(Sender: TObject; var Key: Char);
    procedure SempreOffLineCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure BalancaModoComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure BarCodigoIniEditKeyPress(Sender: TObject; var Key: Char);
    procedure BarCodigoTamEditKeyPress(Sender: TObject; var Key: Char);
    procedure NFSerieEditKeyPress(Sender: TObject; var Key: Char);
    procedure LetraDoDriveComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure GavetaTemCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CuponNLinsFinalEditKeyPress(Sender: TObject; var Key: Char);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FTerminaisDataSet: TDataSet;
    FState: TDataSetState;

    procedure Zerar;

    function TerminaIdOk: Boolean;
    function NomeNaRedeOk: Boolean;

    function EscolheuSemBalanca: boolean;

    procedure Gravar;

    procedure ControlesToDataSet;
    procedure DataSetToControles;

    function TerminalIdMaior: integer;
    function TerminaIdTem(pTerminalId: integer): Boolean;

    procedure AjudaHintsAjuste;
    procedure LetraDoDriveComboPreencha;
    procedure BalancaModoComboBoxPreencha;
    procedure BalancaComboBoxPreencha;

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

uses System.Math, Sis.Types.Utils_u, Sis.Types.strings_u;

{ TTerminalEdDiagForm }

procedure TTerminalEdDiagForm.AjudaHintsAjuste;
var
  s: string;
begin
  s := 'Pode ser deixado em branco.'+
    ' É um apelido ou número que ajude a identificar o terminal.';
  ApelidoAjudaLabel.Hint := WrapText(s);

  s :=
    'Letra do Drive no terminal onde o sistema'#13#10 +
    'foi instalado. Geralmente C:';
  LetraDoDriveAjudaLabel.Hint := WrapText(s);

  s :=  'Série das notas fiscais eletrônicas emitidas neste terminal. Deixando zero, será usado o mesmo número do Código do Terminal. Geralmente é deixado, mesmo, como zero';
  NFSerieAjudaLabel.Hint := WrapText(s);

  s := 'Modo em que o sistema receberá o peso do item vendido. Não se refere à balança que imprime etiquetas';
  BalancaAjudaLabel.Hint := WrapText(s);

  s := 'As etiquetas de peso tem o código do produto dentro do código de barras. Aqui você indica a casa do código de barras onde inicia o código do produto e quantas casas ele ocupa';
  BarCodigoAjudaLabel.Hint := WrapText(s);
end;

procedure TTerminalEdDiagForm.AjusteControles;
var
  i: integer;
begin
  inherited;
  AjudaHintsAjuste;
  LetraDoDriveComboPreencha;
  BalancaModoComboBoxPreencha;
  BalancaComboBoxPreencha;

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
    // OkAct_Diag.Execute;
    NomeNaRedeEdit.SetFocus;
    exit;
  end;
  inherited;

end;

procedure TTerminalEdDiagForm.BalancaComboBoxPreencha;
begin
  BalancaComboBox.Items.Clear;

  BalancaComboBox.Items.Add('SEM BALANCA');
  BalancaComboBox.Items.Add('FILIZOLA');
  BalancaComboBox.Items.Add('TOLEDO');
  BalancaComboBox.Items.Add('URANO');
  BalancaComboBox.Items.Add('ELGIN');
  BalancaComboBox.Items.Add('MAGNA');
end;

procedure TTerminalEdDiagForm.BalancaModoComboBoxChange(Sender: TObject);
var
  bVisivel: Boolean;
begin
  inherited;
  bVisivel := BalancaModoComboBox.ItemIndex = 1;
  BalancaLabel.Visible := bVisivel;
  BalancaComboBox.Visible := bVisivel;
end;

procedure TTerminalEdDiagForm.BalancaModoComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if BalancaComboBox.Visible then
    BalancaComboBox.SetFocus
  else
    BarCodigoIniEdit.SetFocus;
end;

procedure TTerminalEdDiagForm.BalancaModoComboBoxPreencha;
begin
  BalancaModoComboBox.Items.Clear;

  BalancaModoComboBox.Items.Add('SEM BALANCA');
  BalancaModoComboBox.Items.Add('BALANCA CONECTADA');
  BalancaModoComboBox.Items.Add('BALANCA NAO CONECTADA. O USUARIO VAI DIGITAR O PESO');
  BalancaModoComboBox.Items.Add('O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO');
end;

procedure TTerminalEdDiagForm.BarCodigoIniEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
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
    OkAct_Diag.Execute;
    //.SetFocus;
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

  i := StrToInteger(NFSerieEdit.Text);
  NFSerieEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('NF_SERIE').AsInteger := i;

  FTerminaisDataSet.FieldByName('LETRA_DO_DRIVE').AsString := LetraDoDriveComboBox.Text;

  FTerminaisDataSet.FieldByName('GAVETA_TEM').AsBoolean := GavetaTemCheckBox.Checked;

  FTerminaisDataSet.FieldByName('BALANCA_MODO_ID').AsInteger := BalancaModoComboBox.ItemIndex;
  FTerminaisDataSet.FieldByName('BALANCA_ID').AsInteger := BalancaComboBox.ItemIndex;

  if BalancaModoComboBox.ItemIndex = 1 then
    s := BalancaComboBox.Text
  else
    s := BalancaModoComboBox.Text;

  FTerminaisDataSet.FieldByName('BALANCA_DESCR').AsString := s;

  i := StrToInteger(BarCodigoIniEdit.Text);
  BarCodigoIniEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('BARRAS_COD_INI').AsInteger := i;

  i := StrToInteger(BarCodigoTamEdit.Text);
  BarCodigoTamEdit.Text := i.ToString;
  FTerminaisDataSet.FieldByName('BARRAS_COD_TAM').AsInteger := i;

  i := StrToInteger(CuponNLinsFinalEdit.Text);
  FTerminaisDataSet.FieldByName('CUPOM_NLINS_FINAL').AsInteger := i;

  //FTerminaisDataSet.FieldByName('CAMINHO_DE_REDE_DO_SISTEMA').AsString := LetraDoDriveComboBox.Text;

  FTerminaisDataSet.FieldByName('SEMPRE_OFFLINE').AsBoolean := SempreOffLineCheckBox.Checked;
end;

constructor TTerminalEdDiagForm.Create(AOwner: TComponent;
  pTerminaisDataSet: TDataSet; pDataSetState: TDataSetState);
begin
  inherited Create(AOwner);
  FTerminaisDataSet := pTerminaisDataSet;
  FState := pDataSetState;
  NomeNaRedeEdit.Text := 'TERM1';
end;

procedure TTerminalEdDiagForm.CuponNLinsFinalEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    BalancaModoComboBox.SetFocus;
    exit;
  end;

end;

procedure TTerminalEdDiagForm.DataSetToControles;
var
  i: integer;
begin
  i := FTerminaisDataSet.FieldByName('TERMINAL_ID').AsInteger;
  TerminalIdEdit.Text := i.ToString;

  ApelidoEdit.Text := Trim(FTerminaisDataSet.FieldByName('APELIDO').AsString);
  NomeNaRedeEdit.Text := Trim(FTerminaisDataSet.FieldByName('NOME_NA_REDE').AsString);

  i := FTerminaisDataSet.FieldByName('NF_SERIE').AsInteger;
  NFSerieEdit.Text := i.ToString;

  PosicioneLetraDoDrive(FTerminaisDataSet.FieldByName('LETRA_DO_DRIVE').AsString);

  GavetaTemCheckBox.Checked := FTerminaisDataSet.FieldByName('GAVETA_TEM').AsBoolean;

  BalancaModoComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_MODO_ID').AsInteger;

  BalancaComboBox.ItemIndex := FTerminaisDataSet.FieldByName('BALANCA_ID').AsInteger;

  i := FTerminaisDataSet.FieldByName('BARRAS_COD_INI').AsInteger;
  BarCodigoIniEdit.Text := i.ToString;

  i := FTerminaisDataSet.FieldByName('BARRAS_COD_TAM').AsInteger;
  BarCodigoTamEdit.Text := i.ToString;


  i := FTerminaisDataSet.FieldByName('CUPOM_NLINS_FINAL').AsInteger;
  CuponNLinsFinalEdit.Text := i.ToString;

  //FTerminaisDataSet.FieldByName('CAMINHO_DE_REDE_DO_SISTEMA').AsString := LetraDoDriveComboBox.Text;

  SempreOffLineCheckBox.Checked := FTerminaisDataSet.FieldByName('SEMPRE_OFFLINE').AsBoolean;
end;

function TTerminalEdDiagForm.EscolheuSemBalanca: boolean;
begin
  Result := BalancaModoComboBox.ItemIndex <> 1;
end;

procedure TTerminalEdDiagForm.GavetaTemCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // OkAct_Diag.Execute;
    CuponNLinsFinalEdit.SetFocus;
    exit;
  end;
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
    GavetaTemCheckBox.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.LetraDoDriveComboPreencha;
var
  c: char;
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
    SempreOffLineCheckBox.SetFocus;
    exit;
  end;
  CharSemAcento(Key);
  inherited;
end;

function TTerminalEdDiagForm.NomeNaRedeOk: Boolean;
var
  s: string;
  sTit: string;
begin
  Result := ActiveControl = CancelBitBtn_DiagBtn;
  if Result then
    exit;

  Result := ActiveControl = MensCopyBitBtn_DiagBtn;
  if Result then
    exit;

  sTit := NomeNaRedeLabel.Caption;
  s := Trim(NomeNaRedeEdit.Text);
  NomeNaRedeEdit.Text := s;
  Result := s <> '';
  if not Result then
  begin
    ErroOutput.Exibir(sTit + ' é obrigatório');
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
  c: char;
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
    // OkAct_Diag.Execute;
    NFSerieEdit.SetFocus;
    exit;
  end;
  inherited;
end;

procedure TTerminalEdDiagForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  OkAct_Diag.Execute;
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
  SempreOffLineCheckBox.Checked := False;
  NFSerieEdit.Clear;
  LetraDoDriveComboBox.ItemIndex := 2;
  GavetaTemCheckBox.Checked := False;
  CuponNLinsFinalEdit.Text := '0';
  BalancaModoComboBox.ItemIndex := 0;
  BalancaModoComboBoxChange(BalancaModoComboBox);
  BalancaComboBox.ItemIndex := 0;
  BarCodigoIniEdit.Text := '2';
  BarCodigoTamEdit.Text := '6';
end;

end.

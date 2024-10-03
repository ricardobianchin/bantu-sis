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
    Edit1: TEdit;
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
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    SempreOffLineCheckBox: TCheckBox;
    BarCodigoAjudaLabel: TLabel;
    procedure TerminalIdEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoEditKeyPress(Sender: TObject; var Key: Char);
    procedure BalancaModoComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    FTerminaisDataSet: TDataSet;
    FState: TDataSetState;

    procedure Zerar;
    procedure AjusteControles; override;

    function TerminaIdOk: Boolean;
    procedure Gravar;

    procedure ControlesToDataSet;
    procedure DataSetToControles;

    function TerminalIdMaior: integer;
    function TerminaIdTem(pTerminalId: integer): Boolean;

    procedure AjudaHintsAjuste;
    procedure LetraDoDriveComboPreencha;
    procedure BalancaModoComboBoxPreencha;
    procedure BalancaComboBoxPreencha;

  protected
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

uses System.Math, Sis.Types.Utils_u;

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

  s := 'Refere-se à balança contectada ao terminal, não à balança que imprime etiquetas';
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
    ObjetivoLabel.Caption := 'Inserindo Terminal';

    TerminalIdEdit.Enabled := True;

    Zerar;
    i := TerminalIdMaior + 1;
    TerminalIdEdit.Text := i.ToString;
  end
  else
  begin
    ObjetivoLabel.Caption := 'Alterando Terminal ' + TerminalIdEdit.Text;

    DataSetToControles;

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

procedure TTerminalEdDiagForm.BalancaModoComboBoxPreencha;
begin
  BalancaModoComboBox.Items.Clear;

  BalancaModoComboBox.Items.Add('SEM BALANCA');
  BalancaModoComboBox.Items.Add('BALANCA CONECTADA');
  BalancaModoComboBox.Items.Add('BALANCA NAO CONECTADA. O USUARIO VAI DIGITAR O PESO');
  BalancaModoComboBox.Items.Add('O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO');
end;

procedure TTerminalEdDiagForm.ControlesToDataSet;
var
  i: integer;
begin
  i := StrToInteger(TerminalIdEdit.Text);
  FTerminaisDataSet.FieldByName('TERMINAL_ID').AsInteger := i;

end;

constructor TTerminalEdDiagForm.Create(AOwner: TComponent;
  pTerminaisDataSet: TDataSet; pDataSetState: TDataSetState);
begin
  inherited Create(AOwner);
  FTerminaisDataSet := pTerminaisDataSet;
  FState := pDataSetState;
end;

procedure TTerminalEdDiagForm.DataSetToControles;
begin

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

  Gravar;
end;

function TTerminalEdDiagForm.TerminaIdOk: Boolean;
var
  i: integer;
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

  if FState = dsInsert then
  begin
    i := StrToInteger(TerminalIdEdit.Text);
    Result := not TerminaIdTem(i);
    if not Result then
      ErroOutput.Exibir('Já existe ' + TerminalIdTitLabel.Caption)
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
  end;
end;

procedure TTerminalEdDiagForm.Zerar;
begin
  TerminalIdEdit.Clear;
  ApelidoEdit.Clear;
  NomeNaRedeEdit.Clear;

  LetraDoDriveComboBox.ItemIndex := -1;
end;

end.

unit App.Pess.Ender.Controls.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, App.Pess.Ent, App.Pess.DBI, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Controls.Utils, App.PessEnder,
  Sis.UI.Controls.ComboBoxManager, Sis.Types.Integers, Vcl.Mask;

type
  TEnderControlsFrame = class(TBasFrame)
    LogradouroLabel: TLabel;
    LogradouroEdit: TEdit;
    TopoPanel: TPanel;
    EnderStatusLabel: TLabel;
    NumeroLabel: TLabel;
    NumeroEdit: TEdit;
    ComplementoLabel: TLabel;
    ComplementoEdit: TEdit;
    BairroLabel: TLabel;
    BairroEdit: TEdit;
    CEPLabel: TLabel;
    DDDLabel: TLabel;
    DDDEdit: TEdit;
    TelefonesLabel: TLabel;
    Fone1Edit: TEdit;
    Fone2Edit: TEdit;
    Fone3Edit: TEdit;
    ContatoLabel: TLabel;
    ContatoEdit: TEdit;
    ReferenciaLabel: TLabel;
    ReferenciaMemo: TMemo;
    UFSiglaLabel: TLabel;
    UFSiglaComboBox: TComboBox;
    MunicipioLabel: TLabel;
    MunicipioComboBox: TComboBox;
    UFSiglaStatusLabel: TLabel;
    CEPMaskEdit: TMaskEdit;
    MunicipioPrepareListaTimer: TTimer;
    procedure UFSiglaComboBoxChange(Sender: TObject);
    procedure UFSiglaComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure MunicipioComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure MunicipioPrepareListaTimerTimer(Sender: TObject);
    procedure ReferenciaMemoKeyPress(Sender: TObject; var Key: Char);
    procedure CEPMaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure BairroEditKeyPress(Sender: TObject; var Key: Char);
    procedure LogradouroEditKeyPress(Sender: TObject; var Key: Char);
    procedure NumeroEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComplementoEditKeyPress(Sender: TObject; var Key: Char);
    procedure DDDEditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone1EditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone2EditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone3EditKeyPress(Sender: TObject; var Key: Char);
    procedure ContatoEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FFDMemTable: TFDMemTable;

    UFSiglaComboMan: IComboBoxManager;
    MunComboMan: IComboBoxManager;

    FMunicipioPodePreparar: boolean;
    FCEPPodeConsultar: boolean;

    FOkExecute: TNotifyEvent;

    function CepDadosOk: boolean;


    procedure UFSiglaComboBoxAjuste;
    procedure MunicipioPrepareLista(pUFSigla: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable; pOkExecute: TNotifyEvent); reintroduce;
    procedure AjusteControles;
    procedure ControlesToEnt;
    procedure EntToControles;
    procedure Exiba;
    procedure Oculte;
    function DadosOk: boolean;
  end;

//var
//  EnderControlsFrame: TEnderControlsFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Factory, Sis.Types.Utils_u, Sis.Types.strings_u;
{ TEnderControlsFrame }

procedure TEnderControlsFrame.UFSiglaComboBoxAjuste;
begin
  UFSiglaComboBox.Items.Add('');
  UFSiglaComboBox.Items.AddObject('AC', Pointer(12));
  UFSiglaComboBox.Items.AddObject('AL', Pointer(27));
  UFSiglaComboBox.Items.AddObject('AM', Pointer(13));
  UFSiglaComboBox.Items.AddObject('AP', Pointer(16));
  UFSiglaComboBox.Items.AddObject('BA', Pointer(29));
  UFSiglaComboBox.Items.AddObject('CE', Pointer(23));
  UFSiglaComboBox.Items.AddObject('ES', Pointer(32));
  UFSiglaComboBox.Items.AddObject('MA', Pointer(21));
  UFSiglaComboBox.Items.AddObject('MG', Pointer(31));
  UFSiglaComboBox.Items.AddObject('MS', Pointer(50));
  UFSiglaComboBox.Items.AddObject('MT', Pointer(51));
  UFSiglaComboBox.Items.AddObject('PA', Pointer(15));
  UFSiglaComboBox.Items.AddObject('PE', Pointer(26));
  UFSiglaComboBox.Items.AddObject('PI', Pointer(22));
  UFSiglaComboBox.Items.AddObject('PR', Pointer(41));
  UFSiglaComboBox.Items.AddObject('RJ', Pointer(33));
  UFSiglaComboBox.Items.AddObject('RN', Pointer(24));
  UFSiglaComboBox.Items.AddObject('RO', Pointer(11));
  UFSiglaComboBox.Items.AddObject('RR', Pointer(14));
  UFSiglaComboBox.Items.AddObject('RS', Pointer(43));
  UFSiglaComboBox.Items.AddObject('SC', Pointer(42));
  UFSiglaComboBox.Items.AddObject('SE', Pointer(28));
  UFSiglaComboBox.Items.AddObject('SP', Pointer(35));
  UFSiglaComboBox.Items.AddObject('TO', Pointer(17));
end;

procedure TEnderControlsFrame.UFSiglaComboBoxChange(Sender: TObject);
begin
  inherited;
  MunicipioPrepareListaTimer.Enabled := False;
  MunicipioPrepareListaTimer.Enabled := True;;
end;

procedure TEnderControlsFrame.UFSiglaComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.BairroEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);

end;

function TEnderControlsFrame.CepDadosOk: boolean;
var
  L: integer;
  sText: string;
begin
//  sText := CEPMaskEdit.EditText;
//  sText := CEPMaskEdit.Text;

  sText := StrToOnlyDigit(CEPMaskEdit.Text);

  L := Length(sText);
  Result := (L = 0) or (L=8);
end;

procedure TEnderControlsFrame.CEPMaskEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);

end;

procedure TEnderControlsFrame.ComplementoEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.ContatoEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.ControlesToEnt;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FFDMemTable;

  Tab.Fields[7 {CEP}].AsString := CEPMaskEdit.Text;
  Tab.Fields[6 {UF_SIGLA}].AsString := UFSiglaComboMan.Text;

  Tab.Fields[5 {MUNICIPIO_NOME}].AsString := MunComboMan.Text;
  Tab.Fields[14 {MUNICIPIO_IBGE_ID}].AsString := IntToStrZero( MunComboMan.Id, 5);

  Tab.Fields[4 {BAIRRO}].AsString := BairroEdit.Text;
  Tab.Fields[1 {LOGRADOURO}].AsString := LogradouroEdit.Text;
  Tab.Fields[2 {NUMERO}].AsString := NumeroEdit.Text;
  Tab.Fields[3 {COMPLEMENTO}].AsString := ComplementoEdit.Text;
  Tab.Fields[8 {DDD}].AsString := DDDEdit.Text;
  Tab.Fields[9 {FONE1}].AsString := Fone1Edit.Text;
  Tab.Fields[10 {FONE2}].AsString := Fone2Edit.Text;
  Tab.Fields[11 {FONE3}].AsString := Fone3Edit.Text;
  Tab.Fields[12 {CONTATO}].AsString := ContatoEdit.Text;
  Tab.Fields[13 {REFERENCIA}].AsString := ReferenciaMemo.Lines.Text;
end;

constructor TEnderControlsFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable; pOkExecute: TNotifyEvent);
begin
  inherited Create(AOwner);
  FOkExecute := pOkExecute;

  FMunicipioPodePreparar := False;
  FCEPPodeConsultar := False;

  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FFDMemTable := pEnderPessFDMemTable;

  UFSiglaComboMan := ComboBoxManagerCreate(UFSiglaComboBox);
  MunComboMan := ComboBoxManagerCreate(MunicipioComboBox);

  UFSiglaComboBoxAjuste;
end;

function TEnderControlsFrame.DadosOk: boolean;
begin
  Result := CepDadosOk;
end;

procedure TEnderControlsFrame.DDDEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.EntToControles;
var
  Tab: TFDMemTable;
  iId: integer;
begin
  inherited;
  Tab := FFDMemTable;

  FCEPPodeConsultar := False;
  CEPMaskEdit.Text := Tab.Fields[7 {CEP}].AsString;
  FCEPPodeConsultar := True;

  FMunicipioPodePreparar := False;
  UFSiglaComboMan.Text := Trim(Tab.Fields[6 {UF_SIGLA}].AsString);
  FMunicipioPodePreparar := True;

  MunicipioPrepareLista(UFSiglaComboMan.Text);
  iId := StrToInteger(Tab.Fields[14 {MUNICIPIO_IBGE_ID}].AsString);
  MunComboMan.Id := iId;

  BairroEdit.Text := Tab.Fields[4 {BAIRRO}].AsString;
  LogradouroEdit.Text := Tab.Fields[1 {LOGRADOURO}].AsString;
  NumeroEdit.Text := Tab.Fields[2 {NUMERO}].AsString;
  ComplementoEdit.Text := Tab.Fields[3 {COMPLEMENTO}].AsString;
  DDDEdit.Text := Tab.Fields[8 {DDD}].AsString;
  Fone1Edit.Text := Tab.Fields[9 {FONE1}].AsString;
  Fone2Edit.Text := Tab.Fields[10 {FONE2}].AsString;
  Fone3Edit.Text := Tab.Fields[11 {FONE3}].AsString;
  ContatoEdit.Text := Tab.Fields[12 {CONTATO}].AsString;
  ReferenciaMemo.Lines.Text := Tab.Fields[13 {REFERENCIA}].AsString;
end;

procedure TEnderControlsFrame.Exiba;
begin
  CEPMaskEdit.SetFocus;
  Visible := True;
end;

procedure TEnderControlsFrame.Fone1EditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.Fone2EditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.Fone3EditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.LogradouroEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.MunicipioComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.MunicipioPrepareLista(pUFSigla: string);
begin
  if not FMunicipioPodePreparar then
    exit;
  MunComboMan.Clear;
  pUFSigla := Trim(pUFSigla);
  if pUFSigla = '' then
    exit;
  UFSiglaStatusLabel.Visible := True;
  UFSiglaStatusLabel.Repaint;
  try
    FPessDBI.MunicipioPrepareLista(pUFSigla, MunicipioComboBox.Items);
    MunicipioComboBox.ItemIndex := 0;
  finally
    UFSiglaStatusLabel.Visible := False;
    Repaint;
  end;
end;

procedure TEnderControlsFrame.MunicipioPrepareListaTimerTimer(Sender: TObject);
begin
  inherited;
  MunicipioPrepareListaTimer.Enabled := False;
  MunicipioPrepareLista(UFSiglaComboMan.Text);
end;

procedure TEnderControlsFrame.NumeroEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);

end;

procedure TEnderControlsFrame.Oculte;
begin
  Visible := False;
end;

procedure TEnderControlsFrame.ReferenciaMemoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    if DadosOk then
      FOkExecute(Sender);
  end;
  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.AjusteControles;
begin
  FMunicipioPodePreparar := True;
  FCEPPodeConsultar := True;
end;

end.

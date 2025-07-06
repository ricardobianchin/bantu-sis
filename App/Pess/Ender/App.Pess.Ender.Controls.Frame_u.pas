unit App.Pess.Ender.Controls.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, App.Pess.Ent, App.Pess.DBI, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Controls.Utils, App.PessEnder,
  Sis.UI.Controls.ComboBoxManager, Sis.Types.Integers, Vcl.Mask,
  Sis.UI.IO.Output, Vcl.Buttons;

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
    MunicipioStatusLabel: TLabel;
    CEPMaskEdit: TMaskEdit;
    MunicipioPrepareListaTimer: TTimer;
    CEPStatusLabel: TLabel;
    CEPColarSpeedButton: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure CEPMaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure CEPMaskEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure UFSiglaComboBoxChange(Sender: TObject);
    procedure UFSiglaComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure MunicipioComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure MunicipioPrepareListaTimerTimer(Sender: TObject);
    procedure BairroEditKeyPress(Sender: TObject; var Key: Char);
    procedure LogradouroEditKeyPress(Sender: TObject; var Key: Char);
    procedure NumeroEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComplementoEditKeyPress(Sender: TObject; var Key: Char);
    procedure DDDEditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone1EditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone2EditKeyPress(Sender: TObject; var Key: Char);
    procedure Fone3EditKeyPress(Sender: TObject; var Key: Char);
    procedure ContatoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ReferenciaMemoKeyPress(Sender: TObject; var Key: Char);

    procedure SpeedButton1Click(Sender: TObject);
    procedure CEPColarSpeedButtonClick(Sender: TObject);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FFDMemTable: TFDMemTable;
    FErroOutput: IOutput;
    FPesquisandoCEP: Boolean;

    UFSiglaComboMan: IComboBoxManager;
    MunComboMan: IComboBoxManager;

    FMunicipioPodePreparar: Boolean;
    FCEPPodeConsultar: Boolean;

    FOkExecute: TNotifyEvent;

    function CepDadosOk: Boolean;

    procedure UFSiglaComboBoxAjuste;
    procedure MunicipioPrepareLista(pUFSigla: string);
    procedure ColarCEP;

    function GetWinControlSeguinteAoCEP: TWinControl;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable;
      pOkExecute: TNotifyEvent; pErroOutput: IOutput); reintroduce;
    procedure AjusteControles;
    procedure ControlesToEnt;
    procedure EntToControles;
    procedure Exiba;
    procedure Oculte;
    function DadosOk: Boolean;
    property WinControlSeguinteAoCEP: TWinControl
      read GetWinControlSeguinteAoCEP;
    procedure PesquiseCEP;
  end;

  // var
  // EnderControlsFrame: TEnderControlsFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Factory, Sis.Types.strings_u,
  Sis.UI.ImgDM, Sis.Web.HTTPGet.Net_u, Sis.Types.TStrings_u, System.StrUtils,
  Sis.Win.Utils_u, Winapi.ShellAPI, Sis.Types.Utils_u, App.UI.Form.Perg_u;

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

procedure TEnderControlsFrame.CEPColarSpeedButtonClick(Sender: TObject);
begin
  inherited;
  ColarCEP;
end;

function TEnderControlsFrame.CepDadosOk: Boolean;
var
  L: integer;
  sText: string;
begin
  sText := StrToOnlyDigit(CEPMaskEdit.Text);

  L := Length(sText);
  Result := (L = 0) or (L = 8);

  if Result then
    exit;
  FErroOutput.Exibir('O campo CEP deve ter 8 dígitos ou ser deixado vazio')
end;

procedure TEnderControlsFrame.CEPMaskEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sText: string;
begin
  inherited;

  case Key of
    ord('v'), ord('V'):
      begin
        if Shift = [ssCtrl] then
        begin
          ColarCEP;
        end;
      end;
    VK_RETURN:
      begin
        if Shift = [] then
        begin
          PesquiseCEP;
        end;
      end;
  end;
end;

procedure TEnderControlsFrame.CEPMaskEditKeyPress(Sender: TObject;
  var Key: Char);
var
  sText: string;
  L: integer;
begin
  inherited;
  sText := StrToOnlyDigit(CEPMaskEdit.Text);

  L := Length(sText);
  if L = 8 then
    exit;

  EditKeyPress(Sender, Key);
end;

procedure TEnderControlsFrame.ColarCEP;
var
  sText: string;
begin
  inherited;
  sText := GetClipboardText;
  sText := StrToOnlyDigit(sText);

  if sText = '' then
    exit;

  sText := LeftStr(sText, 8);
  Insert('-', sText, 6);
  CEPMaskEdit.Text := sText;
  PesquiseCEP;
  // CEPMaskEdit.EditText := sText;
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

  Tab.Edit;
  try
    Tab.Fields[7 { CEP } ].AsString := StrToOnlyDigit(CEPMaskEdit.Text);
    Tab.Fields[6 { UF_SIGLA } ].AsString := UFSiglaComboMan.Text;

    Tab.Fields[5 { MUNICIPIO_NOME } ].AsString := MunComboMan.Text;
    if MunComboMan.Id = 0 then
    begin
      Tab.Fields[14 { MUNICIPIO_IBGE_ID } ].AsString := '       ';
    end
    else
    begin
      Tab.Fields[14 { MUNICIPIO_IBGE_ID } ].AsString :=
        IntToStrZero(MunComboMan.Id, 7);
    end;

    Tab.Fields[4 { BAIRRO } ].AsString := BairroEdit.Text;
    Tab.Fields[1 { LOGRADOURO } ].AsString := LogradouroEdit.Text;
    Tab.Fields[2 { NUMERO } ].AsString := NumeroEdit.Text;
    Tab.Fields[3 { COMPLEMENTO } ].AsString := ComplementoEdit.Text;
    Tab.Fields[8 { DDD } ].AsString := DDDEdit.Text;
    Tab.Fields[9 { FONE1 } ].AsString := Fone1Edit.Text;
    Tab.Fields[10 { FONE2 } ].AsString := Fone2Edit.Text;
    Tab.Fields[11 { FONE3 } ].AsString := Fone3Edit.Text;
    Tab.Fields[12 { CONTATO } ].AsString := ContatoEdit.Text;
    Tab.Fields[13 { REFERENCIA } ].AsString := ReferenciaMemo.Lines.Text;
  finally
    Tab.Post;
  end;
end;

constructor TEnderControlsFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable;
  pOkExecute: TNotifyEvent; pErroOutput: IOutput);
begin
  inherited Create(AOwner);
  FErroOutput := pErroOutput;
  FOkExecute := pOkExecute;

  FMunicipioPodePreparar := False;
  FCEPPodeConsultar := False;
  FPesquisandoCEP := False;

  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FFDMemTable := pEnderPessFDMemTable;

  UFSiglaComboMan := ComboBoxManagerCreate(UFSiglaComboBox);
  MunComboMan := ComboBoxManagerCreate(MunicipioComboBox);

  UFSiglaComboBoxAjuste;
end;

function TEnderControlsFrame.DadosOk: Boolean;
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
  s: string;
begin
  inherited;
  Tab := FFDMemTable;

  FCEPPodeConsultar := False;
  s := StrToOnlyDigit(Tab.Fields[7 { CEP } ].AsString);

  if s <> '' then
    Insert('-', s, 6);

  CEPMaskEdit.Text := s;
  FCEPPodeConsultar := True;

  FMunicipioPodePreparar := False;
  UFSiglaComboMan.Text := Trim(Tab.Fields[6 { UF_SIGLA } ].AsString);
  FMunicipioPodePreparar := True;

  MunicipioPrepareLista(UFSiglaComboMan.Text);
  iId := StrToInteger(Tab.Fields[14 { MUNICIPIO_IBGE_ID } ].AsString);
  MunComboMan.Id := iId;

  BairroEdit.Text := Tab.Fields[4 { BAIRRO } ].AsString;
  LogradouroEdit.Text := Tab.Fields[1 { LOGRADOURO } ].AsString;
  NumeroEdit.Text := Tab.Fields[2 { NUMERO } ].AsString;
  ComplementoEdit.Text := Tab.Fields[3 { COMPLEMENTO } ].AsString;
  DDDEdit.Text := Tab.Fields[8 { DDD } ].AsString;
  Fone1Edit.Text := Tab.Fields[9 { FONE1 } ].AsString;
  Fone2Edit.Text := Tab.Fields[10 { FONE2 } ].AsString;
  Fone3Edit.Text := Tab.Fields[11 { FONE3 } ].AsString;
  ContatoEdit.Text := Tab.Fields[12 { CONTATO } ].AsString;
  ReferenciaMemo.Lines.Text := Tab.Fields[13 { REFERENCIA } ].AsString;
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

function TEnderControlsFrame.GetWinControlSeguinteAoCEP: TWinControl;
begin
  Result := UFSiglaComboBox;
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
  MunicipioStatusLabel.Visible := True;
  MunicipioStatusLabel.Repaint;
  try
    FPessDBI.MunicipioPrepareLista(pUFSigla, MunicipioComboBox.Items);
    MunicipioComboBox.ItemIndex := 0;
  finally
    MunicipioStatusLabel.Visible := False;
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

procedure TEnderControlsFrame.PesquiseCEP;
var
  SL: TStringList;
  L: integer;
  iLin: integer;
  sText: string;
  sLin: string;
  iId: integer;
  sMens: string;
begin
  if not FCEPPodeConsultar then
    exit;

  if FPesquisandoCEP then
    exit;

  FPesquisandoCEP := True;

  try
    if //
      (UFSiglaComboBox.ItemIndex > 0) //
      or (MunicipioComboBox.ItemIndex > 0) //
      or (BairroEdit.Text <> '') //
      or (LogradouroEdit.Text <> '') //
    then
    begin
      if not Perg('Consulta CEP e substitui os dados existentes?', '', TBooleanDefault.boolFalse) then
      begin
        TrySetFocus(WinControlSeguinteAoCEP);
        exit;
      end;
    end;

    sText := StrToOnlyDigit(CEPMaskEdit.Text);

    L := Length(sText);
    if L <> 8 then
      exit;

    SL := TStringList.Create;
    try
      CEPStatusLabel.Visible := True;
      CEPStatusLabel.Repaint;
      try
        BuscarCepViaWeb(sText, SL);
      finally
        CEPStatusLabel.Visible := False;
        CEPStatusLabel.Repaint;
      end;

      if SL.Count = 0 then
        exit;
      // uf
      iLin := SLNLinhaQTem(SL, 'uf');
      if iLin = -1 then
        exit;
      sLin := Trim(SL[iLin]);
      sLin := Copy(sLin, 8, 2);

      FMunicipioPodePreparar := False;
      UFSiglaComboMan.Text := sLin;
      FMunicipioPodePreparar := True;

      MunicipioPrepareLista(sLin);

      // municipio
      iLin := SLNLinhaQTem(SL, 'ibge');
      if iLin = -1 then
        exit;

      sLin := Trim(SL[iLin]);
      sLin := Copy(sLin, 10, 7);

      iId := StrToInteger(sLin);
      MunComboMan.Id := iId;

      // bairro
      iLin := SLNLinhaQTem(SL, 'bairro');
      if iLin = -1 then
        exit;

      sLin := Trim(SL[iLin]);
      Delete(sLin, 1, 11);
      StrDeleteNoFim(sLin, 2);

      sLin := StrSemAcento(sLin);
      sLin := StrSemCharRepetido(sLin, #32);

      BairroEdit.Text := sLin;

      // logradouro
      iLin := SLNLinhaQTem(SL, 'logradouro');
      if iLin = -1 then
        exit;

      sLin := Trim(SL[iLin]);
      Delete(sLin, 1, 15);
      StrDeleteNoFim(sLin, 2);

      sLin := StrSemAcento(sLin);
      sLin := StrSemCharRepetido(sLin, #32);

      LogradouroEdit.Text := sLin;
      TrySetFocus(NumeroEdit);
      {
        "cep": "23070-221",
        "logradouro": "Estrada do Campinho",
        "complemento": "até 2995 - lado ímpar",
        "bairro": "Campo Grande",
        "localidade": "Rio de Janeiro",
        "uf": "RJ",
        "ibge": "3304557"
      }

    finally
      SL.Free;
      CEPStatusLabel.Visible := False;
    end;
  finally
    FPesquisandoCEP := False;
  end;
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

procedure TEnderControlsFrame.SpeedButton1Click(Sender: TObject);
var
  Url: string;
begin
  SpeedButton1.Enabled := False;
  Application.ProcessMessages;
  try
    Url := 'https://buscacepinter.correios.com.br/';
    ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL);
  finally
    SpeedButton1.Enabled := True;
  end;
end;

procedure TEnderControlsFrame.AjusteControles;
begin
  FMunicipioPodePreparar := True;
  FCEPPodeConsultar := True;
end;

end.

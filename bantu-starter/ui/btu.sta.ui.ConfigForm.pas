unit btu.sta.ui.ConfigForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Imaging.pngimage, btu.sta.MaqNomeEdFrame,
  Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList, btu.lib.Config,
  btu.lib.usu.Usuario, btu.lib.entit.loja, btu.sta.ui.ConfigForm.testeconfig;

type
  {
    TGroupBox = class(Vcl.StdCtrls.TGroupBox)
    public
    property AutoSize;
    end;
  }
  TStarterFormConfig = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    ActionList1: TActionList;
    OkAct: TAction;
    CancelAct: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ReloadAct: TAction;
    UsuGerenteGroupBox: TGroupBox;
    LocalMaqNomeEdFrame: TMaqNomeEdFrame;
    EhServidorCheckBox: TCheckBox;
    ServerMaqNomeEdFrame: TMaqNomeEdFrame;
    BalloonHint1: TBalloonHint;
    UsuGerenteNomeExibLabeledEdit: TLabeledEdit;
    UsuGerenteNomeUsuLabeledEdit: TLabeledEdit;
    UsuGerenteSenha1LabeledEdit: TLabeledEdit;
    UsuGerenteSenha2LabeledEdit: TLabeledEdit;
    ActionList2: TActionList;
    LoginToolBar: TToolBar;
    ToolButton4: TToolButton;
    LoginErroLabel: TLabel;
    ToolBar2: TToolBar;
    ToolButton5: TToolButton;
    BuscaNomeAction: TAction;
    ServerConfigLabeledEdit: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    LojaIdGroupBox: TGroupBox;
    AjudaLojaLabel: TLabel;
    LojaIdLabeledEdit: TLabeledEdit;
    LojaApelidoLabeledEdit: TLabeledEdit;
    ServerConfigSelectButton: TButton;
    ShowTimer: TTimer;
    ObsLabel: TLabel;
    UsuGerenteExibSenhaCheckBox: TCheckBox;
    AvisoSenhaLabel: TLabel;
    LojaErroLabel: TLabel;
    UsuGerenteNomeCompletoLabeledEdit: TLabeledEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);

    procedure FormResize(Sender: TObject);

    procedure OkActExecute(Sender: TObject);
    procedure CancelActExecute(Sender: TObject);

    procedure BuscaNomeActionExecute(Sender: TObject);

    procedure EhServidorCheckBoxClick(Sender: TObject);

    procedure UsuGerenteNomeExibLabeledEditChange(Sender: TObject);
    procedure UsuGerenteNomeUsuLabeledEditChange(Sender: TObject);
    procedure UsuGerenteSenha1LabeledEditChange(Sender: TObject);
    procedure UsuGerenteSenha2LabeledEditChange(Sender: TObject);

    procedure UsuGerenteNomeExibLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure UsuGerenteNomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuGerenteSenha1LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuGerenteSenha2LabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure UsuGerenteExibSenhaCheckBoxClick(Sender: TObject);

    procedure LojaIdLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LojaApelidoLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LocalMaqNomeEdFrameIpLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure EhServidorCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UsuGerenteNomeCompletoLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPastaBin: string;
    FSisConfig: ISisConfig;
    FUsuarioGerente: IUsuario;
    FLoja: ILoja;

    FTesteConfig: TTesteConfig;

    function PodeOk: boolean;

    function LocalMaqPodeOk: boolean;

    function ServerPodeOk: boolean;
    function UsuGerentePodeOk: boolean;
    function LojaPodeOk: boolean;

    function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit; pErroLabel: TLabel): boolean;

    procedure CarregTesteStarterIni;

    procedure CtrlToObj;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pSisConfig: ISisConfig;
      pUsuarioGerente: IUsuario; pLoja: ILoja); reintroduce;
  end;

var
  StarterFormConfig: TStarterFormConfig;

implementation

{$R *.dfm}

uses Math, ControlsReposition, sis.ui.Img.DataModule,
  btu.lib.Config.machineid, Winapi.winsock, btu.sis.di.ui.constants,
  sis.types.strings, sis.ui.Controls.utils, Sta.Constants,
  sis.types.constants, btu.lib.db.types;

{
  procedure FillMachineId(ALocalMachineId: IMachineId);
  var
  Buffer: array [0 .. MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWORD;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
  begin
  // Get the computer name
  Size := Length(Buffer);
  if GetComputerName(Buffer, Size) then
  ALocalMachineId.Name := Buffer
  else
  ALocalMachineId.Name := '';

  // Get the IP address
  WSAStartup($101, WSAData);
  try
  HostEnt := gethostbyname(PAnsiChar(AnsiString(ALocalMachineId.Name)));
  if HostEnt <> nil then
  ALocalMachineId.IP := Format('%d.%d.%d.%d', [Byte(HostEnt^.h_addr^[0]),
  Byte(HostEnt^.h_addr^[1]), Byte(HostEnt^.h_addr^[2]),
  Byte(HostEnt^.h_addr^[3])])
  else
  ALocalMachineId.IP := '';
  finally
  WSACleanup;
  end;
  end;
}

procedure PegarIdMaquina(out pNome: string; out pIp: string);
var
  Buffer: array [0 .. MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWORD;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  // Get the computer name
  Size := Length(Buffer);
  if GetComputerName(Buffer, Size) then
    pNome := Buffer
  else
    pNome := '';

  // Get the IP address
  WSAStartup($101, WSAData);
  try
    HostEnt := gethostbyname(PAnsiChar(AnsiString(pNome)));
    if HostEnt <> nil then
      pIp := Format('%d.%d.%d.%d', [Byte(HostEnt^.h_addr^[0]),
        Byte(HostEnt^.h_addr^[1]), Byte(HostEnt^.h_addr^[2]),
        Byte(HostEnt^.h_addr^[3])])
    else
      pIp := '';
  finally
    WSACleanup;
  end;
end;

procedure TStarterFormConfig.BuscaNomeActionExecute(Sender: TObject);
var
  sNome, sIp: string;
begin
  PegarIdMaquina(sNome, sIp);
  LocalMaqNomeEdFrame.NomeLabeledEdit.Text := sNome;
  LocalMaqNomeEdFrame.IpLabeledEdit.Text := sIp;
end;

procedure TStarterFormConfig.CancelActExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TStarterFormConfig.CarregTesteStarterIni;
begin
  FTesteConfig.LerIni;

  if FTesteConfig.TesteMaqLocalBuscaNome then
  begin
    BuscaNomeAction.Execute;
  end;

  if FTesteConfig.TesteEhServ then
  begin
    EhServidorCheckBox.Checked := true;
  end;

  if FTesteConfig.TesteUsuPreenche then
  begin
    UsuGerenteNomeCompletoLabeledEdit.Text := FTesteConfig.TesteUsuNomeCompleto;
    UsuGerenteNomeExibLabeledEdit.Text := FTesteConfig.TesteUsuNomeExib;
    UsuGerenteNomeUsuLabeledEdit.Text := FTesteConfig.TesteUsuNomeUsu;
    UsuGerenteSenha1LabeledEdit.Text := FTesteConfig.TesteUsuSenha1;
    UsuGerenteSenha2LabeledEdit.Text := FTesteConfig.TesteUsuSenha2;
    UsuGerenteExibSenhaCheckBox.Checked := FTesteConfig.TesteUsuExibSenha;
  end;

  if FTesteConfig.TesteLojaPreenche then
  begin
    LojaIdLabeledEdit.Text := FTesteConfig.TesteLojaId.ToString;
    LojaApelidoLabeledEdit.Text := FTesteConfig.TesteLojaApelido;
  end;
end;

procedure TStarterFormConfig.EhServidorCheckBoxClick(Sender: TObject);
begin
  if EhServidorCheckBox.Checked then
  begin
    ServerMaqNomeEdFrame.Visible := false;
    ServerConfigLabeledEdit.Visible := false;
    ServerConfigSelectButton.Visible := false;

    UsuGerenteGroupBox.Visible := true;
    LojaIdGroupBox.Visible := true;
  end
  else
  begin
    ServerMaqNomeEdFrame.Visible := true;
    ServerConfigLabeledEdit.Visible := true;
    ServerConfigSelectButton.Visible := true;

    UsuGerenteGroupBox.Visible := false;
    LojaIdGroupBox.Visible := false;
  end;
end;

procedure TStarterFormConfig.EhServidorCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    if EhServidorCheckBox.Checked then
      UsuGerenteNomeCompletoLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

constructor TStarterFormConfig.Create(AOwner: TComponent;
  pSisConfig: ISisConfig; pUsuarioGerente: IUsuario; pLoja: ILoja);
begin
  inherited Create(AOwner);
  FSisConfig := pSisConfig;
  FUsuarioGerente := pUsuarioGerente;
  FLoja := pLoja;
end;

procedure TStarterFormConfig.CtrlToObj;
begin
  FSisConfig.LocalMachineId.Name := LocalMaqNomeEdFrame.NomeLabeledEdit.Text;
  FSisConfig.LocalMachineId.IP := LocalMaqNomeEdFrame.IpLabeledEdit.Text;

  FSisConfig.LocalMachineIsServer := EhServidorCheckBox.Checked;

  if FSisConfig.LocalMachineIsServer then
  begin
    FSisConfig.ServerMachineId.Name := FSisConfig.LocalMachineId.Name;
    FSisConfig.ServerMachineId.IP := FSisConfig.LocalMachineId.IP;
  end
  else
  begin
    FSisConfig.ServerMachineId.Name := ServerMaqNomeEdFrame.NomeLabeledEdit.Text;
    FSisConfig.ServerMachineId.IP := ServerMaqNomeEdFrame.IpLabeledEdit.Text;
  end;

  FSisConfig.DBMSInfo.DatabaseType :=  dbmstFirebird;
  FSisConfig.DBMSInfo.Version := 4.0;

  FUsuarioGerente.NomeCompleto := UsugerenteNomeCompletoLabeledEdit.Text;
  FUsuarioGerente.NomeExib := UsugerenteNomeExibLabeledEdit.Text;
  FUsuarioGerente.NomeUsu := UsugerenteNomeUsuLabeledEdit.Text;
  FUsuarioGerente.Senha := UsugerenteSenha1LabeledEdit.Text;

  FLoja.Id := StrToInt(LojaIdLabeledEdit.Text);
  FLoja.Descr := LojaApelidoLabeledEdit.Text;
end;

procedure TStarterFormConfig.FormCreate(Sender: TObject);
begin
  FPastaBin := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  FTesteConfig := TTesteConfig.Create(FPastaBin);

  AjudaLojaLabel.Font.Color := COR_AZUL_LINK;
  AjudaLojaLabel.Hint := LOJAID_DESCR;

  LocalMaqNomeEdFrame.GroupBox1.Caption := 'Máquina Local';
  ServerMaqNomeEdFrame.GroupBox1.Caption := 'Servidor';

  // LocalGroupBox.AutoSize := true;
  // ServerGroupBox.AutoSize := true;
end;

procedure TStarterFormConfig.FormDestroy(Sender: TObject);
begin
  FTesteConfig.Free;
end;

procedure TStarterFormConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=kENTER then
  begin
    if Shift=[ssCtrl] then
    begin
      OkAct.Execute;
    end;
  end;
end;

procedure TStarterFormConfig.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = cESC then
  begin
    Key := cNULO;
    OkAct.Execute;
    exit;
  end;
end;

procedure TStarterFormConfig.FormResize(Sender: TObject);
begin
  // RepositionControls( LocalGroupBox, 9, 35);
  // LocalGroupBox.Width := FlowPanel1.Width;
  // LocalGroupBox.Width := Panel2.Width;
  // if FlowPanel2.Height>LocalGroupBox.Height then
  // LocalGroupBox.Height := FlowPanel2.Height+10;
end;

procedure TStarterFormConfig.FormShow(Sender: TObject);
begin
//  ShowTimer.Enabled := true;

end;

procedure TStarterFormConfig.LojaApelidoLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    OkAct.Execute;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.LocalMaqNomeEdFrameIpLabeledEditKeyPress
  (Sender: TObject; var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    EhServidorCheckBox.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TStarterFormConfig.LocalMaqPodeOk: boolean;
begin
  result := LocalMaqNomeEdFrame.PodeOk;
end;

procedure TStarterFormConfig.LojaIdLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TStarterFormConfig.LojaPodeOk: boolean;
var
  iId: integer;
begin
  result := TesteLabeledEditVazio(LojaIdLabeledEdit, LojaErroLabel);
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaIdLabeledEdit.EditLabel.Caption +
      ''' é obrigatório';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := TryStrToInt(LojaIdLabeledEdit.Text, iId);
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaIdLabeledEdit.EditLabel.Caption +
      ''' é obrigatório';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := iId > 0;
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaIdLabeledEdit.EditLabel.Caption +
      ''' é obrigatório';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := TesteLabeledEditVazio(LojaApelidoLabeledEdit, LojaErroLabel);
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaApelidoLabeledEdit.EditLabel.Caption +
      ''' é obrigatório';
    LojaErroLabel.Visible := true;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;
end;

procedure TStarterFormConfig.UsuGerenteExibSenhaCheckBoxClick(Sender: TObject);
begin
  if UsugerenteExibSenhaCheckBox.Checked then
  begin
    UsugerenteSenha1LabeledEdit.PasswordChar := cNULO;
    UsugerenteSenha2LabeledEdit.PasswordChar := cNULO;
    AvisoSenhaLabel.Visible := true;
  end
  else
  begin
    UsugerenteSenha1LabeledEdit.PasswordChar := '*';
    UsugerenteSenha2LabeledEdit.PasswordChar := '*';
    AvisoSenhaLabel.Visible := false;
  end;

end;

procedure TStarterFormConfig.UsuGerenteNomeCompletoLabeledEditKeyPress(
  Sender: TObject; var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsugerenteNomeExibLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.UsuGerenteNomeExibLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;
end;

procedure TStarterFormConfig.UsuGerenteNomeExibLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsugerenteNomeUsuLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.UsuGerenteNomeUsuLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuGerenteNomeUsuLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsugerenteSenha1LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TStarterFormConfig.UsugerentePodeOk: boolean;
begin
  UsugerenteNomeCompletoLabeledEdit.Text := Trim(StrSemAcento(UsugerenteNomeCompletoLabeledEdit.Text));
  UsugerenteNomeExibLabeledEdit.Text := Trim(StrSemAcento(UsugerenteNomeExibLabeledEdit.Text));
  UsugerenteNomeUsuLabeledEdit.Text := Trim(StrToName(UsugerenteNomeUsuLabeledEdit.Text));

  result := TesteLabeledEditVazio(UsugerenteNomeCompletoLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsugerenteNomeExibLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsugerenteNomeUsuLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsugerenteSenha1LabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsugerenteSenha2LabeledEdit, LoginErroLabel);
  // if not result then
  // exit;
end;

procedure TStarterFormConfig.UsuGerenteSenha1LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuGerenteSenha1LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsugerenteSenha2LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.UsuGerenteSenha2LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuGerenteSenha2LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TStarterFormConfig.PodeOk: boolean;
begin
  result := LocalMaqPodeOk;
  if not result then
    exit;

  if EhServidorCheckBox.Checked then
  begin
    result := ServerPodeOk;
  end
  else
  begin

  end;
end;

function TStarterFormConfig.ServerPodeOk: boolean;
begin
  result := ServerMaqNomeEdFrame.PodeOk;
  if not result then
    exit;

  result := UsugerentePodeOk;
  if not result then
    exit;

  result := LojaPodeOk;
  if not result then
    exit;
end;

procedure TStarterFormConfig.ShowTimerTimer(Sender: TObject);
begin
//  ShowTimer.Enabled := false;
  CarregTesteStarterIni;
end;

function TStarterFormConfig.TesteLabeledEditVazio(pLabeledEdit
  : TLabeledEdit; pErroLabel: TLabel): boolean;
begin
  result := not EditVazio(pLabeledEdit);
  if not result then
  begin
    pErroLabel.Caption := 'Campo ''' + pLabeledEdit.EditLabel.Caption +
      ''' é obrigatório';
    pErroLabel.Visible := true;
    pLabeledEdit.SetFocus;
  end;
end;

procedure TStarterFormConfig.OkActExecute(Sender: TObject);
begin
  if not PodeOk then
    exit;

  modalresult := mrOk;

  CtrlToObj;
end;

end.

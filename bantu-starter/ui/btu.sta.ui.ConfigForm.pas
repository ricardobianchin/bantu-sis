unit btu.sta.ui.ConfigForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Imaging.pngimage, btu.sta.MaqNomeEdFrame,
  Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList, btu.lib.Config,
  btu.lib.usu.UsuLogin, btu.lib.entit.loja;

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
    UsuRespGroupBox: TGroupBox;
    LocalMaqNomeEdFrame: TMaqNomeEdFrame;
    EhServidorCheckBox: TCheckBox;
    ServerMaqNomeEdFrame: TMaqNomeEdFrame;
    AjudaRespLabel: TLabel;
    BalloonHint1: TBalloonHint;
    UsuRespNomeExibLabeledEdit: TLabeledEdit;
    UsuRespNomeUsuLabeledEdit: TLabeledEdit;
    UsuRespSenha1LabeledEdit: TLabeledEdit;
    UsuRespSenha2LabeledEdit: TLabeledEdit;
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
    UsuRespExibSenhaCheckBox: TCheckBox;
    AvisoSenhaLabel: TLabel;
    LojaErroLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);

    procedure FormResize(Sender: TObject);

    procedure OkActExecute(Sender: TObject);
    procedure CancelActExecute(Sender: TObject);

    procedure BuscaNomeActionExecute(Sender: TObject);

    procedure EhServidorCheckBoxClick(Sender: TObject);

    procedure UsuRespNomeExibLabeledEditChange(Sender: TObject);
    procedure UsuRespNomeUsuLabeledEditChange(Sender: TObject);
    procedure UsuRespSenha1LabeledEditChange(Sender: TObject);
    procedure UsuRespSenha2LabeledEditChange(Sender: TObject);

    procedure UsuRespNomeExibLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure UsuRespNomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuRespSenha1LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuRespSenha2LabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure UsuRespExibSenhaCheckBoxClick(Sender: TObject);

    procedure LojaIdLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LojaApelidoLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LocalMaqNomeEdFrameIpLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure EhServidorCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FPastaBin: string;
    FSisConfig: ISisConfig;
    FUsuLogin: IUsuLogin;
    FLoja: ILoja;

    FTesteEhServ: boolean;
    FTesteMaqLocalBuscaNome: boolean;

    FTesteUsuRespPreenche: boolean;
    FTesteUsuNomeExib: string;
    FTesteUsuNomeUsu: string;
    FTesteUsuSenha1: string;
    FTesteUsuSenha2: string;
    FTesteUsuExibSenha: boolean;

    FTesteLojaPreenche: boolean;
    FTesteLojaId: integer;
    FTesteLojaApelido: string;

    function PodeOk: boolean;

    function LocalMaqPodeOk: boolean;

    function ServerPodeOk: boolean;
    function UsuRespPodeOk: boolean;
    function LojaPodeOk: boolean;

    function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit; pErroLabel: TLabel): boolean;

    procedure CarregTesteStarterIni;

    procedure CtrlToObj;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pSisConfig: ISisConfig;
      pUsuLogin: IUsuLogin; pLoja: ILoja); reintroduce;
  end;

var
  StarterFormConfig: TStarterFormConfig;

implementation

{$R *.dfm}

uses Math, ControlsReposition, btu.lib.ui.Img.DataModule, IniFiles,
  btu.lib.Config.machineid, Winapi.winsock, btu.sis.di.ui.constants,
  btn.lib.types.strings, btn.lib.ui.Controls.utils, btu.sta.constants,
  btu.lib.types.constants, btu.lib.db.types;

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
var
  sNomeArq: string;
  IniFile: TIniFile;
begin
  sNomeArq := FPastaBin + 'testes.starter.ini';
  IniFile := TIniFile.Create(sNomeArq);
  try
    // MAQ LOCAL
    FTesteMaqLocalBuscaNome := IniFile.ReadBool('form',
      'maqlocal_buscanome', false);
    IniFile.WriteBool('form', 'maqlocal_buscanome', FTesteMaqLocalBuscaNome);

    if FTesteMaqLocalBuscaNome then
    begin
      BuscaNomeAction.Execute;
    end;

    // SE � SERVIDOR
    FTesteEhServ := IniFile.ReadBool('form', 'ehserver', false);
    IniFile.WriteBool('form', 'ehserver', FTesteEhServ);

    if FTesteEhServ then
    begin
      EhServidorCheckBox.Checked := true;
    end;

    // USUARIO RESPONSAVEL TECNICO
    FTesteUsuRespPreenche := IniFile.ReadBool('form',
      'usuresp_preenche', false);
    IniFile.WriteBool('form', 'usuresp_preenche', FTesteUsuRespPreenche);

    FTesteUsuNomeExib := IniFile.ReadString('form', 'usuresp_nomeexib', '');
    IniFile.WriteString('form', 'usuresp_nomeexib', FTesteUsuNomeExib);

    FTesteUsuNomeUsu := IniFile.ReadString('form', 'usuresp_nomeusu', '');
    IniFile.WriteString('form', 'usuresp_nomeusu', FTesteUsuNomeUsu);

    FTesteUsuSenha1 := IniFile.ReadString('form', 'usuresp_senha1', '');
    IniFile.WriteString('form', 'usuresp_senha1', FTesteUsuSenha1);

    FTesteUsuSenha2 := IniFile.ReadString('form', 'usuresp_senha2', '');
    IniFile.WriteString('form', 'usuresp_senha2', FTesteUsuSenha2);

    FTesteUsuExibSenha := IniFile.ReadBool('form', 'usuresp_exibsenha', false);
    IniFile.WriteBool('form', 'usuresp_exibsenha', FTesteUsuExibSenha);

    if FTesteUsuRespPreenche then
    begin
      UsuRespNomeExibLabeledEdit.Text := FTesteUsuNomeExib;
      UsuRespNomeUsuLabeledEdit.Text := FTesteUsuNomeUsu;
      UsuRespSenha1LabeledEdit.Text := FTesteUsuSenha1;
      UsuRespSenha2LabeledEdit.Text := FTesteUsuSenha2;
      UsuRespExibSenhaCheckBox.Checked := FTesteUsuExibSenha;
    end;


    //LOJA
    FTesteLojaPreenche := IniFile.ReadBool('form', 'loja_preenche', false);
    IniFile.WriteBool('form', 'loja_preenche', FTesteLojaPreenche);

    FTesteLojaId := IniFile.ReadInteger('form', 'loja_id', 0);
    IniFile.WriteInteger('form', 'loja_id', FTesteLojaId);

    FTesteLojaApelido := IniFile.ReadString('form', 'loja_apelido', '');
    IniFile.WriteString('form', 'loja_apelido', FTesteLojaApelido);

    if FTesteLojaPreenche then
    begin
      LojaIdLabeledEdit.Text := FTesteLojaId.ToString;
      LojaApelidoLabeledEdit.Text := FTesteLojaApelido;
    end;

  finally
    IniFile.Free;
  end;
end;

procedure TStarterFormConfig.EhServidorCheckBoxClick(Sender: TObject);
begin
  if EhServidorCheckBox.Checked then
  begin
    ServerMaqNomeEdFrame.Visible := false;
    ServerConfigLabeledEdit.Visible := false;
    ServerConfigSelectButton.Visible := false;

    UsuRespGroupBox.Visible := true;
    LojaIdGroupBox.Visible := true;
  end
  else
  begin
    ServerMaqNomeEdFrame.Visible := true;
    ServerConfigLabeledEdit.Visible := true;
    ServerConfigSelectButton.Visible := true;

    UsuRespGroupBox.Visible := false;
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
      UsuRespNomeExibLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

constructor TStarterFormConfig.Create(AOwner: TComponent;
  pSisConfig: ISisConfig; pUsuLogin: IUsuLogin; pLoja: ILoja);
begin
  inherited Create(AOwner);
  FSisConfig := pSisConfig;
  FUsuLogin := pUsuLogin;
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

  FUsuLogin.Id := 0;
  FUsuLogin.NomeExib := UsuRespNomeExibLabeledEdit.Text;
  FUsuLogin.NomeUsu := UsuRespNomeUsuLabeledEdit.Text;
  FUsuLogin.Senha := UsuRespSenha1LabeledEdit.Text;

  FLoja.Id := StrToInt(LojaIdLabeledEdit.Text);
  FLoja.Descr := LojaApelidoLabeledEdit.Text;
end;

procedure TStarterFormConfig.FormCreate(Sender: TObject);
begin
  FPastaBin := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  AjudaRespLabel.Font.Color := COR_AZUL_LINK;
  AjudaRespLabel.Hint := RESPTEC_DESCR;

  AjudaLojaLabel.Font.Color := COR_AZUL_LINK;
  AjudaLojaLabel.Hint := LOJAID_DESCR;

  LocalMaqNomeEdFrame.GroupBox1.Caption := 'M�quina Local';
  ServerMaqNomeEdFrame.GroupBox1.Caption := 'Servidor';

  // LocalGroupBox.AutoSize := true;
  // ServerGroupBox.AutoSize := true;
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
  ShowTimer.Enabled := true;

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
      ''' � obrigat�rio';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := TryStrToInt(LojaIdLabeledEdit.Text, iId);
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaIdLabeledEdit.EditLabel.Caption +
      ''' � obrigat�rio';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := iId > 0;
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaIdLabeledEdit.EditLabel.Caption +
      ''' � obrigat�rio';
    LojaErroLabel.Visible := true;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  result := TesteLabeledEditVazio(LojaApelidoLabeledEdit, LojaErroLabel);
  if not result then
  begin
    LojaErroLabel.Caption := 'Campo ''' + LojaApelidoLabeledEdit.EditLabel.Caption +
      ''' � obrigat�rio';
    LojaErroLabel.Visible := true;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;
end;

procedure TStarterFormConfig.UsuRespExibSenhaCheckBoxClick(Sender: TObject);
begin
  if UsuRespExibSenhaCheckBox.Checked then
  begin
    UsuRespSenha1LabeledEdit.PasswordChar := cNULO;
    UsuRespSenha2LabeledEdit.PasswordChar := cNULO;
    AvisoSenhaLabel.Visible := true;
  end
  else
  begin
    UsuRespSenha1LabeledEdit.PasswordChar := '*';
    UsuRespSenha2LabeledEdit.PasswordChar := '*';
    AvisoSenhaLabel.Visible := false;
  end;

end;

procedure TStarterFormConfig.UsuRespNomeExibLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;
end;

procedure TStarterFormConfig.UsuRespNomeExibLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsuRespNomeUsuLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.UsuRespNomeUsuLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuRespNomeUsuLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsuRespSenha1LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TStarterFormConfig.UsuRespPodeOk: boolean;
begin
  UsuRespNomeExibLabeledEdit.Text := Trim(StrSemAcento(UsuRespNomeExibLabeledEdit.Text));
  UsuRespNomeUsuLabeledEdit.Text := Trim(StrToName(UsuRespNomeUsuLabeledEdit.Text));

  result := TesteLabeledEditVazio(UsuRespNomeExibLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuRespNomeUsuLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuRespSenha1LabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuRespSenha2LabeledEdit, LoginErroLabel);
  // if not result then
  // exit;
end;

procedure TStarterFormConfig.UsuRespSenha1LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuRespSenha1LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = cENTER then
  begin
    Key := cNULO;
    UsuRespSenha2LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TStarterFormConfig.UsuRespSenha2LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TStarterFormConfig.UsuRespSenha2LabeledEditKeyPress(Sender: TObject;
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

  result := UsuRespPodeOk;
  if not result then
    exit;

  result := LojaPodeOk;
  if not result then
    exit;
end;

procedure TStarterFormConfig.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := false;
  CarregTesteStarterIni;
end;

function TStarterFormConfig.TesteLabeledEditVazio(pLabeledEdit
  : TLabeledEdit; pErroLabel: TLabel): boolean;
var
  iVal: integer;
begin
  result := not EditVazio(pLabeledEdit);
  if not result then
  begin
    pErroLabel.Caption := 'Campo ''' + pLabeledEdit.EditLabel.Caption +
      ''' � obrigat�rio';
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

unit App.UI.Config.ConfigPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Usuario, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList,
  Sis.Loja, Sis.Config.SisConfig, App.UI.Config.ConfigPergForm.Testes,
  App.UI.Config.MaqNomeEdFrame_u, App.UI.Frame.DBGrid.Config.Ambi.Terminais_u,
  Sis.TerminalList, Sis.Terminal, Data.DB, App.AppObj,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

const
  COL_2_X = 362;

type
  {
    TGroupBox = class(Vcl.StdCtrls.TGroupBox)
    public
    property AutoSize;
    end;
  }
  TConfigPergForm = class(TForm)
    ActionList1: TActionList;
    OkAct: TAction;
    CancelAct: TAction;
    ReloadAct: TAction;
    BalloonHint1: TBalloonHint;
    ActionList2: TActionList;
    BuscaLocalNomeAction: TAction;
    OpenDialog1: TOpenDialog;
    ShowTimer: TTimer;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    EhServidorCheckBox: TCheckBox;
    MaqLocalToolBar: TToolBar;
    ToolButton5: TToolButton;
    ServerArqConfigLabeledEdit: TLabeledEdit;
    UsuAdminGroupBox: TGroupBox;
    LoginErroLabel: TLabel;
    ObsLabel: TLabel;
    AvisoSenhaLabel: TLabel;
    UsuAdminNomeExibLabeledEdit: TLabeledEdit;
    UsuAdminNomeUsuLabeledEdit: TLabeledEdit;
    UsuAdminSenha1LabeledEdit: TLabeledEdit;
    UsuAdminSenha2LabeledEdit: TLabeledEdit;
    LoginToolBar: TToolBar;
    ToolButton4: TToolButton;
    UsuAdminExibSenhaCheckBox: TCheckBox;
    UsuAdminNomeCompletoLabeledEdit: TLabeledEdit;
    LojaIdGroupBox: TGroupBox;
    AjudaLojaLabel: TLabel;
    LojaErroLabel: TLabel;
    LojaIdLabeledEdit: TLabeledEdit;
    LojaApelidoLabeledEdit: TLabeledEdit;
    ServerConfigSelectButton: TButton;
    TerminaisGroupBox: TGroupBox;
    ServConfigSelectAction: TAction;
    ServerArqConfigErroLabel: TLabel;
    ServFDConnection: TFDConnection;
    TerminaisErroLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);

    procedure FormResize(Sender: TObject);

    procedure OkActExecute(Sender: TObject);
    procedure CancelActExecute(Sender: TObject);

    procedure BuscaLocalNomeActionExecute(Sender: TObject);

    procedure EhServidorCheckBoxClick(Sender: TObject);

    procedure UsuAdminNomeExibLabeledEditChange(Sender: TObject);
    procedure UsuAdminNomeUsuLabeledEditChange(Sender: TObject);
    procedure UsuAdminSenha1LabeledEditChange(Sender: TObject);
    procedure UsuAdminSenha2LabeledEditChange(Sender: TObject);

    procedure UsuAdminNomeExibLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure UsuAdminNomeUsuLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure UsuAdminSenha1LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuAdminSenha2LabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure UsuAdminExibSenhaCheckBoxClick(Sender: TObject);

    procedure LojaIdLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LojaApelidoLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LocalMaqFrameIpLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure EhServidorCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UsuAdminNomeCompletoLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure ServConfigSelectActionExecute(Sender: TObject);
    procedure ServFDConnectionBeforeConnect(Sender: TObject);
    procedure ReloadActExecute(Sender: TObject);
  private
    { Private declarations }

    PosCol1: TPoint;
    PosCol2: TPoint;

    FPastaBin: string;
    FPastaConfigs: string;
    FAppObj: IAppObj;
    FSisConfig: ISisConfig;
    FUsuarioAdmin: IUsuario;
    FLoja: ISisLoja;
    FConfigPergTeste: TConfigPergTeste;

    LocalMaqFrame: TMaqNomeEdFrame;
    ServerMaqFrame: TMaqNomeEdFrame;

    FTerminaisDBGridFrame: TTerminaisDBGridFrame;

    FTerminalList: ITerminalList;

    function PodeOk: boolean;

    function LocalMaqPodeOk: boolean;

    function ServerPodeOk: boolean;
    function TermPodeOk: boolean;
    function UsuAdminPodeOk: boolean;
    function LojaPodeOk: boolean;
    function ServerArqConfigPodeOk: boolean;
    function TerminalIdPodeOk: boolean;

    function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
      pErroLabel: TLabel): boolean;

    procedure CarregTesteStarterIni;

    procedure ControlesToObjetos;
    procedure PegarTerminais;

    function TinhaTermNoDB: boolean;
    function TinhaTermNoHD: boolean;
    function TinhaTerm: boolean;
    function NomeArqToTerminalId(sNomeArq: string): SmallInt;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pSisConfig: ISisConfig;
      pUsuarioAdmin: IUsuario; pLoja: ISisLoja; pTerminalList: ITerminalList;
      pAppObj: IAppObj); reintroduce;
  end;

var
  ConfigPergForm: TConfigPergForm;

implementation

{$R *.dfm}

uses Math, Sis.UI.Controls.utils, Sis.UI.ImgDM, Sis.Win.Utils_u,
  Sis.Types.Utils_u, App.DB.utils, Sis.Types.strings_u, Sis.DB.DBTypes,
  Sis.UI.Constants, App.UI.Config.Constants, Sis.UI.IO.Files,
  Sis.Terminal.Factory_u, App.Config.Ambi.Factory_u, App.AppInfo.Types,
  Sis.Terminal.Utils_u, App.UI.Config.ConfigPergForm_u.CarregaServ,
  Sis.DB.DataSet.utils;

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

{
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
}

procedure TConfigPergForm.BuscaLocalNomeActionExecute(Sender: TObject);
var
  sNome, sIp: string;
begin
  PegarIdMaquina(sNome, sIp);
  LocalMaqFrame.NomeLabeledEdit.Text := sNome;
  LocalMaqFrame.IpLabeledEdit.Text := sIp;
  TinhaTerm;
end;

procedure TConfigPergForm.CancelActExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TConfigPergForm.CarregTesteStarterIni;
var
  // bResultado: Boolean;
  sNomeArq: string;
  sNomeNaRede: string;
  sIp: string;
begin
  FConfigPergTeste.LerIni;

  EhServidorCheckBox.Checked := FConfigPergTeste.TesteEhServ;
  ServerArqConfigLabeledEdit.Text := FConfigPergTeste.ServerArqConfig;
  if ServerArqConfigLabeledEdit.Text <> '' then
  begin
    sNomeArq := ServerArqConfigLabeledEdit.Text;
    ConfigArqLeiaDoServ(sNomeArq, sNomeNaRede, sIp);
    ServerMaqFrame.NomeLabeledEdit.Text := sNomeNaRede;
    ServerMaqFrame.IpLabeledEdit.Text := sIp;
  end;

  if FConfigPergTeste.TesteLojaPreenche then
  begin
    LojaIdLabeledEdit.Text := FConfigPergTeste.TesteLojaId.ToString;
    LojaApelidoLabeledEdit.Text := FConfigPergTeste.TesteLojaApelido;
  end;

  if FConfigPergTeste.TesteMaqLocalBuscaNome then
  begin
    BuscaLocalNomeAction.Execute;
  end;

  Application.ProcessMessages;
  if ServerArqConfigLabeledEdit.Text <> '' then
    TinhaTerm;

  if FConfigPergTeste.TesteUsuPreenche then
  begin
    UsuAdminNomeCompletoLabeledEdit.Text :=
      FConfigPergTeste.TesteUsuNomeCompleto;
    UsuAdminNomeExibLabeledEdit.Text := FConfigPergTeste.TesteUsuNomeExib;
    UsuAdminNomeUsuLabeledEdit.Text := FConfigPergTeste.TesteUsuNomeUsu;
    UsuAdminSenha1LabeledEdit.Text := FConfigPergTeste.TesteUsuSenha1;
    UsuAdminSenha2LabeledEdit.Text := FConfigPergTeste.TesteUsuSenha2;
    UsuAdminExibSenhaCheckBox.Checked := FConfigPergTeste.TesteUsuExibSenha;
    FTerminaisDBGridFrame.SimuleIns;
  end;
  Application.ProcessMessages;
  if FConfigPergTeste.TesteExecutaOk then
    OkAct.Execute;
end;

procedure TConfigPergForm.EhServidorCheckBoxClick(Sender: TObject);
begin
  if EhServidorCheckBox.Checked then
  begin
    ServerMaqFrame.Visible := false;
    ServerArqConfigLabeledEdit.Visible := false;
    ServerArqConfigErroLabel.Visible := false;
    ServerConfigSelectButton.Visible := false;

    UsuAdminGroupBox.Visible := true;
    LojaIdGroupBox.Visible := true;
  end
  else
  begin
    ServerMaqFrame.Visible := true;
    ServerArqConfigErroLabel.Visible := true;
    ServerConfigSelectButton.Visible := true;
    ServerArqConfigLabeledEdit.Visible := true;

    UsuAdminGroupBox.Visible := false;
    LojaIdGroupBox.Visible := false;
  end;
end;

procedure TConfigPergForm.EhServidorCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    if EhServidorCheckBox.Checked then
      UsuAdminNomeCompletoLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

constructor TConfigPergForm.Create(AOwner: TComponent; pSisConfig: ISisConfig;
  pUsuarioAdmin: IUsuario; pLoja: ISisLoja; pTerminalList: ITerminalList;
  pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FTerminalList := pTerminalList;

  PosCol1 := Point(7, 3);
  PosCol2 := Point(COL_2_X, 3);

  FAppObj := pAppObj;
  FSisConfig := pSisConfig;
  FUsuarioAdmin := pUsuarioAdmin;
  FLoja := pLoja;
  FTerminaisDBGridFrame := TTerminaisDBGridFrame.Create(TerminaisGroupBox,
    ConfigAmbiTerminalDBIMudoCreate, ServFDConnection, false);
  FTerminaisDBGridFrame.Align := alClient;
  FTerminaisDBGridFrame.Preparar;
  ServerArqConfigErroLabel.Caption := '';
  TerminaisErroLabel.Caption := '';
end;

procedure TConfigPergForm.ControlesToObjetos;
begin
  FSisConfig.LocalMachineId.Name := LocalMaqFrame.NomeLabeledEdit.Text;
  FSisConfig.LocalMachineId.IP := LocalMaqFrame.IpLabeledEdit.Text;
  FSisConfig.LocalMachineId.LetraDoDrive := 'C';

  FSisConfig.LocalMachineIsServer := EhServidorCheckBox.Checked;
  FSisConfig.ServerArqConfig := ServerArqConfigLabeledEdit.Text;

  if FSisConfig.LocalMachineIsServer then
  begin
    FSisConfig.ServerMachineId.Name := FSisConfig.LocalMachineId.Name;
    FSisConfig.ServerMachineId.IP := FSisConfig.LocalMachineId.IP;
    FSisConfig.ServerMachineId.LetraDoDrive :=
      FSisConfig.LocalMachineId.LetraDoDrive;
  end
  else
  begin
    FSisConfig.ServerMachineId.Name := ServerMaqFrame.NomeLabeledEdit.Text;
    FSisConfig.ServerMachineId.IP := ServerMaqFrame.IpLabeledEdit.Text;
    FSisConfig.ServerMachineId.LetraDoDrive := 'C';
  end;

  FSisConfig.DBMSInfo.DatabaseType := dbmstFirebird;
  FSisConfig.DBMSInfo.Version := 4.0;

  FUsuarioAdmin.NomeCompleto := UsuAdminNomeCompletoLabeledEdit.Text;
  FUsuarioAdmin.NomeExib := UsuAdminNomeExibLabeledEdit.Text;
  FUsuarioAdmin.NomeDeUsuario := UsuAdminNomeUsuLabeledEdit.Text;
  FUsuarioAdmin.Senha := UsuAdminSenha1LabeledEdit.Text;

  FLoja.Id := StrToInt(LojaIdLabeledEdit.Text);
  FLoja.Descr := LojaApelidoLabeledEdit.Text;
  PegarTerminais;
end;

procedure TConfigPergForm.FormCreate(Sender: TObject);
var
  FrL, FrW, Off: integer;
begin
  BorderIcons := [];

  FPastaBin := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  FPastaConfigs := PastaAcima(FPastaBin) + 'Configs\';
  FConfigPergTeste := TConfigPergTeste.Create(FPastaBin, FPastaConfigs);

  AjudaLojaLabel.Font.Color := COR_AZUL_LINK;
  AjudaLojaLabel.Hint := LOJAID_DESCR;

  LocalMaqFrame := TMaqNomeEdFrame.Create(Panel2);
  LocalMaqFrame.Name := 'LocalMaqFrame';

  ServerMaqFrame := TMaqNomeEdFrame.Create(Panel2);
  ServerMaqFrame.Name := 'ServerMaqFrame';

  LocalMaqFrame.Top := PosCol1.Y;
  ServerMaqFrame.Top := LocalMaqFrame.Top;

  LocalMaqFrame.Left := PosCol1.X;
  ServerMaqFrame.Left := PosCol2.X;

  LocalMaqFrame.Width := (PosCol2.X - 4) - LocalMaqFrame.Left;

  FrL := LocalMaqFrame.IpLabeledEdit.Left;
  FrW := LocalMaqFrame.IpLabeledEdit.Width;
  Off := 8;
  MaqLocalToolBar.Left := FrL + FrW + Off;

  LocalMaqFrame.GroupBox1.Caption := 'Máquina Local';
  ServerMaqFrame.GroupBox1.Caption := 'Servidor';

  MaqLocalToolBar.BringToFront;

  LojaIdGroupBox.Left := ServerMaqFrame.Left;
  LojaIdGroupBox.Top := ServerMaqFrame.Top;
end;

procedure TConfigPergForm.FormDestroy(Sender: TObject);
begin
  FConfigPergTeste.Free;
end;

procedure TConfigPergForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = WKEY_ENTER then
  begin
    if Shift = [ssCtrl] then
    begin
      OkAct.Execute;
    end;
  end;
end;

procedure TConfigPergForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = CHAR_ESC then
  begin
    Key := CHAR_NULO;
    OkAct.Execute;
    exit;
  end;
end;

procedure TConfigPergForm.FormResize(Sender: TObject);
begin
  // RepositionControls( LocalGroupBox, 9, 35);
  // LocalGroupBox.Width := FlowPanel1.Width;
  // LocalGroupBox.Width := Panel2.Width;
  // if FlowPanel2.Height>LocalGroupBox.Height then
  // LocalGroupBox.Height := FlowPanel2.Height+10;
end;

procedure TConfigPergForm.FormShow(Sender: TObject);
begin
  ShowTimer.Enabled := true;

end;

procedure TConfigPergForm.LojaApelidoLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    OkAct.Execute;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TConfigPergForm.LocalMaqFrameIpLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    EhServidorCheckBox.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TConfigPergForm.LocalMaqPodeOk: boolean;
begin
  result := LocalMaqFrame.PodeOk;
end;

procedure TConfigPergForm.LojaIdLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TConfigPergForm.LojaPodeOk: boolean;
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
    LojaErroLabel.Caption := 'Campo ''' + LojaApelidoLabeledEdit.EditLabel.
      Caption + ''' é obrigatório';
    LojaErroLabel.Visible := true;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;
end;

function TConfigPergForm.NomeArqToTerminalId(sNomeArq: string): SmallInt;
var
  i: integer;
  sNum: string;
begin
  sNum := '';
  // Percorre a string de trás para frente para encontrar os 3 últimos dígitos
  for i := Length(sNomeArq) downto 1 do
  begin
    if sNomeArq[i] in ['0' .. '9'] then
      sNum := sNomeArq[i] + sNum
    else if Length(sNum) = 3 then
      Break
    else
      sNum := '';
  end;

  // Converte a parte numérica para SmallInt
  if sNum <> '' then
    result := StrToInt(sNum)
  else
    result := -1; // Retorna -1 se não encontrar número válido
end;

procedure TConfigPergForm.UsuAdminExibSenhaCheckBoxClick(Sender: TObject);
begin
  if UsuAdminExibSenhaCheckBox.Checked then
  begin
    UsuAdminSenha1LabeledEdit.PasswordChar := CHAR_NULO;
    UsuAdminSenha2LabeledEdit.PasswordChar := CHAR_NULO;
    AvisoSenhaLabel.Visible := true;
  end
  else
  begin
    UsuAdminSenha1LabeledEdit.PasswordChar := '*';
    UsuAdminSenha2LabeledEdit.PasswordChar := '*';
    AvisoSenhaLabel.Visible := false;
  end;

end;

procedure TConfigPergForm.UsuAdminNomeCompletoLabeledEditKeyPress
  (Sender: TObject; var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuAdminNomeExibLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuAdminNomeExibLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;
end;

procedure TConfigPergForm.UsuAdminNomeExibLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuAdminNomeUsuLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuAdminNomeUsuLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuAdminNomeUsuLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuAdminSenha1LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TConfigPergForm.UsuAdminPodeOk: boolean;
begin
  UsuAdminNomeCompletoLabeledEdit.Text :=
    Trim(StrSemAcento(UsuAdminNomeCompletoLabeledEdit.Text));
  UsuAdminNomeExibLabeledEdit.Text :=
    Trim(StrSemAcento(UsuAdminNomeExibLabeledEdit.Text));
  UsuAdminNomeUsuLabeledEdit.Text :=
    Trim(StrToName(UsuAdminNomeUsuLabeledEdit.Text));

  result := TesteLabeledEditVazio(UsuAdminNomeCompletoLabeledEdit,
    LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuAdminNomeExibLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuAdminNomeUsuLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuAdminSenha1LabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuAdminSenha2LabeledEdit, LoginErroLabel);
  // if not result then
  // exit;
end;

procedure TConfigPergForm.UsuAdminSenha1LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuAdminSenha1LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuAdminSenha2LabeledEdit.SetFocus;
    exit;
  end;

  // CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuAdminSenha2LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuAdminSenha2LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    LojaIdLabeledEdit.SetFocus;
    exit;
  end;

  // CharSemAcento(Key);
end;

procedure TConfigPergForm.PegarTerminais;
var
  Tab: TDataSet;
  Terminal: ITerminal;
begin
  Tab := FTerminaisDBGridFrame.FDMemTable1;
  Tab.DisableControls;
  try
    Tab.First;
    while not Tab.Eof do
    begin
      Terminal := TerminalCreate;
      FTerminalList.Add(Terminal);
      Sis.Terminal.Utils_u.DataSetToTerminal(Tab, Terminal,
        FAppObj.AppInfo.PastaDados, AtividadeEconomicaSisDescr
        [FAppObj.AppInfo.AtividadeEconomicaSis]);
      Tab.Next;
    end;
  finally
    Tab.EnableControls;
  end;

end;

function TConfigPergForm.PodeOk: boolean;
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
    result := TermPodeOk;
  end;

  if not result then
    exit;

  result := not TinhaTerm;
  if not result then
    exit;

end;

procedure TConfigPergForm.ReloadActExecute(Sender: TObject);
begin
  TinhaTermNoDB;
end;

procedure TConfigPergForm.ServConfigSelectActionExecute(Sender: TObject);
var
  bResultado: boolean;
  sNomeArq: string;
  sNomeNaRede: string;
  sIp: string;
begin
  bResultado := OpenDialog1.Execute;
  if not bResultado then
    exit;

  sNomeArq := OpenDialog1.FileName;
  if not FileExists(sNomeArq) then
  begin
    ShowMessage('Arquivo de configuração do servidor não encontrado: ' +
      sNomeArq);
    exit;
  end;

  ServerArqConfigLabeledEdit.Text := sNomeArq;

  ConfigArqLeiaDoServ(sNomeArq, sNomeNaRede, sIp);
  ServerMaqFrame.NomeLabeledEdit.Text := sNomeNaRede;
  ServerMaqFrame.IpLabeledEdit.Text := sIp;
  ServFDConnection.Params.Values['Server'] :=
    ServerMaqFrame.NomeLabeledEdit.Text;
  TinhaTerm;
end;

function TConfigPergForm.ServerArqConfigPodeOk: boolean;
begin
  result := ServerArqConfigLabeledEdit.Text <> '';
  if not result then
  begin
    ServerArqConfigErroLabel.Caption := 'Obrigatório';
    ServerArqConfigLabeledEdit.SetFocus;
    exit;
  end;

  result := FileExists(ServerArqConfigLabeledEdit.Text);
  if not result then
  begin
    ServerArqConfigErroLabel.Caption := 'Arquivo não encontrado';
    exit;
  end;

end;

function TConfigPergForm.ServerPodeOk: boolean;
begin
  result := ServerMaqFrame.PodeOk;
  if not result then
    exit;

  result := UsuAdminPodeOk;
  if not result then
    exit;

  result := LojaPodeOk;
  if not result then
    exit;
end;

procedure TConfigPergForm.ServFDConnectionBeforeConnect(Sender: TObject);
var
  sNomeArq: string;
  sServ: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaDadosServ + //
    'Dados_' + //
    AtividadeEconomicaSisDescr[FAppObj.AppInfo.AtividadeEconomicaSis] + //
    '_Retaguarda.FDB' //
    ;

  ServFDConnection.Params.Values['Database'] := sNomeArq;

  if EhServidorCheckBox.Checked then
    sServ := LocalMaqFrame.NomeLabeledEdit.Text
  else
    sServ := ServerMaqFrame.NomeLabeledEdit.Text;

  ServFDConnection.Params.Values['Server'] := sServ;
end;

procedure TConfigPergForm.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := false;
{$IFDEF DEBUG}
  CarregTesteStarterIni;
  // FTerminaisDBGridFrame.InsAction.Execute;
  // FTerminaisDBGridFrame.AltAction.Execute;
  // OkAct.Execute;
{$ENDIF}
end;

function TConfigPergForm.TerminalIdPodeOk: boolean;
var
  TerminalId: integer;
  t: TDataSet;
  sSql: string;
  q: TDataSet;
  sMens: string;
begin
  q := nil;
  result := true;
  try
    t := FTerminaisDBGridFrame.FDMemTable1;

    t.First;
    while not t.Eof do
    begin
      TerminalId := t.Fields[0].AsInteger;

      try
        ServFDConnection.Connected := false;
        ServFDConnection.Connected := true;
        sSql := 'SELECT 1 FROM RDB$DATABASE WHERE EXISTS (' +
          'SELECT 1 FROM TERMINAl WHERE TERMINAL_ID = ' + TerminalId.ToString;

        if LocalMaqFrame.NomeLabeledEdit.Text <> '' then
          sSql := sSql + ' AND NOME_NA_REDE <> ' +
            QuotedStr(LocalMaqFrame.NomeLabeledEdit.Text);

        if LocalMaqFrame.IpLabeledEdit.Text <> '' then
          sSql := sSql + ' AND IP <> ' +
            QuotedStr(LocalMaqFrame.IpLabeledEdit.Text);

        sSql := sSql + ')';

        ServFDConnection.ExecSQL(sSql, q);
        result := q.IsEmpty;
        if not result then
        begin
          sMens := 'Já existe um terminal ' + TerminalId.ToString;
          exit;
        end;
        ServFDConnection.Connected := false;
      except
        on e: exception do
        begin
          result := false;
          sMens := 'Erro ao testar terminais: ' + e.message;
        end;
      end;

      t.Next;
    end;
  finally
    if assigned(q) then
      q.Free;
    if result then
      TerminaisErroLabel.Caption := ''
    else
      TerminaisErroLabel.Caption := sMens;
  end;
end;

function TConfigPergForm.TermPodeOk: boolean;
begin
  result := ServerArqConfigPodeOk;
  if not result then
    exit;

  result := TerminalIdPodeOk;
  if not result then
    exit;
end;

function TConfigPergForm.TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
  pErroLabel: TLabel): boolean;
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

function TConfigPergForm.TinhaTerm: boolean;
var
  bR1, bR2: boolean;
  sServ: string;
  sTerm: string;
begin
  if EhServidorCheckBox.Checked then
    sServ := LocalMaqFrame.NomeLabeledEdit.Text
  else
    sServ := ServerMaqFrame.NomeLabeledEdit.Text;

  result := sServ <> '';
  if not result then
    exit;

  sTerm := LocalMaqFrame.NomeLabeledEdit.Text;

  result := sTerm <> '';
  if not result then
    exit;

  // nao faz and com eles diretamente,
  // pra evitar a otimizacao que se o prim retornou true
  // ja nao executaria o segundo
  bR1 := TinhaTermNoDB;
  bR2 := TinhaTermNoHD;
  result := bR1 or bR2
end;

function TConfigPergForm.TinhaTermNoDB: boolean;
var
  sSql: string;
  q: TDataSet;
  iRecordCountIni: integer;
  iRecordCountFin: integer;
  sMens: string;
  bResultado: boolean;
  sServ: string;
begin
  if EhServidorCheckBox.Checked then
    sServ := LocalMaqFrame.NomeLabeledEdit.Text
  else
    sServ := ServerMaqFrame.NomeLabeledEdit.Text;

  result := sServ = '';
  if result then
    exit;

  iRecordCountIni := FTerminaisDBGridFrame.FDMemTable1.RecordCount;

  FTerminaisDBGridFrame.FDMemTable1.DisableControls;
  FTerminaisDBGridFrame.FDMemTable1.BeginBatch;
  FTerminaisDBGridFrame.FDMemTable1.First;
  try
    sSql := 'SELECT'#13#10 //

      + '  T.TERMINAL_ID'#13#10 // 0

      + '  , T.APELIDO'#13#10 // 1
      + '  , T.NOME_NA_REDE'#13#10 // 2
      + '  , T.IP'#13#10 // 3
      + '  , T.LETRA_DO_DRIVE || '':'' LETRADRIVE'#13#10 // 4

      + '  , T.NF_SERIE'#13#10 // 5

      + '  , T.GAVETA_TEM'#13#10 // 6
      + '  , T.GAVETA_COMANDO'#13#10 // 7
      + '  , T.GAVETA_IMPR_NOME'#13#10 // 8

      + '  , BMU.BALANCA_MODO_USO_ID'#13#10 // 9
      + '  , BMU.DESCR AS BALANCA_MODO_USO_DESCR'#13#10 // 10

      + '  , B.BALANCA_ID'#13#10 // 11
      + '  , B.MODELO BALANCA_FABR_MODELO'#13#10 // 12

      + '  , T.BARRAS_COD_INI'#13#10 // 13
      + '  , T.BARRAS_COD_TAM'#13#10 // 14

      + '  , IME.IMPRESSORA_MODO_ENVIO_ID'#13#10 // 15
      + '  , IME.DESCR IMPRESSORA_MODO_ENVIO_DESCR'#13#10 // 16

      + '  , IM.IMPRESSORA_MODELO_ID'#13#10 // 17
      + '  , IM.DESCR IMPRESSORA_MODELO_DESCR'#13#10 // 18
      + '  , T.IMPRESSORA_NOME'#13#10 // 19
      + '  , T.IMPRESSORA_COLS_QTD'#13#10 // 20

      + '  , T.CUPOM_QTD_LINS_FINAL'#13#10 // 21

      + '  , T.SEMPRE_OFFLINE'#13#10 // 22
      + '  , T.ATIVO'#13#10 // 23

      + '  , T.BALANCA_PORTA'#13#10 // 24
      + '  , T.BALANCA_BAUDRATE'#13#10 // 25
      + '  , T.BALANCA_DATABITS'#13#10 // 26
      + '  , T.BALANCA_PARIDADE'#13#10 // 27
      + '  , T.BALANCA_STOPBITS'#13#10 // 28
      + '  , T.BALANCA_HANDSHAKING'#13#10 // 29

      + 'FROM TERMINAL T'#13#10 //

      + 'JOIN BALANCA_MODO_USO BMU ON'#13#10 //
      + 'T.BALANCA_MODO_USO_ID = BMU.BALANCA_MODO_USO_ID'#13#10 //

      + 'JOIN BALANCA B ON'#13#10 //
      + 'T.BALANCA_ID = B.BALANCA_ID'#13#10 //

      + 'JOIN IMPRESSORA_MODO_ENVIO IME ON'#13#10 //
      + 'IME.IMPRESSORA_MODO_ENVIO_ID = T.IMPRESSORA_MODO_ENVIO_ID'#13#10 //

      + 'JOIN IMPRESSORA_MODELO IM ON'#13#10 //
      + 'IM.IMPRESSORA_MODELO_ID = T.IMPRESSORA_MODELO_ID'#13#10 //

      + 'WHERE T.TERMINAL_ID > 0'#13#10 //
      + 'AND T.ATIVO'#13#10 //
      + 'AND ';

    if LocalMaqFrame.NomeLabeledEdit.Text <> '' then
      sSql := sSql + 'NOME_NA_REDE = ' +
        QuotedStr(LocalMaqFrame.NomeLabeledEdit.Text)
    else
      sSql := sSql + 'IP = ' + QuotedStr(LocalMaqFrame.IpLabeledEdit.Text);
    sSql := sSql + #13#10;

    sSql := sSql + 'ORDER BY TERMINAL_ID'#13#10; //

    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
    try
      ServFDConnection.Connected := false;
      ServFDConnection.Connected := true;
      ServFDConnection.ExecSQL(sSql, q);
      try
        while not q.Eof do
        begin
          bResultado := FTerminaisDBGridFrame.FDMemTable1.Locate('TERMINAL_ID',
            q.Fields[0].AsInteger, []);

          if bResultado then
          begin
            FTerminaisDBGridFrame.FDMemTable1.Edit;
          end
          else
          begin
            FTerminaisDBGridFrame.FDMemTable1.Append;
          end;

          RecordToFDMemTable(q, FTerminaisDBGridFrame.FDMemTable1);

          FTerminaisDBGridFrame.FDMemTable1.Post;
          q.Next;
        end;
      finally
        q.Free;
      end;
      ServFDConnection.Connected := false;

      iRecordCountFin := FTerminaisDBGridFrame.FDMemTable1.RecordCount;

      result := iRecordCountFin > iRecordCountIni;
    finally
      FTerminaisDBGridFrame.FDMemTable1.First;
      FTerminaisDBGridFrame.FDMemTable1.EnableControls;
      FTerminaisDBGridFrame.FDMemTable1.EndBatch;
      if result then
      begin
        sMens := 'Havia no servidor, registro de terminais para este computador';
        TerminaisErroLabel.Caption := sMens;
      end
      else
      begin
        TerminaisErroLabel.Caption := ''
      end;
    end;
  except
        on e: exception do
        begin
          result := false;
          sMens := 'Erro ao testar terminais: ' + e.message;
          showmessage(smens);
        end;
  end;
end;

function TConfigPergForm.TinhaTermNoHD: boolean;
var
  sSqlTerminalGet: string;
  sSqlIdNoServ: string;
  sMascNomeArqTerm: string;
  NomesArqSL: TStringList;
  sTerm: string;
  TermFDConnection: TFDConnection;
  i: integer;
  sLocalArq: string;
  bResultado: boolean;
  iTerminalId: SmallInt;
  q: TDataSet;
  iQtdAdicionados: integer;
  sDrive: string;
begin
  sTerm := LocalMaqFrame.NomeLabeledEdit.Text;

  result := sTerm = '';
  if result then
    exit;

  sSqlTerminalGet := 'SELECT'#13#10 //

    + '  T.TERMINAL_ID'#13#10 // 0

    + '  , T.APELIDO'#13#10 // 1
    + '  , T.NOME_NA_REDE'#13#10 // 2
    + '  , T.IP'#13#10 // 3
    + '  , T.LETRA_DO_DRIVE || '':'' LETRADRIVE'#13#10 // 4

    + '  , T.NF_SERIE'#13#10 // 5

    + '  , T.GAVETA_TEM'#13#10 // 6
    + '  , T.GAVETA_COMANDO'#13#10 // 7
    + '  , T.GAVETA_IMPR_NOME'#13#10 // 8

    + '  , BMU.BALANCA_MODO_USO_ID'#13#10 // 9
    + '  , BMU.DESCR AS BALANCA_MODO_USO_DESCR'#13#10 // 10

    + '  , B.BALANCA_ID'#13#10 // 11
    + '  , B.MODELO BALANCA_FABR_MODELO'#13#10 // 12

    + '  , T.BARRAS_COD_INI'#13#10 // 13
    + '  , T.BARRAS_COD_TAM'#13#10 // 14

    + '  , IME.IMPRESSORA_MODO_ENVIO_ID'#13#10 // 15
    + '  , IME.DESCR IMPRESSORA_MODO_ENVIO_DESCR'#13#10 // 16

    + '  , IM.IMPRESSORA_MODELO_ID'#13#10 // 17
    + '  , IM.DESCR IMPRESSORA_MODELO_DESCR'#13#10 // 18
    + '  , T.IMPRESSORA_NOME'#13#10 // 19
    + '  , T.IMPRESSORA_COLS_QTD'#13#10 // 20

    + '  , T.CUPOM_QTD_LINS_FINAL'#13#10 // 21

    + '  , T.SEMPRE_OFFLINE'#13#10 // 22
    + '  , T.ATIVO'#13#10 // 23

    + '  , T.BALANCA_PORTA'#13#10 // 24
    + '  , T.BALANCA_BAUDRATE'#13#10 // 25
    + '  , T.BALANCA_DATABITS'#13#10 // 26
    + '  , T.BALANCA_PARIDADE'#13#10 // 27
    + '  , T.BALANCA_STOPBITS'#13#10 // 28
    + '  , T.BALANCA_HANDSHAKING'#13#10 // 29

    + 'FROM TERMINAL T'#13#10 //

    + 'JOIN BALANCA_MODO_USO BMU ON'#13#10 //
    + 'T.BALANCA_MODO_USO_ID = BMU.BALANCA_MODO_USO_ID'#13#10 //

    + 'JOIN BALANCA B ON'#13#10 //
    + 'T.BALANCA_ID = B.BALANCA_ID'#13#10 //

    + 'JOIN IMPRESSORA_MODO_ENVIO IME ON'#13#10 //
    + 'IME.IMPRESSORA_MODO_ENVIO_ID = T.IMPRESSORA_MODO_ENVIO_ID'#13#10 //

    + 'JOIN IMPRESSORA_MODELO IM ON'#13#10 //
    + 'IM.IMPRESSORA_MODELO_ID = T.IMPRESSORA_MODELO_ID'#13#10 //
    ;

  sMascNomeArqTerm := 'DADOS_' + AtividadeEconomicaSisDescr
    [FAppObj.AppInfo.AtividadeEconomicaSis] + '_TERMINAL_???.FDB';

  NomesArqSL := TStringList.Create;
  TermFDConnection := TFDConnection.Create(Nil);
  try
    // preenche os params fixos
    TermFDConnection.Params.Text := //
      'Protocol=TCPIP'#13#10 //
      + 'User_Name=sysdba'#13#10 //
      + 'Password=masterkey'#13#10 //
      + 'DriverID=FB'#13#10 //
      + 'Server=' + sTerm + #13#10 //
      ;

    // busca term fdb local
    LeDiretorio(FAppObj.AppInfo.PastaDados, NomesArqSL, true, sMascNomeArqTerm);

    result := NomesArqSL.Count > 0;
    if not result then // nao tinha, aborta
      exit;

    iQtdAdicionados := 0;
    result := false;
    for i := 0 to NomesArqSL.Count - 1 do // pra cada arquivo do hd
    begin
      sLocalArq := FAppObj.AppInfo.PastaDados + NomesArqSL[i];

      // usa nome do arquivo pra descobrir termnal_id
      iTerminalId := NomeArqToTerminalId(sLocalArq);

      // testa se ja tinha este tem no memtable
      bResultado := FTerminaisDBGridFrame.FDMemTable1.Locate('TERMINAL_ID',
        iTerminalId, []);
      if bResultado then
        Continue;//ja dinha, aborta este arquivo local

      // certifica-se que este term nao tem no serv.
      // se tiver, nao precisa cadastra
      ServFDConnection.Connected := false;
      ServFDConnection.Connected := true;
      try
        sSqlIdNoServ := 'SELECT 1 FROM RDB$DATABASE WHERE EXISTS (' +
          'SELECT 1 FROM TERMINAL WHERE TERMINAL_ID = ' + iTerminalId.ToString;
        sSqlIdNoServ := sSqlIdNoServ + ')';

        ServFDConnection.ExecSQL(sSqlIdNoServ, q);
        bResultado := q.IsEmpty;
      finally
        q.Free;
        ServFDConnection.Connected := false;
      end;

      if not bResultado then
        Continue;//nao veio empty, ja tinha no serv, aborta este arq local

      // preenche os params que mudam a cada iteração
      TermFDConnection.Params.Values['Database'] := sLocalArq;
      TermFDConnection.Connected := true;
      try
        TermFDConnection.ExecSQL(sSqlTerminalGet, q);
        if q.IsEmpty then
          Continue;

        if q.FieldByName('TERMINAL_ID').AsInteger = 0 then
        begin
//          ShowMessage
//            ('Arquivo de terminal foi ignorado por ter número de terminal zerado.'#13#10
//            + sLocalArq);
          Continue;
        end;

        inc(iQtdAdicionados);
        FTerminaisDBGridFrame.FDMemTable1.Append;
        RecordToFDMemTable(q, FTerminaisDBGridFrame.FDMemTable1);

        if FTerminaisDBGridFrame.FDMemTable1.FieldByName('NOME_NA_REDE')
          .AsString <> sTerm then
          FTerminaisDBGridFrame.FDMemTable1.FieldByName('NOME_NA_REDE')
            .AsString := sTerm;

        if FTerminaisDBGridFrame.FDMemTable1.FieldByName('IP').AsString <>
          LocalMaqFrame.IpLabeledEdit.Text then
          FTerminaisDBGridFrame.FDMemTable1.FieldByName('IP').AsString :=
            LocalMaqFrame.IpLabeledEdit.Text;

        sDrive := ExtractFileDrive(FAppObj.AppInfo.PastaDados);

        if FTerminaisDBGridFrame.FDMemTable1.FieldByName('LETRA_DO_DRIVE')
          .AsString <> sDrive then
          FTerminaisDBGridFrame.FDMemTable1.FieldByName('LETRA_DO_DRIVE')
            .AsString := sDrive;

        FTerminaisDBGridFrame.FDMemTable1.Post;
      finally
        TermFDConnection.Connected := false;
        if assigned(q) then
          q.Free;
      end;
    end;
    result := iQtdAdicionados > 0;
  finally
    NomesArqSL.Free;
    TermFDConnection.Free;
  end;
end;

procedure TConfigPergForm.OkActExecute(Sender: TObject);
begin
  if not PodeOk then
    exit;

  modalresult := mrOk;

  ControlesToObjetos;
end;

end.

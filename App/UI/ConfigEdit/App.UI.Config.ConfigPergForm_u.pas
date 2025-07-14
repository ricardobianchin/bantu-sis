unit App.UI.Config.ConfigPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Usuario, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList,
  Sis.Loja, Sis.Config.SisConfig, App.UI.Config.ConfigPergForm.Testes,
  App.UI.Config.MaqNomeEdFrame_u, App.UI.Frame.DBGrid.Config.Ambi.Terminal_u,
  Sis.TerminalList, Sis.Terminal, Data.DB, App.AppObj, Sis.Terminal.DBI,
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
    Button1: TButton;

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
    procedure Button1Click(Sender: TObject);
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


    function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
      pErroLabel: TLabel): boolean;

    procedure CarregTesteStarterIni;

    procedure ControlesToObjetos;
    procedure PegarTerminais;
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
  Sis.Terminal.Utils_u, App.UI.Config.ConfigPergForm_u.CarregaServ;

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
end;

procedure TConfigPergForm.Button1Click(Sender: TObject);
begin
  ServFDConnection.Params.Values['server'] := ServerMaqFrame.NomeLabeledEdit.Text;

//  showmessage(ServFDConnection.Params.text);
//
end;

procedure TConfigPergForm.CancelActExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TConfigPergForm.CarregTesteStarterIni;
var
//  bResultado: Boolean;
  sNomeArq: string;
  sNomeNaRede: string;
  sIp: string;
begin
  FConfigPergTeste.LerIni;

  if FConfigPergTeste.TesteMaqLocalBuscaNome then
  begin
    BuscaLocalNomeAction.Execute;
  end;

  EhServidorCheckBox.Checked := FConfigPergTeste.TesteEhServ;
  ServerArqConfigLabeledEdit.Text := FConfigPergTeste.ServerArqConfig;
  if ServerArqConfigLabeledEdit.Text <> '' then
  begin
    sNomeArq := ServerArqConfigLabeledEdit.Text;
    ConfigArqLer(sNomeArq, sNomeNaRede, sIp);
    ServerMaqFrame.NomeLabeledEdit.Text := sNomeNaRede;
    ServerMaqFrame.IpLabeledEdit.Text := sIp;
  end;

  if FConfigPergTeste.TesteLojaPreenche then
  begin
    LojaIdLabeledEdit.Text := FConfigPergTeste.TesteLojaId.ToString;
    LojaApelidoLabeledEdit.Text := FConfigPergTeste.TesteLojaApelido;
  end;

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
    ConfigAmbiTerminalDBIMudoCreate, ServFDConnection);
  FTerminaisDBGridFrame.Align := alClient;
  FTerminaisDBGridFrame.Preparar;
  ServerArqConfigErroLabel.Caption := '';
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
    FSisConfig.ServerMachineId.LetraDoDrive := FSisConfig.LocalMachineId.LetraDoDrive;
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
    Result := ServerPodeOk;
  end
  else
  begin
    Result := TermPodeOk;
  end;
end;

procedure TConfigPergForm.ServConfigSelectActionExecute(Sender: TObject);
var
  bResultado: Boolean;
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

  ConfigArqLer(sNomeArq, sNomeNaRede, sIp);
  ServerMaqFrame.NomeLabeledEdit.Text := sNomeNaRede;
  ServerMaqFrame.IpLabeledEdit.Text := sIp;
  ServFDConnection.Params.Values['server'] := ServerMaqFrame.NomeLabeledEdit.Text;
end;

function TConfigPergForm.ServerArqConfigPodeOk: boolean;
begin
  Result := ServerArqConfigLabeledEdit.Text <> '';
  if not Result then
  begin
    ServerArqConfigErroLabel.Caption := 'Obrigatório';
    ServerArqConfigLabeledEdit.SetFocus;
    exit;
  end;

  Result := FileExists(ServerArqConfigLabeledEdit.Text);
  if not Result then
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

function TConfigPergForm.TermPodeOk: boolean;
begin
  Result := ServerArqConfigPodeOk;
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

procedure TConfigPergForm.OkActExecute(Sender: TObject);
begin
  if not PodeOk then
    exit;

  modalresult := mrOk;

  ControlesToObjetos;
end;

end.

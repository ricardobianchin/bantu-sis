unit App.UI.Config.ConfigPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Usuario, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList,
  Sis.Loja, Sis.Config.SisConfig, App.UI.Config.ConfigPergForm.Testes,
  App.UI.Config.MaqNomeEdFrame_u, App.UI.Frame.DBGrid.Config.Ambi.Terminal_u,
  Sis.Entities.TerminalList, Sis.Entities.Terminal, Data.DB;
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
    ServerConfigLabeledEdit: TLabeledEdit;
    UsuGerGroupBox: TGroupBox;
    LoginErroLabel: TLabel;
    ObsLabel: TLabel;
    AvisoSenhaLabel: TLabel;
    UsuGerNomeExibLabeledEdit: TLabeledEdit;
    UsuGerNomeUsuLabeledEdit: TLabeledEdit;
    UsuGerSenha1LabeledEdit: TLabeledEdit;
    UsuGerSenha2LabeledEdit: TLabeledEdit;
    LoginToolBar: TToolBar;
    ToolButton4: TToolButton;
    UsuGerExibSenhaCheckBox: TCheckBox;
    UsuGerNomeCompletoLabeledEdit: TLabeledEdit;
    LojaIdGroupBox: TGroupBox;
    AjudaLojaLabel: TLabel;
    LojaErroLabel: TLabel;
    LojaIdLabeledEdit: TLabeledEdit;
    LojaApelidoLabeledEdit: TLabeledEdit;
    ServerConfigSelectButton: TButton;
    TerminaisGroupBox: TGroupBox;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);

    procedure FormResize(Sender: TObject);

    procedure OkActExecute(Sender: TObject);
    procedure CancelActExecute(Sender: TObject);

    procedure BuscaLocalNomeActionExecute(Sender: TObject);

    procedure EhServidorCheckBoxClick(Sender: TObject);

    procedure UsuGerNomeExibLabeledEditChange(Sender: TObject);
    procedure UsuGerNomeUsuLabeledEditChange(Sender: TObject);
    procedure UsuGerSenha1LabeledEditChange(Sender: TObject);
    procedure UsuGerSenha2LabeledEditChange(Sender: TObject);

    procedure UsuGerNomeExibLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuGerNomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuGerSenha1LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UsuGerSenha2LabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure UsuGerExibSenhaCheckBoxClick(Sender: TObject);

    procedure LojaIdLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LojaApelidoLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure LocalMaqFrameIpLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure EhServidorCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UsuGerNomeCompletoLabeledEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    PosCol1: TPoint;
    PosCol2: TPoint;

    FPastaBin: string;
    FPastaConfigs: string;
    FSisConfig: ISisConfig;
    FUsuarioGerente: IUsuario;
    FLoja: ILoja;

    FConfigPergTeste: TConfigPergTeste;

    LocalMaqFrame: TMaqNomeEdFrame;
    ServerMaqFrame: TMaqNomeEdFrame;

    FTerminaisDBGridFrame: TTerminaisDBGridFrame;

    FTerminalList: ITerminalList;

    function PodeOk: boolean;

    function LocalMaqPodeOk: boolean;

    function ServerPodeOk: boolean;
    function UsuGerPodeOk: boolean;
    function LojaPodeOk: boolean;

    function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
      pErroLabel: TLabel): boolean;

    procedure CarregTesteStarterIni;

    procedure ControlesToObjetos;
    procedure PegarTerminais;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pSisConfig: ISisConfig;
      pUsuarioGerente: IUsuario; pLoja: ILoja; pTerminalList: ITerminalList);
      reintroduce;
  end;

var
  ConfigPergForm: TConfigPergForm;

implementation

{$R *.dfm}

uses Math, Winapi.winsock, Sis.UI.Controls.utils, Sis.UI.ImgDM,
  Sis.Types.Utils_u,
  Sis.Types.strings_u, Sis.DB.DBTypes, Sis.UI.Constants,
  App.UI.Config.Constants, Sis.UI.IO.Files, Sis.Entities.Factory;

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

procedure TConfigPergForm.BuscaLocalNomeActionExecute(Sender: TObject);
var
  sNome, sIp: string;
begin
  PegarIdMaquina(sNome, sIp);
  LocalMaqFrame.NomeLabeledEdit.Text := sNome;
  LocalMaqFrame.IpLabeledEdit.Text := sIp;
end;

procedure TConfigPergForm.CancelActExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TConfigPergForm.CarregTesteStarterIni;
begin
  FConfigPergTeste.LerIni;

  if FConfigPergTeste.TesteMaqLocalBuscaNome then
  begin
    BuscaLocalNomeAction.Execute;
  end;

  EhServidorCheckBox.Checked := FConfigPergTeste.TesteEhServ;

  if FConfigPergTeste.TesteLojaPreenche then
  begin
    LojaIdLabeledEdit.Text := FConfigPergTeste.TesteLojaId.ToString;
    LojaApelidoLabeledEdit.Text := FConfigPergTeste.TesteLojaApelido;
  end;

  if FConfigPergTeste.TesteUsuPreenche then
  begin
    UsuGerNomeCompletoLabeledEdit.Text := FConfigPergTeste.TesteUsuNomeCompleto;
    UsuGerNomeExibLabeledEdit.Text := FConfigPergTeste.TesteUsuNomeExib;
    UsuGerNomeUsuLabeledEdit.Text := FConfigPergTeste.TesteUsuNomeUsu;
    UsuGerSenha1LabeledEdit.Text := FConfigPergTeste.TesteUsuSenha1;
    UsuGerSenha2LabeledEdit.Text := FConfigPergTeste.TesteUsuSenha2;
    UsuGerExibSenhaCheckBox.Checked := FConfigPergTeste.TesteUsuExibSenha;
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
    ServerConfigLabeledEdit.Visible := false;
    ServerConfigSelectButton.Visible := false;

    UsuGerGroupBox.Visible := true;
    LojaIdGroupBox.Visible := true;
  end
  else
  begin
    ServerMaqFrame.Visible := true;
    ServerConfigLabeledEdit.Visible := true;
    ServerConfigSelectButton.Visible := true;

    UsuGerGroupBox.Visible := false;
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
      UsuGerNomeCompletoLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

constructor TConfigPergForm.Create(AOwner: TComponent; pSisConfig: ISisConfig;
  pUsuarioGerente: IUsuario; pLoja: ILoja; pTerminalList: ITerminalList);
begin
  inherited Create(AOwner);
  FTerminalList := pTerminalList;

  PosCol1 := Point(7, 3);
  PosCol2 := Point(COL_2_X, 3);

  FSisConfig := pSisConfig;
  FUsuarioGerente := pUsuarioGerente;
  FLoja := pLoja;
  FTerminaisDBGridFrame := TTerminaisDBGridFrame.Create(TerminaisGroupBox);
  FTerminaisDBGridFrame.Align := alClient;
  FTerminaisDBGridFrame.Preparar;
end;

procedure TConfigPergForm.ControlesToObjetos;
begin
  FSisConfig.LocalMachineId.Name := LocalMaqFrame.NomeLabeledEdit.Text;
  FSisConfig.LocalMachineId.IP := LocalMaqFrame.IpLabeledEdit.Text;

  FSisConfig.LocalMachineIsServer := EhServidorCheckBox.Checked;

  if FSisConfig.LocalMachineIsServer then
  begin
    FSisConfig.ServerMachineId.Name := FSisConfig.LocalMachineId.Name;
    FSisConfig.ServerMachineId.IP := FSisConfig.LocalMachineId.IP;
  end
  else
  begin
    FSisConfig.ServerMachineId.Name := ServerMaqFrame.NomeLabeledEdit.Text;
    FSisConfig.ServerMachineId.IP := ServerMaqFrame.IpLabeledEdit.Text;
  end;

  FSisConfig.DBMSInfo.DatabaseType := dbmstFirebird;
  FSisConfig.DBMSInfo.Version := 4.0;

  FUsuarioGerente.NomeCompleto := UsuGerNomeCompletoLabeledEdit.Text;
  FUsuarioGerente.NomeExib := UsuGerNomeExibLabeledEdit.Text;
  FUsuarioGerente.NomeDeUsuario := UsuGerNomeUsuLabeledEdit.Text;
  FUsuarioGerente.Senha := UsuGerSenha1LabeledEdit.Text;

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

  LocalMaqFrame.Width := (PosCol2.X -4) - LocalMaqFrame.Left;

  FrL := LocalMaqFrame.IpLabeledEdit.Left;
  FrW := LocalMaqFrame.IpLabeledEdit.Width;
  Off := 8;
  MaqLocalToolBar.Left := FrL + FrW + Off;

  LocalMaqFrame.GroupBox1.Caption := 'M�quina Local';
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
    LojaErroLabel.Caption := 'Campo ''' + LojaApelidoLabeledEdit.EditLabel.
      Caption + ''' � obrigat�rio';
    LojaErroLabel.Visible := true;
    LojaApelidoLabeledEdit.SetFocus;
    exit;
  end;
end;

procedure TConfigPergForm.UsuGerExibSenhaCheckBoxClick(Sender: TObject);
begin
  if UsuGerExibSenhaCheckBox.Checked then
  begin
    UsuGerSenha1LabeledEdit.PasswordChar := CHAR_NULO;
    UsuGerSenha2LabeledEdit.PasswordChar := CHAR_NULO;
    AvisoSenhaLabel.Visible := true;
  end
  else
  begin
    UsuGerSenha1LabeledEdit.PasswordChar := '*';
    UsuGerSenha2LabeledEdit.PasswordChar := '*';
    AvisoSenhaLabel.Visible := false;
  end;

end;

procedure TConfigPergForm.UsuGerNomeCompletoLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuGerNomeExibLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuGerNomeExibLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;
end;

procedure TConfigPergForm.UsuGerNomeExibLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuGerNomeUsuLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuGerNomeUsuLabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuGerNomeUsuLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuGerSenha1LabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key);
end;

function TConfigPergForm.UsuGerPodeOk: boolean;
begin
  UsuGerNomeCompletoLabeledEdit.Text :=
    Trim(StrSemAcento(UsuGerNomeCompletoLabeledEdit.Text));
  UsuGerNomeExibLabeledEdit.Text :=
    Trim(StrSemAcento(UsuGerNomeExibLabeledEdit.Text));
  UsuGerNomeUsuLabeledEdit.Text :=
    Trim(StrToName(UsuGerNomeUsuLabeledEdit.Text));

  result := TesteLabeledEditVazio(UsuGerNomeCompletoLabeledEdit,
    LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuGerNomeExibLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuGerNomeUsuLabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuGerSenha1LabeledEdit, LoginErroLabel);
  if not result then
    exit;

  result := TesteLabeledEditVazio(UsuGerSenha2LabeledEdit, LoginErroLabel);
  // if not result then
  // exit;
end;

procedure TConfigPergForm.UsuGerSenha1LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuGerSenha1LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    UsuGerSenha2LabeledEdit.SetFocus;
    exit;
  end;

  // CharSemAcento(Key);
end;

procedure TConfigPergForm.UsuGerSenha2LabeledEditChange(Sender: TObject);
begin
  LoginErroLabel.Visible := false;

end;

procedure TConfigPergForm.UsuGerSenha2LabeledEditKeyPress(Sender: TObject;
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

      Terminal.TerminalId := Tab.FieldByName('TERMINAL_ID').AsInteger;
      Terminal.Apelido := Trim(Tab.FieldByName('APELIDO').AsString);
      Terminal.NomeNaRede := Trim(Tab.FieldByName('NOME_NA_REDE').AsString);
      Terminal.IP := Trim(Tab.FieldByName('IP').AsString);
      Terminal.NFSerie := Tab.FieldByName('NF_SERIE').AsInteger;
      Terminal.LetraDoDrive := Tab.FieldByName('LETRA_DO_DRIVE').AsString[1];
      Terminal.GavetaTem := Tab.FieldByName('GAVETA_TEM').AsBoolean;
      Terminal.BalancaModoId := Tab.FieldByName('BALANCA_MODO_ID').AsInteger;
      Terminal.BalancaId := Tab.FieldByName('BALANCA_ID').AsInteger;
      Terminal.BarCodigoIni := Tab.FieldByName('BARRAS_COD_INI').AsInteger;
      Terminal.BarCodigoTam := Tab.FieldByName('BARRAS_COD_TAM').AsInteger;
      Terminal.CupomNLinsFinal := Tab.FieldByName('CUPOM_NLINS_FINAL').AsInteger;
      Terminal.SempreOffLine := Tab.FieldByName('SEMPRE_OFFLINE').AsBoolean;

      FTerminalList.Add(Terminal);
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

  end;
end;

function TConfigPergForm.ServerPodeOk: boolean;
begin
  result := ServerMaqFrame.PodeOk;
  if not result then
    exit;

  result := UsuGerPodeOk;
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
//  FTerminaisDBGridFrame.InsAction.Execute;
  //FTerminaisDBGridFrame.AltAction.Execute;
  // OkAct.Execute;
{$ENDIF}
end;

function TConfigPergForm.TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
  pErroLabel: TLabel): boolean;
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

procedure TConfigPergForm.OkActExecute(Sender: TObject);
begin
  if not PodeOk then
    exit;

  modalresult := mrOk;

  ControlesToObjetos;
end;

end.

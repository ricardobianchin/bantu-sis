unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.ModuloSistema.Types, Sis.ModuloSistema,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  App.Sessao.EventosDeSessao, Vcl.Menus, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Factory, App.UI.Form.Menu_u,
  Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types,
  Sis.Terminal, Sis.Sis.ExecTardiaDM_u, System.UITypes;

type
  TModuloBasForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleBarTextCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    TitleBarActionList_ModuloBasForm: TActionList;
    FecharAction_ModuloBasForm: TAction;
    ToolButton1: TToolButton;
    OcultarAction_ModuloBasForm: TAction;
    ToolBar2: TToolBar;
    MenuToolButton: TToolButton;
    ToolButton3: TToolButton;
    MenuAction_ModuloBasForm: TAction;
    TrocarAction_ModuloBasForm: TAction;
    PopupMenu1: TPopupMenu;
    FecharActionModuloBasForm1: TMenuItem;
    BasePanel: TPanel;
    StatusPanel1: TPanel;
    StatusLabel1: TLabel;
    OutputLabel: TLabel;
    OcultarActionModuloBasForm2: TMenuItem;
    OcultarEsteMenu1: TMenuItem;

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure OcultarAction_ModuloBasFormExecute(Sender: TObject);
    procedure TrocarAction_ModuloBasFormExecute(Sender: TObject);
    procedure FecharAction_ModuloBasFormExecute(Sender: TObject);
    procedure MenuAction_ModuloBasFormExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);

  private
    { Private declarations }
    FModuloSistema: IModuloSistema;
    FEventosDeSessao: IEventosDeSessao;
    FSessaoIndex: TSessaoIndex;
    FLogUsuario: IUsuario;
    FAppObj: IAppObj;
    FTerminalId: TTerminalId;
    FTerminal: ITerminal;

    FMenuUsaForm: Boolean;
    FExecTardia: TExecTardiaDM;
    FAppMenuForm: TAppMenuForm;

    function GetTitleBarText: string;
    procedure SetTitleBarText(Value: string);

    function GetDBMS: IDBMS;
    function GetOutput: IOutput;
    function GetProcessLog: IProcessLog;

  protected
    procedure ExibaMenu; virtual;
    function PergFechar: boolean;
    function Voltou: boolean; virtual;
    procedure DoFechar; virtual;
    function Fechou: boolean; virtual;

    function GetAppObj: IAppObj;
    property AppObj: IAppObj read GetAppObj;

    property DBMS: IDBMS read GetDBMS;
    property Output: IOutput read GetOutput;
    property ProcessLog: IProcessLog read GetProcessLog;
    property LogUsuario: IUsuario read FLogUsuario;
    property TerminalId: TTerminalId read FTerminalId write FTerminalId;
    property Terminal: ITerminal read FTerminal write FTerminal;
    function AppMenuFormCreate: TAppMenuForm; virtual;
    property MenuUsaForm: Boolean read FMenuUsaForm write FMenuUsaForm;
    property ExecTardia: TExecTardiaDM read FExecTardia;
    property AppMenuForm: TAppMenuForm read FAppMenuForm write FAppMenuForm;
    property ModuloSistema: IModuloSistema read FModuloSistema;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId); reintroduce;

    property TitleBarText: string read GetTitleBarText write SetTitleBarText;
  end;

  // TModuloBasFormClass = class of TModuloBasForm;

  // var
  // ModuloBasForm: TModuloBasForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Constants, Sis.UI.IO.Output.ProcessLog.Factory, Sis.UI.IO.Input.Perg;

{ TModuloBasForm }

// constructor TModuloBasForm.Create(AOwner: TComponent);
// begin
// inherited Create(AOwner);
// FTipoModuloSistema := moduloNaoIndicado;;
// end;

function TModuloBasForm.AppMenuFormCreate: TAppMenuForm;
begin
  Result := TAppMenuForm.Create(Self);
//  Result.PegarAction(OcultarAction_ModuloBasForm, [vkF3]);

//  Result.PegarAction(FecharAction_ModuloBasForm, [vkF4]);
end;

constructor TModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
var
  sCaption: string;
begin
  inherited Create(AOwner);
  FTerminalId := pTerminalId;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  FModuloSistema := pModuloSistema;
  FEventosDeSessao := pEventosDeSessao;
  FSessaoIndex := pSessaoIndex;
  FLogUsuario := pLogUsuario;
  FAppObj := pAppObj;
  FTerminal := FAppObj.TerminalList.TerminalIdToTerminal(FTerminalId);

  TitleBarText := FModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
    FLogUsuario.NomeExib;
//  FOutput := MudoOutputCreate;
//  FProcessLog := MudoProcessLogCreate;
  FExecTardia := TExecTardiaDM.Create(Self);

  FMenuUsaForm := False;
  AppMenuForm := nil; //AppMenuFormCreate;
  sCaption := 'Fechar ' + FModuloSistema.TipoOpcaoSisModuloDescr;
  if FTerminalId > 0 then
    sCaption := sCaption +' '+ FTerminalId.ToString;

  FecharAction_ModuloBasForm.Caption := sCaption;

  sCaption := 'Ocultar ' + FModuloSistema.TipoOpcaoSisModuloDescr;
  if FTerminalId > 0 then
    sCaption := sCaption +' '+ FTerminalId.ToString;

  OcultarAction_ModuloBasForm.Caption := sCaption;
end;

procedure TModuloBasForm.DoFechar;
begin
  FEventosDeSessao.DoFecharSessao(FSessaoIndex);
  //Free
  Close;
end;

procedure TModuloBasForm.FecharAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  Fechou;
end;

function TModuloBasForm.Fechou: boolean;
begin
  Result := PergFechar;
  if not Result then
    exit;
  DoFechar;
end;

procedure TModuloBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
    Key := 0;
    FecharAction_ModuloBasForm.Execute;
    Exit;
  end;

  case Key of
    vk_f6:
      begin
        TrocarAction_ModuloBasForm.Execute;
        Key := 0;
        exit;
      end;
  end;

  case Key of
    vk_f2:
      begin
        MenuAction_ModuloBasForm.Execute;
        Key := 0;
        exit;
      end;
  end;

  inherited;

end;

procedure TModuloBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Voltou;
  end;
  inherited;
end;

procedure TModuloBasForm.FormResize(Sender: TObject);
var
  WorkArea: TRect;
begin
  inherited;
  // Obt�m a �rea de trabalho dispon�vel
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);

  // Verifica se o formul�rio est� maximizado
  if WindowState = wsMaximized then
  begin
    // Ajusta o tamanho do formul�rio para caber na �rea de trabalho dispon�vel
    top :=0;
    left :=0;
    Width := WorkArea.Width;
    Height := WorkArea.Height;
  end;
end;

function TModuloBasForm.GetAppObj: IAppObj;
begin
  Result := FAppObj;
end;

function TModuloBasForm.GetDBMS: IDBMS;
begin
  Result := FAppObj.DBMS;
end;

function TModuloBasForm.GetOutput: IOutput;
begin
  Result := FAppObj.ProcessOutput;
end;

function TModuloBasForm.GetProcessLog: IProcessLog;
begin
  Result := FAppObj.ProcessLog;
end;

function TModuloBasForm.GetTitleBarText: string;
begin
  Result := TitleBarTextCaptionLabel.Caption;
end;

procedure TModuloBasForm.MenuAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  ExibaMenu;
end;

procedure TModuloBasForm.ExibaMenu;
var
  x, y: integer;
  oActionEscolhida: TAction;
//  FAppMenuForm: TAppMenuForm;
  bResultado: Boolean;
begin
//  if FMenuUsaForm then
//  begin
//    FAppMenuForm := AppMenuFormCreate;
//    try
//      Resultado := FAppMenuForm.Perg(oActionEscolhida);
//    finally
//      FreeAndNil(FAppMenuForm);
//    end;
//    if Resultado then
//      oActionEscolhida.Execute;
//    exit;
//  end;

  if FMenuUsaForm then
  begin
    bResultado := FAppMenuForm.Perg(oActionEscolhida);
    if bResultado then
      oActionEscolhida.Execute;
    exit;
  end;

  x := MenuToolButton.Left; //+MenuToolButton.Width;
  y := MenuToolButton.Top + MenuToolButton.Height + 1;
  PopupMenu1.Popup(x, y);
end;

procedure TModuloBasForm.OcultarAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  Hide;
  FEventosDeSessao.DoAposModuloOcultar;
end;

function TModuloBasForm.PergFechar: boolean;
var
  sMens: string;
  Resultado: TModalResult;
begin
  inherited;
  sMens := 'Deseja finalizar o m�dulo ' +
    FModuloSistema.TipoOpcaoSisModuloDescr + '?';
  Result := PergBool(sMens);
//  Resultado := MessageDlg(sMens, TMsgDlgType.mtConfirmation,
//    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);
//  Result := IsPositiveResult(Resultado);
end;

procedure TModuloBasForm.SetTitleBarText(Value: string);
begin
  TitleBarTextCaptionLabel.Caption := Value;
end;

procedure TModuloBasForm.TrocarAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  OcultarAction_ModuloBasForm.Execute;
  // FEventosDeSessao.DoTrocarDaSessao(FSessaoIndex)
end;

function TModuloBasForm.Voltou: boolean;
begin
  Result := Fechou;
end;

end.

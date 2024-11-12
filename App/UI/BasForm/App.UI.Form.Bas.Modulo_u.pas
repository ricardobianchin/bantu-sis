unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.ModuloSistema.Types, Sis.ModuloSistema,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  App.Sessao.Eventos, Vcl.Menus, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Factory,
  Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types;

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
    FSessaoEventos: ISessaoEventos;
    FSessaoIndex: TSessaoIndex;
    FLogUsuario: IUsuario;
    FAppObj: IAppObj;
    FTerminalId: TTerminalId;

    function GetTitleBarText: string;
    procedure SetTitleBarText(Value: string);
    procedure MenuExibir;
    
    function GetDBMS: IDBMS;
    function GetOutput: IOutput;
    function GetProcessLog: IProcessLog;


  protected
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
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId); reintroduce;

    property TitleBarText: string read GetTitleBarText write SetTitleBarText;
  end;

  // TModuloBasFormClass = class of TModuloBasForm;

  // var
  // ModuloBasForm: TModuloBasForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Constants, Sis.UI.IO.Output.ProcessLog.Factory;

{ TModuloBasForm }

// constructor TModuloBasForm.Create(AOwner: TComponent);
// begin
// inherited Create(AOwner);
// FTipoModuloSistema := moduloNaoIndicado;;
// end;

constructor TModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
begin
  inherited Create(AOwner);
  FTerminalId := pTerminalId;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  FModuloSistema := pModuloSistema;
  FSessaoEventos := pSessaoEventos;
  FSessaoIndex := pSessaoIndex;
  FLogUsuario := pLogUsuario;
  FAppObj := pAppObj;
  TitleBarText := FModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
    FLogUsuario.NomeExib;
//  FOutput := MudoOutputCreate;
//  FProcessLog := MudoProcessLogCreate;

end;

procedure TModuloBasForm.DoFechar;
begin
  FSessaoEventos.DoFecharSessao(FSessaoIndex);
  Free
//  Close;
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
  // Obtém a área de trabalho disponível
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);

  // Verifica se o formulário está maximizado
  if WindowState = wsMaximized then
  begin
    // Ajusta o tamanho do formulário para caber na área de trabalho disponível
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
  MenuExibir;
end;

procedure TModuloBasForm.MenuExibir;
var
  x, y: integer;
begin
  x := MenuToolButton.Left; //+MenuToolButton.Width;
  y := MenuToolButton.Top + MenuToolButton.Height + 1;
  PopupMenu1.Popup(x, y);

end;

procedure TModuloBasForm.OcultarAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  Hide;
  FSessaoEventos.DoAposModuloOcultar;
end;

function TModuloBasForm.PergFechar: boolean;
var
  sMens: string;
  Resultado: TModalResult;
begin
  inherited;
  sMens := 'Deseja finalizar o módulo ' +
    FModuloSistema.TipoOpcaoSisModuloDescr + '?';
  Resultado := MessageDlg(sMens, TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);
  Result := IsPositiveResult(Resultado);
end;

procedure TModuloBasForm.SetTitleBarText(Value: string);
begin
  TitleBarTextCaptionLabel.Caption := Value;
end;

procedure TModuloBasForm.TrocarAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  OcultarAction_ModuloBasForm.Execute;
  // FSessaoEventos.DoTrocarDaSessao(FSessaoIndex)
end;

function TModuloBasForm.Voltou: boolean;
begin
  Result := Fechou;
end;

end.

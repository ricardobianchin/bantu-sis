unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.ModuloSistema.Types, Sis.ModuloSistema,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  App.Sessao.Eventos, Vcl.Menus, App.Constants, Sis.Usuario, App.AppInfo,
  Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Factory,
  Sis.UI.IO.Output.ProcessLog;

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
    Panel1: TPanel;
    Label1: TLabel;
    OutputLabel: TLabel;
    procedure FormCreate(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure OcultarAction_ModuloBasFormExecute(Sender: TObject);
    procedure TrocarAction_ModuloBasFormExecute(Sender: TObject);
    procedure FecharAction_ModuloBasFormExecute(Sender: TObject);
    procedure MenuAction_ModuloBasFormExecute(Sender: TObject);

  private
    { Private declarations }
    FModuloSistema: IModuloSistema;
    FSessaoEventos: ISessaoEventos;
    FSessaoIndex: TSessaoIndex;
    FUsuario: IUsuario;
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FProcessLog: IProcessLog;

    function GetTitleBarText: string;
    procedure SetTitleBarText(Value: string);
    procedure MenuExibir;
    function GetSisConfig: ISisConfig;
  protected
    function PergFechar: boolean;
    function Voltou: boolean; virtual;
    procedure DoFechar; virtual;
    function Fechou: boolean; virtual;

    function GetAppInfo: IAppInfo;
    property AppInfo: IAppInfo read GetAppInfo;
    property SisConfig: ISisConfig read GetSisConfig;
    property DBMS: IDBMS read FDBMS;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pDBMS: IDBMS); reintroduce;

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
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pDBMS: IDBMS);
begin
  inherited Create(AOwner);
  FSisConfig := pSisConfig;
  TitleBarPanel.Color := COR_PRETO_TITLEBAR;
  FModuloSistema := pModuloSistema;
  FSessaoEventos := pSessaoEventos;
  FSessaoIndex := pSessaoIndex;
  FUsuario := pUsuario;
  FAppInfo := pAppInfo;
  FDBMS := pDBMS;
  TitleBarText := FModuloSistema.TipoModuloSistemaDescr + ' - ' +
    FUsuario.NomeExib;
  FOutput := MudoOutputCreate;
  FProcessLog := MudoProcessLogCreate;
end;

procedure TModuloBasForm.DoFechar;
begin
  Close;
  FSessaoEventos.DoFecharSessao(FSessaoIndex);
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

procedure TModuloBasForm.FormCreate(Sender: TObject);
begin
  inherited;

  TitleBarActionList_ModuloBasForm.Images := SisImgDataModule.ImageList_40_24;
  BoundsRect := Screen.WorkAreaRect;
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

function TModuloBasForm.GetAppInfo: IAppInfo;
begin
  Result := FAppInfo;
end;

function TModuloBasForm.GetSisConfig: ISisConfig;
begin
  Result := FSisConfig;
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
  x := MenuToolButton.Left;
  y := MenuToolButton.Top + MenuToolButton.Height;
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
    FModuloSistema.TipoModuloSistemaDescr + '?';
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

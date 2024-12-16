unit App.UI.Form.Bas.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, App.PDV.AppPDVObj,
  Sis.ModuloSistema, App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.Entities.Types, Sis.Entities.Terminal, App.PDV.Factory_u,
  App.UI.PDV.Frame_u, App.Est.Venda.CaixaSessaoDM_u, App.Est.Factory_u,
  App.UI.Form.Menu_u, System.UITypes, App.Est.Types_u,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

type
  TPDVModuloBasForm = class(TModuloBasForm)
    N1: TMenuItem;
    ConsultaPreo1: TMenuItem;
    PDVActionList: TActionList;
    PrecoBuscaAction_PDVModuloBasForm: TAction;
    CaixaSessaoAbrirTentarAction: TAction;
    PrincToolBar_PDVModuloBasForm: TToolBar;
    procedure CaixaSessaoAbrirTentarActionExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppPDVObj: IAppPDVObj;
    FFrameAtivo: TFrame;
    FCaixaSessaoDM: TCaixaSessaoDM;

    function GetFramesParent: TWinControl;
    function GetFrameAtivo: TFrame;
    procedure SetFrameAtivo(Value: TFrame);

    function GetFecharModuloAction: TAction;

  protected
    property FrameAtivo: TFrame read GetFrameAtivo write SetFrameAtivo;
    property CaixaSessaoDM: TCaixaSessaoDM read FCaixaSessaoDM;
    function AppMenuFormCreate: TAppMenuForm; override;
    procedure DecidirFrameAtivo; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce; virtual;
    property FramesParent: TWinControl read GetFramesParent;
    property FecharModuloAction: TAction read GetFecharModuloAction;
  end;

var
  PDVModuloBasForm: TPDVModuloBasForm;

implementation

{$R *.dfm}

function TPDVModuloBasForm.AppMenuFormCreate: TAppMenuForm;
begin
  Result := inherited;
  Result.PegarAction(PrecoBuscaAction_PDVModuloBasForm, [vkB]);
  Result.NovaLinha;
end;

procedure TPDVModuloBasForm.CaixaSessaoAbrirTentarActionExecute
  (Sender: TObject);
var
  a: TAction;
  s: string; // so pra visualizar o name durante o debug
begin
  inherited;
  // FreeAndNil(FFrameAtivo);

  a := FCaixaSessaoDM.GetAction(cxopAbertura);
  s := a.Name;
  a.Execute;
  DecidirFrameAtivo;
end;

constructor TPDVModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited;
  FAppPDVObj := AppPDVObjCreate;

  FCaixaSessaoDM := TCaixaSessaoDM.Create(Self, AppObj, pTerminalId,
    pLogUsuario, PrincToolBar_PDVModuloBasForm);

  MenuUsaForm := True;
  AppMenuForm := AppMenuFormCreate;
end;

procedure TPDVModuloBasForm.DecidirFrameAtivo;
begin
  FreeAndNil(FFrameAtivo);
  if FAppPDVObj.Fiscal then
  begin
    FCaixaSessaoDM.AnaliseCaixa;
    case FCaixaSessaoDM.CaixaSessaoSituacao of
      cxFechado:
        begin
          TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
            LogUsuario.NomeExib + ' - Caixa Fechado';

          FFrameAtivo := PDVFrameAvisoCreate(Self, 'É necessário abrir o caixa',
            CaixaSessaoAbrirTentarAction);
          // CaixaSessaoAbrirTentarAction.Execute;
        end;

      cxAberto:
        begin
          TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
            LogUsuario.NomeExib + ' - Caixa Aberto em ' +
            FormatDateTime('ddd dd/mm/yyyy hh:nn',
            FCaixaSessaoDM.CaixaSessao.AbertoEm);

          FFrameAtivo := nil;
        end;

      cxAbertoPorOutroUsuario:
        ;
    end;
  end;
end;

function TPDVModuloBasForm.GetFecharModuloAction: TAction;
begin
  Result := FecharAction_ModuloBasForm;
end;

function TPDVModuloBasForm.GetFrameAtivo: TFrame;
begin
  Result := FFrameAtivo;
end;

function TPDVModuloBasForm.GetFramesParent: TWinControl;
begin
  Result := Self;
end;

procedure TPDVModuloBasForm.SetFrameAtivo(Value: TFrame);
begin
  FFrameAtivo := Value;
end;

procedure TPDVModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  DecidirFrameAtivo;
end;

end.

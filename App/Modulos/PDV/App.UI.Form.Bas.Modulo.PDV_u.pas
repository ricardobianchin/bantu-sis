unit App.UI.Form.Bas.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, App.PDV.AppPDVObj,
  Sis.ModuloSistema, App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.Entities.Types, Sis.Entities.Terminal, App.PDV.Factory_u, App.PDV.Venda,
  App.UI.PDV.Frame_u, App.Est.Venda.CaixaSessaoDM_u, App.Est.Factory_u,
  App.UI.Form.Menu_u, System.UITypes, App.Est.Types_u, App.PDV.Controlador,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, App.UI.PDV.VendaBasFrame_u, Sis.DBI,
  App.PDV.DBI, App.UI.PDV.PagFrame_u;

type
  TPDVModuloBasForm = class(TModuloBasForm, IPDVControlador)
    N1: TMenuItem;
    ConsultaPreo1: TMenuItem;
    PDVActionList: TActionList;
    PrecoBuscaAction_PDVModuloBasForm: TAction;
    CaixaSessaoAbrirTentarAction: TAction;
    procedure CaixaSessaoAbrirTentarActionExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FAppPDVObj: IAppPDVObj;
    FPDVVenda: IPDVVenda;

    FFrameAtivo: TPDVFrame;
    FFrameAviso: TPDVFrame;
    FVendaFrame: TVendaBasPDVFrame;
    FPagFrame: TPagPDVFrame;

    FCaixaSessaoDM: TCaixaSessaoDM;
    FPDVDBI: IAppPDVDBI;

    FTermDBConnection: IDBConnection;

    function GetFramesParent: TWinControl;
    function GetFrameAtivo: TPDVFrame;
    procedure SetFrameAtivo(Value: TPDVFrame);

    function GetFecharModuloAction: TAction;

  protected
    property FrameAtivo: TPDVFrame read GetFrameAtivo write SetFrameAtivo;
    property CaixaSessaoDM: TCaixaSessaoDM read FCaixaSessaoDM;
    function AppMenuFormCreate: TAppMenuForm; override;
    function VendaFrameCreate: TVendaBasPDVFrame; virtual; abstract;
    function PagFrameCreate: TPagPDVFrame; virtual; abstract;
    function PDVVendaCreate: IPDVVenda; virtual; abstract;
    function PDVDBICreate: IAppPDVDBI; virtual; abstract;
    procedure DecidirFrameAtivo; virtual;

    procedure IniciarTelaVenda; virtual;
    procedure VaParaVenda; virtual;
    procedure VaParaPag; virtual;
    procedure VaParaFinaliza; virtual;
    procedure PagSomenteDinheiro; virtual;

    property PDVVenda: IPDVVenda read FPDVVenda;
    property PDVDBI: IAppPDVDBI read FPDVDBI;

    Property TermDBConnection: IDBConnection read FTermDBConnection;
  public
    { Public declarations }
    property FramesParent: TWinControl read GetFramesParent;
    property FecharModuloAction: TAction read GetFecharModuloAction;

    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce; virtual;
  end;

var
  PDVModuloBasForm: TPDVModuloBasForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory;

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
  a := FCaixaSessaoDM.GetAction(cxopAbertura);
  s := a.Name;
  a.Execute;
  DecidirFrameAtivo;
end;

constructor TPDVModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  rDBConnectionParams.Server := Terminal.IdentStr;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  FAppPDVObj := AppPDVObjCreate;
  FTermDBConnection := DBConnectionCreate('PdvModuConn', AppObj.SisConfig,
    rDBConnectionParams, nil, nil);

  MenuUsaForm := True;
  AppMenuForm := AppMenuFormCreate;

  FCaixaSessaoDM := TCaixaSessaoDM.Create(Self, AppObj, pTerminalId,
    pLogUsuario);

  FFrameAviso := PDVFrameAvisoCreate(Self, '� necess�rio abrir o caixa',
    CaixaSessaoAbrirTentarAction);
  FFrameAviso.OculteControles;

  FPDVVenda := PDVVendaCreate;
  FPDVDBI := PDVDBICreate;

  FVendaFrame := VendaFrameCreate;
  FVendaFrame.OculteControles;

  FPagFrame := PagFrameCreate;
  FPagFrame.OculteControles;
end;

procedure TPDVModuloBasForm.DecidirFrameAtivo;
begin
  if Assigned(FFrameAtivo) then
  begin
    FFrameAtivo.Visible := False;
  end;

  try
    FCaixaSessaoDM.AnaliseCaixa;

    if FAppPDVObj.Fiscal then
    begin
      if FCaixaSessaoDM.CaixaSessaoSituacao = cxFechado then
      begin
        TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
          LogUsuario.NomeExib + ' - Caixa Fechado';
        FFrameAtivo := FFrameAviso;
        exit;
      end;
    end;

    begin // abre tela venda
      TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
        LogUsuario.NomeExib + ' - Caixa Aberto em ' +
        FormatDateTime('ddd dd/mm/yyyy hh:nn',
        FCaixaSessaoDM.CaixaSessao.AbertoEm);
      IniciarTelaVenda;
    end;

    { case FCaixaSessaoDM.CaixaSessaoSituacao of
      cxFechado:
      begin
      end;

      cxAberto:
      begin
      end;
      cxAbertoPorOutroUsuario:
      ;
      end; }
  finally
    if Assigned(FrameAtivo) then
    begin
      FFrameAtivo.OculteControles;
      FFrameAtivo.Visible := True;
      FFrameAtivo.DimensioneControles;
      FFrameAtivo.AjusteControles;
      FFrameAtivo.ExibaControles;
      FFrameAtivo.Iniciar;
      // FFrameAtivo.DebugImporteTeclas;
    end;
  end;
end;

procedure TPDVModuloBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FVendaFrame.Visible then
    FVendaFrame.ExecKeyDown(Sender, Key, Shift);

  inherited;
end;

procedure TPDVModuloBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if FVendaFrame.Visible then
    FVendaFrame.ExecKeyPress(Sender, Key)
  else
    inherited;
end;

function TPDVModuloBasForm.GetFecharModuloAction: TAction;
begin
  Result := FecharAction_ModuloBasForm;
end;

function TPDVModuloBasForm.GetFrameAtivo: TPDVFrame;
begin
  Result := FFrameAtivo;
end;

function TPDVModuloBasForm.GetFramesParent: TWinControl;
begin
  Result := Self;
end;

procedure TPDVModuloBasForm.IniciarTelaVenda;
begin
  VaParaVenda;
end;

procedure TPDVModuloBasForm.PagSomenteDinheiro;
begin
  FPagFrame.PagSomenteDinheiro;
end;

procedure TPDVModuloBasForm.VaParaFinaliza;
begin
  FPDVVenda.Zerar;
  IniciarTelaVenda;
end;

procedure TPDVModuloBasForm.VaParaPag;
begin
  if Assigned(FFrameAtivo) then
  begin
    FFrameAtivo.Visible := False;
  end;

  FFrameAtivo := FPagFrame;

  if Assigned(FrameAtivo) then
  begin
    FFrameAtivo.OculteControles;
    FFrameAtivo.Visible := True;
    FFrameAtivo.DimensioneControles;
    FFrameAtivo.AjusteControles;
    FFrameAtivo.ExibaControles;
    FFrameAtivo.Iniciar;
    // FFrameAtivo.DebugImporteTeclas;
  end;
end;

procedure TPDVModuloBasForm.VaParaVenda;
begin
  if Assigned(FFrameAtivo) then
  begin
    FFrameAtivo.Visible := False;
  end;

  FFrameAtivo := FVendaFrame;

  if Assigned(FrameAtivo) then
  begin
    FFrameAtivo.OculteControles;
    FFrameAtivo.Visible := True;
    FFrameAtivo.DimensioneControles;
    FFrameAtivo.AjusteControles;
    FFrameAtivo.ExibaControles;
    FFrameAtivo.Iniciar;
    // FFrameAtivo.DebugImporteTeclas;
  end;
end;

procedure TPDVModuloBasForm.SetFrameAtivo(Value: TPDVFrame);
begin
  FFrameAtivo := Value;
end;

procedure TPDVModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  DecidirFrameAtivo;
end;

end.

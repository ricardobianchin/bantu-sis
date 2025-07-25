unit App.UI.Form.Bas.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, App.PDV.Obj,
  Sis.ModuloSistema, App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.Entities.Types, Sis.Terminal, App.PDV.Factory_u, App.PDV.Venda,
  App.UI.PDV.Frame_u, App.Est.Venda.CaixaSessaoDM_u, App.Est.Factory_u,
  App.UI.Form.Menu_u, System.UITypes, App.Est.Types_u, App.PDV.Controlador,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, App.UI.PDV.VendaBasFrame_u, Sis.DBI,
  App.PDV.DBI, App.UI.PDV.PagFrame_u, Sis.UI.Impressao, Sis.UI.Select,
  Sis.UI.Frame.Bas.Filtro_u, App.Retag.Est.ProdSelectDBI;
{
precisa rever a logica do controlador.
este form era da interface ipdvcontrolador
descobri que isto nao deve ser feito
retirei a interface da definicao e passei pra um objeto intermediario
ficou confuso
}
type
  TPDVModuloBasForm = class(TModuloBasForm)
    N1: TMenuItem;
    ConsultaPreo1: TMenuItem;
    PDVActionList: TActionList;
    PrecoBuscaAction_PDVModuloBasForm: TAction;
    CaixaSessaoAbrirTentarAction: TAction;
    SessFormAction: TAction;
    procedure CaixaSessaoAbrirTentarActionExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SessFormActionExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPDVObj: IPDVObj;
    FPDVVenda: IPDVVenda;

    FFrameAtivo: TPDVFrame;
    FFrameAviso: TPDVFrame;
    FVendaFrame: TVendaBasPDVFrame;
    FPagFrame: TPagPDVFrame;

    FCaixaSessaoDM: TCaixaSessaoDM;

    FTermDBConnection: IDBConnection;

    FPDVDBI: IAppPDVDBI;

    FImpressaoVenda: IImpressao;

    FProdSelectDBI: IDBI;
    FProdSelectFiltroFrame: TFiltroFrame;
    FProdSelect: ISelect;
    FSessFiltroFrame: TFiltroFrame;

    FPDVControlador: IPDVControlador;

    function GetFramesParent: TWinControl;
    function GetFrameAtivo: TPDVFrame;
    procedure SetFrameAtivo(Value: TPDVFrame);

    function GetFecharModuloAction: TAction;

  protected
    procedure AjusteControles; override;
    property FrameAtivo: TPDVFrame read GetFrameAtivo write SetFrameAtivo;
    property CaixaSessaoDM: TCaixaSessaoDM read FCaixaSessaoDM;
    function AppMenuFormCreate: TAppMenuForm; override;
    function VendaFrameCreate: TVendaBasPDVFrame; virtual; abstract;
    function PagFrameCreate: TPagPDVFrame; virtual; abstract;
    function PDVVendaCreate: IPDVVenda; virtual; abstract;
    function PDVObjCreate: IPDVObj; virtual; abstract;
    function PDVDBICreate: IAppPDVDBI; virtual; abstract;
    procedure DecidirPrimeiroFrameAtivo; virtual;

    procedure VaParaVenda; virtual;
    procedure VaParaPag; virtual;
    procedure VaParaFinaliza; virtual;
    procedure PagSomenteDinheiro; virtual;

    property PDVVenda: IPDVVenda read FPDVVenda;
    property PDVDBI: IAppPDVDBI read FPDVDBI;

    Property TermDBConnection: IDBConnection read FTermDBConnection;
    property PDVObj: IPDVObj read FPDVObj;
    property ImpressaoVenda: IImpressao read FImpressaoVenda;

    function ProdSelectDBICreate: IDBI; virtual; abstract;
    function ProdSelectFiltroFrameCreate: TFiltroFrame; virtual; abstract;
    function ProdSelectCreate: ISelect; virtual; abstract;
    function SessFiltroFrameCreate: TFiltroFrame; virtual; abstract;

    property ProdSelectDBI: IDBI read FProdSelectDBI;
    property ProdSelectFiltroFrame: TFiltroFrame read FProdSelectFiltroFrame;
    property ProdSelect: ISelect read FProdSelect;
    property SessFiltroFrame: TFiltroFrame read FSessFiltroFrame;

  public
    { Public declarations }
    property FramesParent: TWinControl read GetFramesParent;
    property FecharModuloAction: TAction read GetFecharModuloAction;
    property PDVControlador: IPDVControlador read FPDVControlador;

    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce; virtual;
  end;

var
  PDVModuloBasForm: TPDVModuloBasForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory, App.PDV.PDVSessForm_u;

procedure TPDVModuloBasForm.AjusteControles;
begin
  inherited;
  DecidirPrimeiroFrameAtivo;
end;

function TPDVModuloBasForm.AppMenuFormCreate: TAppMenuForm;
var
  a: TAction;
  // s: string; // so pra visualizar o name durante o debug
begin
  Result := inherited;
  Result.PegarAction(PrecoBuscaAction_PDVModuloBasForm, [vkP]);
  Result.NovaLinha;

  Result.PegarAction(SessFormAction, [vkR]);

  // a := FCaixaSessaoDM.GetAction(cxopSuprimento);
  // Result.PegarAction(a, [vkU]);
  //
  // a := FCaixaSessaoDM.GetAction(cxopSangria);
  // Result.PegarAction(a, [vkA]);
  //
  // a := FCaixaSessaoDM.GetAction(cxopFechamento);
  // Result.PegarAction(a, [vkF]);
end;

procedure TPDVModuloBasForm.CaixaSessaoAbrirTentarActionExecute
  (Sender: TObject);
var
  a: TAction;
  // s: string; // so pra visualizar o name durante o debug
begin
  inherited;
  a := FCaixaSessaoDM.GetAction(cxopAbertura);
  // s := a.Name;
  a.Execute;
  DecidirPrimeiroFrameAtivo;
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

  FPDVObj := PDVObjCreate;

  FTermDBConnection := DBConnectionCreate('PdvModuConn', AppObj.SisConfig,
    rDBConnectionParams, nil, nil);

  FPDVControlador := PDVControladorCreate;

  FCaixaSessaoDM := TCaixaSessaoDM.Create(Self, AppObj, pTerminalId,
    pLogUsuario, FPDVControlador);

  FProdSelectFiltroFrame := ProdSelectFiltroFrameCreate;
  FProdSelectDBI := ProdSelectDBICreate;
  FProdSelect := ProdSelectCreate;
  FSessFiltroFrame := SessFiltroFrameCreate;
  FSessFiltroFrame.Visible := False;

  FFrameAviso := PDVFrameAvisoCreate(Self, AppObj, FPDVObj, 'Caixa Fechado',
    CaixaSessaoAbrirTentarAction);
  FFrameAviso.OculteControles;

  FPDVVenda := PDVVendaCreate;
  FPDVDBI := PDVDBICreate;

  FVendaFrame := VendaFrameCreate;
  FVendaFrame.OculteControles;

  FPagFrame := PagFrameCreate;
  FPagFrame.OculteControles;

  FImpressaoVenda := ImpressaoTextoVendaCreate(Terminal.ImpressoraNome,
    pLogUsuario.Id, pLogUsuario.NomeExib, AppObj, Terminal, PDVVenda);

  MenuUsaForm := True;
  AppMenuForm := AppMenuFormCreate;

  // WindowState := TWindowState.wsNormal;
  // width := 1000;
  // height := 500;
end;

procedure TPDVModuloBasForm.DecidirPrimeiroFrameAtivo;
begin
  if Assigned(FFrameAtivo) then
  begin
    if FFrameAtivo = FVendaFrame then
    begin
      if Assigned(FPDVVenda) then
        if FPDVVenda.VendaId > 0 then
          exit;
    end;
    FFrameAtivo.Visible := False;
  end;

  try
    FCaixaSessaoDM.AnaliseCaixa;

    if FPDVObj.Fiscal then
    begin
      if FCaixaSessaoDM.CaixaSessaoSituacao = cxFechado then
      begin
        TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
          LogUsuario.NomeExib + ' - Caixa Fechado';
        FFrameAtivo := FFrameAviso;
        FFrameAviso.Iniciar;
        exit;
      end;
    end;

    begin // abre tela venda
      TitleBarText := ModuloSistema.TipoOpcaoSisModuloDescr + ' - ' +
        LogUsuario.NomeExib + ' - Caixa Aberto em ' +
        FormatDateTime('ddd dd/mm/yyyy hh:nn',
        FCaixaSessaoDM.CaixaSessao.AbertoEm);

      FVendaFrame.Iniciar;
      VaParaVenda;
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
      FFrameAtivo.ExibaControles;
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
  else if FPagFrame.Visible then
    FPagFrame.ExecKeyPress(Sender, Key);
  inherited;
end;

procedure TPDVModuloBasForm.FormResize(Sender: TObject);
begin
  inherited;
  if Assigned(FrameAtivo) then
  begin
    FFrameAtivo.OculteControles;
    FFrameAtivo.Visible := True;
    FFrameAtivo.DimensioneControles;
    FFrameAtivo.ExibaControles;
    // FFrameAtivo.DebugImporteTeclas;
  end;

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

procedure TPDVModuloBasForm.PagSomenteDinheiro;
begin
  FPagFrame.PagSomenteDinheiro;

  FPDVObj.Gaveta.Acione;
  FImpressaoVenda.Imprima;

  PDVVenda.Finalizado := True; // evita que tente salvar de novo
  VaParaFinaliza;

end;

procedure TPDVModuloBasForm.VaParaFinaliza;
begin

  if (not FPDVVenda.Cancelado) and (not FPDVVenda.Finalizado) then
  begin
    FPDVObj.Gaveta.Acione;
    VaParaVenda;
    FVendaFrame.ExibaMens('Finalizando a venda...');
    Application.ProcessMessages;
    // {$IFDEF DEBUG}
    // FImpressaoVenda.Imprima;
    // {$ENDIF}

    FPDVDBI.VendaFinalize;
    FImpressaoVenda.Imprima;
  end;

  FPDVVenda.Zerar;
  DecidirPrimeiroFrameAtivo;
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
    FFrameAtivo.ExibaControles;
    // FFrameAtivo.DebugImporteTeclas;
    if FPagFrame.Falta > 0 then
    begin
      FPagFrame.PagPerg;
    end;
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
    FFrameAtivo.ExibaControles;
    // FFrameAtivo.DebugImporteTeclas;
  end;
end;

procedure TPDVModuloBasForm.SessFormActionExecute(Sender: TObject);
begin
  inherited;
  App.PDV.PDVSessForm_u.Exibir(nil, Terminal.ImpressoraNome, FCaixaSessaoDM,
    SessFiltroFrame);
end;

procedure TPDVModuloBasForm.SetFrameAtivo(Value: TPDVFrame);
begin
  FFrameAtivo := Value;
end;

procedure TPDVModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//{$IFDEF DEBUG}
//  SessFormAction.Execute;
//{$ENDIF}
end;

end.

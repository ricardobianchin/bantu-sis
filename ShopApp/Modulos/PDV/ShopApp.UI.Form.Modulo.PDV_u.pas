unit ShopApp.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo.PDV_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.ModuloSistema,
  App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types,
  Sis.Terminal, App.PDV.Factory_u, App.UI.Form.Menu_u, System.UITypes,
  App.UI.PDV.VendaBasFrame_u, ShopApp.PDV.Venda, ShopApp.PDV.DBI, App.PDV.Venda,
  Sis.DBI, App.UI.PDV.PagFrame_u, App.PDV.DBI, App.PDV.Obj, ShopApp.PDV.Obj,
  Sis.UI.Select, Sis.UI.Frame.Bas.Filtro.BuscaString_u,
  Sis.UI.Frame.Bas.Filtro_u;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoBuscaAction_PDVModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FShopPDVObj: IShopPDVObj;
  protected
    function AppMenuFormCreate: TAppMenuForm; override;
    function PDVVendaCreate: IPDVVenda; override;
    function PDVObjCreate: IPDVObj; override;
    function PDVDBICreate: IAppPDVDBI; override;

    function VendaFrameCreate: TVendaBasPDVFrame; override;
    function PagFrameCreate: TPagPDVFrame; override;

    function ProdSelectFiltroFrameCreate: TFiltroFrame; override;
    function ProdSelectCreate: ISelect; override;
    function ProdSelectDBICreate: IDBI; override;
    function SessFiltroFrameCreate: TFiltroFrame; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj;
      pTerminalId: TTerminalId); override;
    destructor Destroy; override;

  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory, Sis.Sis.Constants, Sis.Sis.Atualizavel,
  Sis.UI.Controls.Factory //

    , App.PDV.Preco.PrecoBusca.Factory_u //
    , AppShop.PDV.Preco.PrecoBusca.Factory_u //
    , ShopApp.PDV.Factory_u //
    , App.PDV.PDVSessForm.FiltroFrame_u;

function TShopPDVModuloForm.AppMenuFormCreate: TAppMenuForm;
begin
  Result := inherited;

end;

constructor TShopPDVModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited;
  // AppMenuForm := AppMenuFormCreate;
  PDVControlador.PegarProcs( //
    VaParaVenda, //
    VaParaPag, //
    VaParaFinaliza, //
    PagSomenteDinheiro, //
    DecidirPrimeiroFrameAtivo //
    );
end;

destructor TShopPDVModuloForm.Destroy;
begin
end;

function TShopPDVModuloForm.PagFrameCreate: TPagPDVFrame;
begin
  Result := ShopPagPDVFrameCreate(Self, FShopPDVObj, PDVVenda, PDVDBI,
    PDVControlador);
  Result.Visible := False;
end;

function TShopPDVModuloForm.PDVDBICreate: IAppPDVDBI;
begin
  FShopAppPDVDBI := ShopAppPDVDBICreate(TermDBConnection, AppObj, PDVObj,
    Terminal, FShopPDVVenda, LogUsuario.Id);

  Result := FShopAppPDVDBI;
end;

function TShopPDVModuloForm.PDVObjCreate: IPDVObj;
begin
  FShopPDVObj := ShopPdvObjCreate(Terminal);;
  Result := FShopPDVObj;
end;

function TShopPDVModuloForm.PDVVendaCreate: IPDVVenda;
begin
  FShopPDVVenda := ShopPDVVendaCreate(AppObj.Loja //
    , TerminalId //
    , DATA_ZERADA //
    , DATA_ZERADA //
    , CaixaSessaoDM.CaixaSessao //
    );

  Result := FShopPDVVenda;
end;

procedure TShopPDVModuloForm.PrecoBuscaAction_PDVModuloBasFormExecute
  (Sender: TObject);
var
  rDBConnectionParams: TDBConnectionParams;
  ODBConnection: IDBConnection;
  DBI: IDBI;
begin
  inherited;
  rDBConnectionParams.Server := Terminal.IdentStr;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  ODBConnection := DBConnectionCreate('App.Preco.Busca.Conn', AppObj.SisConfig,
    rDBConnectionParams, nil, nil);

  DBI := ShopPrecoBuscaDBICreate(ODBConnection, AppObj);

  App.PDV.Preco.PrecoBusca.Factory_u.BuscaPrecoPerg(DBI);
end;

function TShopPDVModuloForm.ProdSelectCreate: ISelect;
begin
  Result := DBSelectFormCreate(ProdSelectDBI, ProdSelectFiltroFrame);
end;

function TShopPDVModuloForm.ProdSelectDBICreate: IDBI;
begin
  Result := ShopProdSelectDBICreate(TermDBConnection, AppObj);
end;

function TShopPDVModuloForm.ProdSelectFiltroFrameCreate: TFiltroFrame;
begin
  Result := TFiltroStringFrame.Create(Self, nil);
end;

function TShopPDVModuloForm.SessFiltroFrameCreate: TFiltroFrame;
begin
  Result := TSessFormFiltroFrame.Create(Self, nil, CaixaSessaoDM.CaixaSessaoDBI,
    ProdSelect);
end;

function TShopPDVModuloForm.VendaFrameCreate: TVendaBasPDVFrame;
begin
  // if not Assigned(FShopProdSelectDBI) then
  // FShopProdSelectDBI := ProdSelectDBICreate
  //
  // if not Assigned(FFiltroStringFrame) then
  // FFiltroStringFrame := TFiltroStringFrame.Create(Self, nil);
  //
  // if not Assigned(FShopProdSelect) then
  // FShopProdSelect := DBSelectFormCreate(FShopProdSelectDBI, FFiltroStringFrame);

  Result := ShopVendaPDVFrameCreate(Self, FShopPDVObj, PDVVenda, PDVDBI,
    PDVControlador, ProdSelect);
  Result.Visible := False;
end;

end.

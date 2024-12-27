unit ShopApp.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo.PDV_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.ModuloSistema,
  App.Sessao.EventosDeSessao, App.Constants, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Entities.Types,
  Sis.Entities.Terminal, App.PDV.Factory_u, App.UI.Form.Menu_u, System.UITypes,
  App.UI.PDV.VendaBasFrame_u, ShopApp.PDV.Venda, ShopApp.PDV.DBI, App.PDV.Venda, Sis.DBI;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoBuscaAction_PDVModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
    FShopAppPDVDBI: IShopAppPDVDBI;
  protected
    function AppMenuFormCreate: TAppMenuForm; override;
    function VendaFrameCreate: TVendaBasPDVFrame; override;
    function PDVVendaCreate: IPDVVenda; override;
    function PDVDBICreate: IDBI; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj;
      pTerminalId: TTerminalId); override;
  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory, sIS.Sis.Constants //

    , App.PDV.Preco.PrecoBusca.Factory_u //
    , AppShop.PDV.Preco.PrecoBusca.Factory_u //
    , ShopApp.UI.PDV.VendaFrame_u, ShopApp.PDV.Factory_u;

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
end;

function TShopPDVModuloForm.PDVDBICreate: IDBI;
begin
  FShopAppPDVDBI := ShopAppPDVDBICreate(TermDBConnection, CaixaSessaoDM.CaixaSessao);
  Result := FShopAppPDVDBI;
end;

function TShopPDVModuloForm.PDVVendaCreate: IPDVVenda;
begin
  Result := ShopPDVVendaCreate(
    AppObj.Loja.Id //
    , TerminalId //
    , DATA_ZERADA //
    , DATA_ZERADA //
    , CaixaSessaoDM.CaixaSessao //
    );
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

function TShopPDVModuloForm.VendaFrameCreate: TVendaBasPDVFrame;
begin
  Result := TShopVendaPDVFrame.Create(Self, PDVVenda, FShopAppPDVDBI);
  Result.Visible := False;
end;

end.

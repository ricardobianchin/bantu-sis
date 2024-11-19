unit AppShop.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.PDV_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus, App.UI.Form.Menu_u, Sis.ModuloSistema, App.Sessao.Eventos, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.Entities.Types, Sis.Entities.Terminal, App.PDV.Factory_u;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoBuscaAction_PDVModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    function AppMenuFormCreate: TAppMenuForm; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      override;
  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses Sis.DBI, Sis.DB.Factory, App.UI.Form.Menu.PDV_u

    , App.PDV.Preco.PrecoBusca.Factory_u //
    , AppShop.PDV.Preco.PrecoBusca.Factory_u //
    ;

function TShopPDVModuloForm.AppMenuFormCreate: TAppMenuForm;
begin
  Result := TAppPDVMenuForm.Create(Self, FecharAction_ModuloBasForm,
    OcultarAction_ModuloBasForm, PrecoBuscaAction_PDVModuloBasForm);
end;

constructor TShopPDVModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited;
  MenuUsaForm := True;
end;

procedure TShopPDVModuloForm.PrecoBuscaAction_PDVModuloBasFormExecute(
  Sender: TObject);
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

end.

unit AppShop.UI.Form.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.PDV_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus;

type
  TShopPDVModuloForm = class(TPDVModuloBasForm)
    procedure PrecoPergAction_ModuloBasFormExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopPDVModuloForm: TShopPDVModuloForm;

implementation

{$R *.dfm}

uses Sis.DBI, Sis.DB.DBTypes, Sis.DB.Factory

    , App.PDV.Preco.PrecoBusca.Factory_u //
    , AppShop.PDV.Preco.PrecoBusca.Factory_u //
    ;

procedure TShopPDVModuloForm.PrecoPergAction_ModuloBasFormExecute
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

end.

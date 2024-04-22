unit AppShop.UI.Form.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Config_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus, Sis.DB.DBTypes, App.DB.Import.Origem,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.DB.Import,
  Sis.ModuloSistema, App.Sessao.Eventos, App.Constants, Sis.Usuario, App.AppObj,
  Sis.UI.Controls.Utils;

type
  TShopConfigModuloForm = class(TConfigModuloBasForm)
  private
    { Private declarations }
  protected
    procedure DBImportPrep; override;
    function DBImportOrigemCreate(pItemIndex: integer)
      : IDBImportOrigem; override;
    function DBImportCreate(pDestinoDBConnection: IDBConnection;
      pDBImportOrigem: IDBImportOrigem; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil): IDBImport; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj); reintroduce;
  end;

var
  ShopConfigModuloForm: TShopConfigModuloForm;

implementation

{$R *.dfm}

uses Sis.Types, ShopApp.Import_u, AppShop.Import.Origem.PLUBase_u,
  AppShop.Import.Origem.i9PDV_u;

{ TShopConfigModuloForm }

constructor TShopConfigModuloForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pModuloSistema, pSessaoEventos, pSessaoIndex,
    pUsuario, pAppObj);
end;

function TShopConfigModuloForm.DBImportCreate(pDestinoDBConnection
  : IDBConnection; pDBImportOrigem: IDBImportOrigem; pOutput: IOutput;
  pProcessLog: IProcessLog): IDBImport;
begin
    dbimport create
end;

function TShopConfigModuloForm.DBImportOrigemCreate(pItemIndex: integer)
  : IDBImportOrigem;
begin
  case pItemIndex + 1 of
    1:
      Result := TDBImportOrigemPLUBase.Create;
    2:
      Result := TDBImportOrigemi9PDV.Create;
  end;
end;

procedure TShopConfigModuloForm.DBImportPrep;
var
  i: integer;
begin
  inherited;
  for i := Low(MercadoImportSelectItems) to High(MercadoImportSelectItems) do
  begin
    DBImportOrigemComboBox.Items.AddObject(MercadoImportSelectItems[i].Descr,
      Pointer(MercadoImportSelectItems[i].Id));
  end;
  DBImportOrigemComboBox.ItemIndex := 0;
end;

end.

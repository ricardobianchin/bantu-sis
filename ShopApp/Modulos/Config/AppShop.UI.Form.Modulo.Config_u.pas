unit AppShop.UI.Form.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo.Config_u,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Menus, Sis.DB.DBTypes, Sis.DB.Import.Origem,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.DB.Import;

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
  end;

var
  ShopConfigModuloForm: TShopConfigModuloForm;

implementation

{$R *.dfm}

uses Sis.Types, ShopApp.Import_u, AppShop.Import.Origem.PLUBase_u,
  AppShop.Import.Origem.i9PDV_u;

{ TShopConfigModuloForm }

function TShopConfigModuloForm.DBImportCreate(pDestinoDBConnection
  : IDBConnection; pDBImportOrigem: IDBImportOrigem; pOutput: IOutput;
  pProcessLog: IProcessLog): IDBImport;
begin

end;

function TShopConfigModuloForm.DBImportOrigemCreate(pItemIndex: integer)
  : IDBImportOrigem;
begin
  case pItemIndex of
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

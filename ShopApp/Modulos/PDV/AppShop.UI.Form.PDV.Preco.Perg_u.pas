unit AppShop.UI.Form.PDV.Preco.Perg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.PDV.Preco.Perg_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.DB.DBTypes, Vcl.Mask, App.AppObj, Sis.Entities.Types;

type
  TShopPrecoPregForm = class(TPrecoPregForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PrecoPerg(pAppObj: IAppObj; pTerminalId: TTerminalId): Boolean;

// var
// ShopPrecoPregForm: TShopPrecoPregForm;

implementation

{$R *.dfm}

function PrecoPerg(pAppObj: IAppObj; pTerminalId: TTerminalId): Boolean;
var
  ShopPrecoPregForm: TShopPrecoPregForm;
begin
  ShopPrecoPregForm := TShopPrecoPregForm.Create(nil);
  try
    ShopPrecoPregForm.Perg;
  finally
    FreeAndNil(ShopPrecoPregForm);
  end;
end;

end.

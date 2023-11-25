unit AppShop.UI.Form.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ.Modulos_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls;

type
  TShopPrincForm = class(TModulosPrincBasForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShopPrincForm: TShopPrincForm;

implementation

{$R *.dfm}

end.

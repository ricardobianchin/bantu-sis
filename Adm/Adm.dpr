program Adm;

uses
  AppShop.UI.Form.Princ_u,
  Vcl.Forms;

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.ShowMainForm := False;
  Application.CreateForm(TShopPrincForm, ShopPrincForm);
  Application.Run;
end.

program Adm;

uses
  AppShop.UI.Form.Princ_u,
  FireDAC.Stan.Async,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.ShowMainForm := False;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TShopPrincForm, ShopPrincForm);
  Application.Run;
end.

program Adm;

uses
  AppShopPrincForm_u,
  Vcl.Forms;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.CreateForm(TAppShopPrincForm, AppShopPrincForm);
  Application.Run;
end.

program Adm;

uses
  AppShop.UI.Form.Princ_u,
  Vcl.Forms,
  Sis.UI.IO.Output.ProcessLog.ProcessLogFile_u in '..\Sis\UI\IO\Output\ProcessLog\Sis.UI.IO.Output.ProcessLog.ProcessLogFile_u.pas';

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.ShowMainForm := False;
  Application.CreateForm(TAppShopPrincForm, AppShopPrincForm);
  Application.Run;
end.

program BantuStarter;

uses
  Vcl.Forms,
  btu.sta.FormPrinc in 'ui\btu.sta.FormPrinc.pas' {PrincForm},
  btu.sta.exec_u in 'sta\btu.sta.exec_u.pas',
  btu.sta.Form.Config in 'ui\btu.sta.Form.Config.pas' {StarterFormConfig},
  ControlsReposition in '..\bantu-lib\sis\ui\FormDecorators\ControlsAlign\ControlsReposition.pas',
  btu.sta.MaqNomeEdFrame in 'ui\btu.sta.MaqNomeEdFrame.pas' {MaqNomeEdFrame: TFrame},
  btu.lib.ui.Img.DataModule in '..\bantu-lib\sis\ui\FormDecorators\btu.lib.ui.Img.DataModule.pas' {SisImgDataModule: TDataModule},
  btu.lib.config.machineid in '..\bantu-lib\sis\config\btu.lib.config.machineid.pas',
  btu.lib.config in '..\bantu-lib\sis\config\btu.lib.config.pas',
  btu.lib.config.machineid_u in '..\bantu-lib\sis\config\btu.lib.config.machineid_u.pas',
  btu.lib.config_u in '..\bantu-lib\sis\config\btu.lib.config_u.pas',
  btu.lib.config.factory in '..\bantu-lib\sis\config\btu.lib.config.factory.pas',
  winversion in '..\bantu-lib\sis\win\winversion.pas',
  winplatform in '..\bantu-lib\sis\win\winplatform.pas',
  btu.lib.files in '..\bantu-lib\sis\files\btu.lib.files.pas',
  btu.lib.win.VersionInfo in '..\bantu-lib\sis\win\btu.lib.win.VersionInfo.pas',
  btu.lib.win.VersionInfo_u in '..\bantu-lib\sis\win\btu.lib.win.VersionInfo_u.pas',
  btu.lib.win.factory in '..\bantu-lib\sis\win\btu.lib.win.factory.pas',
  btu.lib.sis.constants in '..\bantu-lib\sis\sis\btu.lib.sis.constants.pas',
  btu.lib.types.constants in '..\bantu-lib\sis\types\btu.lib.types.constants.pas',
  btu.lib.win.constants in '..\bantu-lib\sis\win\btu.lib.win.constants.pas',
  btu.sta.constants in 'sta\btu.sta.constants.pas';

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;
  Application.CreateForm(TPrincForm, PrincForm);
  Application.Run;
end.

unit btu.lib.sis.factory;

interface

uses btu.lib.sis_i;

function SisCreate: ISis;

implementation

uses Spring.Container, btu.lib.ui.Img.DataModule, btu.lib.sis_u, Vcl.Forms;

function SisCreate: ISis;
var
  oDim: TContainer;
begin
  oDIM := Spring.Container.GlobalContainer;
  SisImgDataModule := TSisImgDataModule.Create(Application);

  result := TSis.Create(oDim, SisImgDataModule);
end;

end.

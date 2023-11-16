program RetagAntigo;

uses
  Vcl.Forms,
  sis.ui.Img.DataModule in '..\bantu-lib\sis\ui\FormDecorators\sis.ui.Img.DataModule.pas' {SisImgDataModule: TDataModule},
  retag.ui.Form.Princ in 'ui\retag.ui.Form.Princ.pas' {RetagPrincForm},
  btu.sis.di.ui.constants in '..\bantu-lib\sis\di\ui\btu.sis.di.ui.constants.pas',
  ChildForm_u in 'ui\ChildForm_u.pas' {ChildForm},
  CategoriasChildForm_u in 'ui\CategoriasChildForm_u.pas' {CategoriasChildForm},
  sis.types.strings in '..\bantu-lib\sis\types\str\sis.types.strings.pas',
  DiagForm_u in 'ui\DiagForm_u.pas' {DiagForm},
  CategoriasDiagForm_u in 'ui\CategoriasDiagForm_u.pas' {CategDiagForm},
  usu_u in 'usu\usu_u.pas',
  LoginDiagForm_u in 'ui\LoginDiagForm_u.pas' {LoginDiagForm},
  retag.ui.form.defaut in 'ui\retag.ui.form.defaut.pas' {TabDefaultForm},
  UsuCatChildForm_u in 'ui\UsuCatChildForm_u.pas' {UsuCategChildForm},
  UsuCategDiagForm_u in 'ui\UsuCategDiagForm_u.pas' {UsuCategDiagForm},
  bnt.sis.ctrls.CustomFlatBtn in '..\bantu-lib\ctrls\bnt.sis.ctrls.CustomFlatBtn.pas',
  bnt.sis.ctrls.CustomFlatBtnFace in '..\bantu-lib\ctrls\bnt.sis.ctrls.CustomFlatBtnFace.pas',
  bnt.sis.ctrls.FlatBtn in '..\bantu-lib\ctrls\bnt.sis.ctrls.FlatBtn.pas',
  bnt.sis.ctrls.FlatBtnFace in '..\bantu-lib\ctrls\bnt.sis.ctrls.FlatBtnFace.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRetagPrincForm, RetagPrincForm);
  Application.Run;
end.

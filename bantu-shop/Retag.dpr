program Retag;

uses
  Vcl.Forms,
  Btu.UI.BasForm_u in '..\bantu-lib\UI\BasForm\Btu.UI.BasForm_u.pas' {BasForm},
  Btu.UI.BasForm.Princ_u in '..\bantu-lib\UI\BasForm\Btu.UI.BasForm.Princ_u.pas' {PrincBasForm},
  Ret.UI.PrincForm in 'ui\Ret.UI.PrincForm.pas' {RetagPrincForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRetagPrincForm, RetagPrincForm);
  Application.Run;
end.

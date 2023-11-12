program Retag;

uses
  Vcl.Forms,
  Ret.UI.PrincForm in 'ui\Ret.UI.PrincForm.pas' {RetagPrincForm},
  Btu.UI.BasForm_u in '..\..\bantu-lib\Comuns\UI\BasForm\Btu.UI.BasForm_u.pas' {BasForm},
  Btu.UI.BasForm.Princ_u in '..\..\bantu-lib\Comuns\UI\BasForm\Btu.UI.BasForm.Princ_u.pas' {PrincBasForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRetagPrincForm, RetagPrincForm);
  Application.CreateForm(TBasForm, BasForm);
  Application.CreateForm(TPrincBasForm, PrincBasForm);
  Application.Run;
end.

program Retag;

uses
  Vcl.Forms,
  ret.ui.PrincForm in 'ui\ret.ui.PrincForm.pas' {RetagPrincForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRetagPrincForm, RetagPrincForm);
  Application.Run;
end.

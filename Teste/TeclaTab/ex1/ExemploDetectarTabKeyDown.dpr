program ExemploDetectarTabKeyDown;

uses
  Vcl.Forms,
  TestForm_u in 'TestForm_u.pas' {TestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.

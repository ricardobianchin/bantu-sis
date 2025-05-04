program TestaDtControl1;

uses
  Vcl.Forms,
  TestaDtControlForm_u in 'TestaDtControlForm_u.pas' {TestaDtControlForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestaDtControlForm, TestaDtControlForm);
  Application.Run;
end.

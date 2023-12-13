program LogMonitor;

uses
  Vcl.Forms,
  LogMon.UI.Princ.Form_u in 'UI\LogMon.UI.Princ.Form_u.pas' {LogMonForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogMonForm, LogMonForm);
  Application.Run;
end.

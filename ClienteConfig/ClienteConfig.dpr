program ClienteConfig;

uses
  Vcl.Forms,
  CliConf.UI.Form.Princ_u in 'UI\CliConf.UI.Form.Princ_u.pas' {ClienteConfigForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClienteConfigForm, ClienteConfigForm);
  Application.Run;
end.

program PanelLayout;

uses
  Vcl.Forms,
  PanelLayoutForm_u in 'PanelLayoutForm_u.pas' {PanelLayoutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPanelLayoutForm, PanelLayoutForm);
  Application.Run;
end.

program ToolsDBAtu;

uses
  Vcl.Forms,
  ToolsDBAtuForm_u in 'ToolsDBAtuForm_u.pas' {ToolsDBAtuForm},
  ToolsDBAtu.Factory_u in 'ToolsDBAtu.Factory_u.pas',
  ToolsDBAtu.Config in 'Config\ToolsDBAtu.Config.pas',
  ToolsDBAtu.Config_u in 'Config\ToolsDBAtu.Config_u.pas',
  ToolsDBAtu.ConfigXMLI_u in 'Config\ToolsDBAtu.ConfigXMLI_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TToolsDBAtuForm, ToolsDBAtuForm);
  Application.Run;
end.

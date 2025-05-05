program TestaDtControl1;

uses
  Vcl.Forms,
  TestaDtControlForm_u in 'TestaDtControlForm_u.pas' {TestaDtControlForm},
  Sis.UI.Frame.Bas_u in '..\..\..\..\..\Sis\UI\BasForm\Sis.UI.Frame.Bas_u.pas',
  Sis.UI.Frame.Control.DateTime_u in '..\..\..\..\..\Sis\UI\BasForm\DateTimeFrame\Sis.UI.Frame.Control.DateTime_u.pas' {DateTimeFrame},
  Sis.UI.Frame.Bas.Control_u in '..\..\..\..\..\Sis\UI\BasForm\Sis.UI.Frame.Bas.Control_u.pas',
  Sis.Types.strings_u in '..\..\..\..\..\Sis\Types\Sis.Types.strings_u.pas',
  Sis.Types.Utils_u in '..\..\..\..\..\Sis\Types\Sis.Types.Utils_u.pas',
  Sis.UI.IO.Files in '..\..\..\..\..\Sis\UI\IO\Files\Sis.UI.IO.Files.pas',
  Sis.UI.IO.Output.ProcessLog in '..\..\..\..\..\Sis\UI\IO\Output\ProcessLog\Sis.UI.IO.Output.ProcessLog.pas',
  Sis.UI.Controls.Utils in '..\..\..\..\..\Sis\UI\Controls\Sis.UI.Controls.Utils.pas',
  Sis.UI.Constants in '..\..\..\..\..\Sis\UI\Sis.UI.Constants.pas',
  sndkey32 in '..\..\..\..\..\Sis\UI\IO\sndkey32.pas',
  Sis.Types.Integers in '..\..\..\..\..\Sis\Types\Sis.Types.Integers.pas',
  Sis.Sis.Constants in '..\..\..\..\..\Sis\Sis\Sis.Sis.Constants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestaDtControlForm, TestaDtControlForm);
  Application.Run;
end.

program Edit1Teste;

uses
  Vcl.Forms,
  Edit1TesteForm_u in 'Edit1TesteForm_u.pas' {Edit1TesteForm},
  CustomEditBtu in '..\..\..\Sis\UI\Controls\Edits\CustomEditBtu.pas',
  CustomNumEditBtu in '..\..\..\Sis\UI\Controls\Edits\CustomNumEditBtu.pas',
  NumEditBtn in '..\..\..\Sis\UI\Controls\Edits\NumEditBtn.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TEdit1TesteForm, Edit1TesteForm);
  Application.Run;
end.

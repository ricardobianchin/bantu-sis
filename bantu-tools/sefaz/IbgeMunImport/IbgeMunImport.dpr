program IbgeMunImport;

uses
  Vcl.Forms,
  IbgeMunImportForm_u in 'IbgeMunImportForm_u.pas' {Form2},
  btn.lib.types.strings in '..\..\..\bantu-lib\sis\types\str\btn.lib.types.strings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

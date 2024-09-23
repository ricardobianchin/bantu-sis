program TesteCrypt1;

uses
  Vcl.Forms,
  Crypt1Form_u in 'Crypt1Form_u.pas' {Form2},
  Sis.Types.strings.Crypt_u in '..\..\..\Sis\Types\Crypt\Sis.Types.strings.Crypt_u.pas',
  Sis.Types.strings.Crypt1_u in '..\..\..\Sis\Types\Crypt\Sis.Types.strings.Crypt1_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

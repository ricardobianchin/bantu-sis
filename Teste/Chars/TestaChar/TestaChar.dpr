program TestaChar;

uses
  Vcl.Forms,
  TestaCharF_u in 'TestaCharF_u.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

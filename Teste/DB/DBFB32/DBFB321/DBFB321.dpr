program DBFB321;

uses
  Vcl.Forms,
  DBFB321Form_u in 'DBFB321Form_u.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

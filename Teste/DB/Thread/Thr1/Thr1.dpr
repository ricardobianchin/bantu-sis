program Thr1;

uses
  Vcl.Forms,
  Thr1Form_u in 'Thr1Form_u.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

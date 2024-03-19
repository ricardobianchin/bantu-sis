program NumEditTeste1;

uses
  Vcl.Forms,
  NumEditTesteForm_u in 'NumEditTesteForm_u.pas' {NumEditTesteForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TNumEditTesteForm, NumEditTesteForm);
  Application.Run;
end.

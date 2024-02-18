program TesteBut;

uses
  Vcl.Forms,
  TesteButForm_u in 'TesteButForm_u.pas' {TesteButForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TTesteButForm, TesteButForm);
  Application.Run;
end.

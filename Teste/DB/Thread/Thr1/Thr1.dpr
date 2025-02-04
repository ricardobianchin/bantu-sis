program Thr1;

uses
  Vcl.Forms,
  Thr1Form_u in 'Thr1Form_u.pas' {Thr1Form},
  ConexDM_u in 'ConexDM_u.pas' {ConexDM: TDataModule},
  ProdCopiarThread_u in 'ProdCopiarThread_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TThr1Form, Thr1Form);
  Application.Run;
end.

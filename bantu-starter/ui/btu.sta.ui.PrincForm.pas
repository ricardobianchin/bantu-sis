unit btu.sta.ui.PrincForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, btu.sis.ui.io.log, btu.sis.ui.io.output.form_u,
  btu.sis.ui.io.output, Vcl.AppEvnts;

type
  TPrincForm = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    { Private declarations }
    FLog: ILog;
    FOutputForm: TOutputForm;
    FOutputToForm: IOutput;
  public

    { Public declarations }
  end;

var
  PrincForm: TPrincForm;

implementation

{$R *.dfm}

uses btu.sta.exec_u, btu.lib.ui.Img.DataModule, btu.sis.ui.io.log.factory,
  btu.sis.ui.io.factory;

procedure TPrincForm.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//  ShowMessage(e.ClassName+' '+e.Message);
end;

procedure TPrincForm.FormCreate(Sender: TObject);
var
  e: TStarterExec;
begin
  SisImgDataModule := TSisImgDataModule.Create(self);
  FLog := LogFileCreate( 'Starter');

  FOutputForm := TOutputForm.Create(self);
  FOutputToForm := OutputToFormCreate(FOutputForm);
  FLog.Exibir('TPrincForm.FormCreate, TStarterExec.Create');
  e := TStarterExec.Create(FLog, FOutputToForm);
  try
    e.Execute;
  finally
    e.Free;
  end;
  FLog.Exibir('Vai finalizar a aplicação');
  Application.Terminate;
end;

end.

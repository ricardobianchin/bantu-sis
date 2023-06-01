unit btu.sta.FormPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TPrincForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  PrincForm: TPrincForm;

implementation

{$R *.dfm}

uses btu.sta.exec_u, btu.lib.ui.Img.DataModule;

procedure TPrincForm.FormCreate(Sender: TObject);
var
  e: TStarterExec;
begin
  SisImgDataModule := TSisImgDataModule.Create(self);

  e := TStarterExec.Create;
  try
    e.Execute;
  finally
    e.Free;
  end;

  Application.Terminate;
end;

end.

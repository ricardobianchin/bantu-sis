unit Btu.UI.BasForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TBasForm = class(TForm)
    ShowTimerBas: TTimer;
    procedure FormShow(Sender: TObject);
    procedure ShowTimerBasTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BasForm: TBasForm;

implementation

{$R *.dfm}

procedure TBasForm.FormShow(Sender: TObject);
begin
  ShowTimerBas.Enabled := True;
end;

procedure TBasForm.ShowTimerBasTimer(Sender: TObject);
begin
  ShowTimerBas.Enabled := False;

end;

end.

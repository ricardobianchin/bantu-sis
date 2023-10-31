unit Ret.UI.PrincForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Btu.UI.BasForm.Princ_u, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TRetagPrincForm = class(TPrincBasForm)
    CloseTimer: TTimer;
    Label1: TLabel;
    procedure ShowTimerBasTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RetagPrincForm: TRetagPrincForm;

implementation

{$R *.dfm}

procedure TRetagPrincForm.CloseTimerTimer(Sender: TObject);
begin
  inherited;
  CloseTimer.enabled := False;
  Close;
end;

procedure TRetagPrincForm.ShowTimerBasTimer(Sender: TObject);
begin
  inherited;
  CloseTimer.enabled := True;
end;

end.

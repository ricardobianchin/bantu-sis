unit App.UI.Form.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TBasForm = class(TForm)
    ShowTimer_BasForm: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

  private
    { Private declarations }
    FDisparaShowTimer: Boolean;
    function GetDisparaShowTimer: Boolean;
    procedure SetDisparaShowTimer(Value: Boolean);
    procedure DispareShowTimer;

  protected
    property DisparaShowTimer: Boolean read GetDisparaShowTimer write SetDisparaShowTimer;

  public
    { Public declarations }

  end;

var
  BasForm: TBasForm;

implementation

{$R *.dfm}

procedure TBasForm.DispareShowTimer;
begin
  if not FDisparaShowTimer then
    exit;

  ShowTimer_BasForm.Enabled := True;
end;

procedure TBasForm.FormCreate(Sender: TObject);
begin
  FDisparaShowTimer := false;
end;

procedure TBasForm.FormShow(Sender: TObject);
begin
  DispareShowTimer;
end;

function TBasForm.GetDisparaShowTimer: Boolean;
begin
  Result := FDisparaShowTimer;
end;

procedure TBasForm.SetDisparaShowTimer(Value: Boolean);
begin
  FDisparaShowTimer := Value;
end;

procedure TBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  ShowTimer_BasForm.Enabled := False;
end;

end.

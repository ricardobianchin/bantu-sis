unit TestaDtControlForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Control.DateTime_u,
  Vcl.StdCtrls;

type
  TTestaDtControlForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    DateTimeFrame: TDateTimeFrame;
  public
    { Public declarations }
  end;

var
  TestaDtControlForm: TTestaDtControlForm;

implementation

{$R *.dfm}

procedure TTestaDtControlForm.Button1Click(Sender: TObject);
var
  d: TDateTime;
  s: string;
begin
  d := DateTimeFrame.Value;
  s := DateTimeToStr(d);
  Label1.Caption := s;
end;

procedure TTestaDtControlForm.FormCreate(Sender: TObject);
begin
  DateTimeFrame := TDateTimeFrame.Create(self);
  DateTimeFrame.Parent := self;
  DateTimeFrame.Value := Now;
end;

end.

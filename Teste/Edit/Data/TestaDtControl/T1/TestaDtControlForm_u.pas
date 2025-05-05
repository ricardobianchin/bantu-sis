unit TestaDtControlForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Control.DateTime_u;

type
  TTestaDtControlForm = class(TForm)
    procedure FormCreate(Sender: TObject);
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

procedure TTestaDtControlForm.FormCreate(Sender: TObject);
begin
  DateTimeFrame := TDateTimeFrame.Create(self);
  DateTimeFrame.Parent := self;
  DateTimeFrame.Value := Now;
end;

end.

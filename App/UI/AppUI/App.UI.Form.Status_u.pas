unit App.UI.Form.Status_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TStatusForm = class(TForm)
    FundoPanel: TPanel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StatusForm: TStatusForm;

implementation

{$R *.dfm}

procedure TStatusForm.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
end;

end.

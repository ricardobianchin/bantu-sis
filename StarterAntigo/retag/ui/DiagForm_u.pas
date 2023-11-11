unit DiagForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList;

type
  TDiagForm = class(TForm)
    ActionList1: TActionList;
    OkAction: TAction;
    CancAction: TAction;
    OkButton: TButton;
    CancButton: TButton;
    ErroLabel: TLabel;
    procedure CancActionExecute(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function PodeOk: boolean; virtual;
  public
    { Public declarations }
  end;

var
  DiagForm: TDiagForm;

implementation

{$R *.dfm}

procedure TDiagForm.CancActionExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TDiagForm.FormCreate(Sender: TObject);
begin
  ErroLabel.Caption := '';
end;

procedure TDiagForm.OkActionExecute(Sender: TObject);
begin
  if not PodeOk then
    exit;

  modalresult := mrOk;
end;

function TDiagForm.PodeOk: boolean;
begin
  result := true;
end;

end.

unit Sis.UI.Form.Bas.Diag_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Sis.UI.IO.Output, Sis.UI.IO.Factory;

type
  TDiagBasForm = class(TBasForm)
    ActionList1_Diag: TActionList;
    OkAct_Diag: TAction;
    CancelAct_Diag: TAction;
    MensLabel: TLabel;
    procedure OkAct_DiagExecute(Sender: TObject);
    procedure CancelAct_DiagExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FErroOutput: IOutput;
  protected
    function PodeOk: boolean; virtual;
    procedure MensLimpar;
    property ErroOutput: IOutput read FErroOutput;
  public
    { Public declarations }
  end;

var
  DiagBasForm: TDiagBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Constants;

procedure TDiagBasForm.CancelAct_DiagExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TDiagBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  FErroOutput := LabelOutputCreate(MensLabel);
//  MensLabel.Font.Color := COR_ERRO;
  MensLabel.Font.Color := $009393FF;

  MensLimpar;
end;

procedure TDiagBasForm.MensLimpar;
begin
  MensLabel.Caption := '';
end;

procedure TDiagBasForm.OkAct_DiagExecute(Sender: TObject);
begin
  inherited;
  if not PodeOk then
    exit;

  ModalResult := mrOk;
end;

function TDiagBasForm.PodeOk: boolean;
begin
  Result := true;
end;

end.

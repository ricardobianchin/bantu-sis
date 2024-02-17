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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FErroOutput: IOutput;
  protected
    function PodeOk: boolean; virtual;
    procedure MensLimpar;
    property ErroOutput: IOutput read FErroOutput;
  public
    { Public declarations }
    function Perg: boolean;
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
  MensLabel.Alignment := taCenter;
  FErroOutput := LabelOutputCreate(MensLabel);
//  MensLabel.Font.Color := COR_ERRO;
  MensLabel.Font.Color := $009393FF;

  MensLimpar;
end;

procedure TDiagBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    Key := #0;
    CancelAct_Diag.Execute;
  end;
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

function TDiagBasForm.Perg: boolean;
var
  Resultado: TModalResult;
begin
  Resultado := ShowModal;
  Result := IsPositiveResult(Resultado);
end;

function TDiagBasForm.PodeOk: boolean;
begin
  Result := True;
end;

end.

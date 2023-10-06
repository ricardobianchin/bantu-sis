unit btu.sis.ui.io.output.toform_u;

interface

uses btu.sis.ui.io.output, btu.sis.ui.io.output.form_u, Vcl.Dialogs;

type
  TOutputToForm = class(TInterfacedObject, IOutput)
  private
    FOutputForm: TOutputForm;

    function GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);

  public
    property Enabled: boolean read GetEnabled write SetEnabled;
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
    constructor Create(pOutputForm: TOutputForm);
  end;

implementation

{ TOutputToForm }

uses btu.sis.ui.io.output.exibirpausa.form_u;

constructor TOutputToForm.Create(pOutputForm: TOutputForm);
begin
  FOutputForm := pOutputForm;
  SetEnabled(False);
end;

procedure TOutputToForm.Exibir(pFrase: string);
begin
  if not Enabled then
    exit;

  FOutputForm.AddLinha(pFrase);
end;

procedure TOutputToForm.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
  btu.sis.ui.io.output.exibirpausa.form_u.Exibir(pFrase, pMsgDlgType);
end;

function TOutputToForm.GetEnabled: boolean;
begin
  result := FOutputForm.Visible;
end;

procedure TOutputToForm.SetEnabled(Value: boolean);
begin
  if Value then
    FOutputForm.Visible := true
  else
    FOutputForm.Hide;
end;

end.

unit Sis.UI.IO.Factory;

interface

uses
  Sis.UI.IO.Output, Sis.UI.IO.Output.Form_u, Vcl.StdCtrls;

function OutputMudoCreate: IOutput;
function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;
function OutputToLabelCreate(pLabel: TLabel): IOutput;

implementation

uses
  Sis.UI.IO.Output.Mudo_u, Sis.UI.IO.Output.ToForm_u,
  Sis.UI.IO.Output.ToLabel_u;

function OutputMudoCreate: IOutput;
begin
  Result := TOutputMudo.Create;
end;

function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;
begin
  Result := TOutputToForm.Create(pOutputForm);
end;

function OutputToLabelCreate(pLabel: TLabel): IOutput;
begin
  Result := TOutputToLabel.Create(pLabel);
end;

end.

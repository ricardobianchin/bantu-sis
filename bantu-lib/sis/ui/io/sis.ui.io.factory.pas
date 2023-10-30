unit Sis.UI.IO.Factory;

interface

uses
  sis.ui.io.output, sis.ui.io.output.form_u;

function OutputMudoCreate: IOutput;
function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;

implementation

uses
  sis.ui.io.output.mudo_u, sis.ui.io.output.toform_u;

function OutputMudoCreate: IOutput;
begin
  Result := TOutputMudo.Create;
end;

function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;
begin
  Result := TOutputToForm.Create(pOutputForm);
end;

end.

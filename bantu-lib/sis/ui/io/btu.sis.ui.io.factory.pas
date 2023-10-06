unit btu.sis.ui.io.factory;

interface

uses
  btu.sis.ui.io.output, btu.sis.ui.io.output.form_u;

function OutputMudoCreate: IOutput;
function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;

implementation

uses
  btu.sis.ui.io.output.mudo_u, btu.sis.ui.io.output.toform_u;

function OutputMudoCreate: IOutput;
begin
  Result := TOutputMudo.Create;
end;

function OutputToFormCreate(pOutputForm: TOutputForm): IOutput;
begin
  Result := TOutputToForm.Create(pOutputForm);
end;

end.

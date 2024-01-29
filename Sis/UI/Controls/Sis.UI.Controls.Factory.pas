unit Sis.UI.Controls.Factory;

interface

uses Sis.UI.Controls.Alinhador;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;

implementation

uses Sis.UI.Controls.Alinhador.ADireita_u;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
begin
  Result := TControlsAlinhadorADireita.Create;
end;

end.

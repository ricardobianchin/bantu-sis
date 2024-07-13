unit Sis.UI.Controls.Factory;

interface

uses Sis.UI.Controls.Alinhador, Sis.UI.Controls.ComboBoxManager, Vcl.StdCtrls;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;

implementation

uses Sis.UI.Controls.Alinhador.ADireita_u, Sis.UI.Controls.ComboBoxManager_u;

function ControlsAlinhadorADireitaCreate: IControlsAlinhador;
begin
  Result := TControlsAlinhadorADireita.Create;
end;

function ComboBoxManagerCreate(pComboBox: TComboBox): IComboBoxManager;
begin
  Result := TComboBoxManager.Create(pComboBox);
end;

end.

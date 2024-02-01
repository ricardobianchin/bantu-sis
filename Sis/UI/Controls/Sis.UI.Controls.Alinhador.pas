unit Sis.UI.Controls.Alinhador;

interface

uses Vcl.Controls;

type
  IControlsAlinhador = interface(IInterface)
    ['{C47B7D6A-D75E-40C5-9E4C-9013F7FC05D9}']
    procedure PegarControl(pControl: TControl);
    procedure Execute;
  end;

implementation

end.

unit App.EstadosCivis;

interface

uses System.Classes;

type
  IEstadosCivis = interface(IInterface)
    ['{89D1CE82-BCD2-4C22-857D-509F18BD61F9}']
    function GetValoresSL: TStrings;
    property ValoresSL: TStrings read GetValoresSL;
  end;

implementation

end.

unit App.Generos;

interface

uses System.Classes;

type
  IGeneros = interface(IInterface)
    ['{2D324CC2-7BDF-431E-A503-24472FF6EC20}']
    function GetValoresSL: TStrings;
    property ValoresSL: TStrings read GetValoresSL;
  end;

implementation

end.

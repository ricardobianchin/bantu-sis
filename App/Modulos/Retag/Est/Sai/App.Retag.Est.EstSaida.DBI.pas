unit App.Retag.Est.EstSaida.DBI;

interface

uses App.Est.EstMovDBI, System.Classes;

type
  IEstSaidaDBI = interface(IEstMovDBI)
    ['{D7C63368-EEA8-4CAC-96BE-9A6127796229}']
    procedure SaidaMotivoPrepareLista(pSL: TStrings);
  end;

implementation

end.

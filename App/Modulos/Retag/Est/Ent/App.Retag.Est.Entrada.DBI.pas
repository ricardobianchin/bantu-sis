unit App.Retag.Est.Entrada.DBI;

interface

uses App.Est.EstMovDBI, System.Classes;

type
  IEntradaDBI = interface(IEstMovDBI)
    ['{DFBBA6C6-2075-48BD-958B-BCF250C58994}']
    procedure FornecedorPrepareLista(pSL: TStrings);
    procedure UpdateItem;
  end;

implementation

end.

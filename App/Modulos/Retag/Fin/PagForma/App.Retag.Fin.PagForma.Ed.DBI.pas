unit App.Retag.Fin.PagForma.Ed.DBI;

interface

uses Sis.DBI, App.Retag.Fin.PagForma.Ent, System.Classes;

type
  IPagFormaEdDBI = interface(IDBI)
    ['{8902FF59-D26E-46E1-BFEF-C3D142F70F76}']
    function DescrsExistentesGet(pPagFormaEnt: IPagFormaEnt;
      pResultsSL: TStrings): boolean;
  end;

implementation

end.

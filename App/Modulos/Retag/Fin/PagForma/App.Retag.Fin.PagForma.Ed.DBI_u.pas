unit App.Retag.Fin.PagForma.Ed.DBI_u;

interface

uses App.Retag.Fin.PagForma.Ed.DBI, Sis.DBI_u, App.Retag.Fin.PagForma.Ent,
  System.Classes, Sis.DB.DBTypes;

type
  TPagFormaEdDBI = class(TDBI, IPagFormaEdDBI)
  private
    FPagFormaEnt: IPagFormaEnt;
  public
    function DescrsExistentesGet(pResultsSL: TStrings): boolean;
    constructor Create(pPagFormaEnt: IPagFormaEnt;
      pDBConnection: IDBConnection);
  end;

implementation

{ TPagFormaEdDBI }

constructor TPagFormaEdDBI.Create(pPagFormaEnt: IPagFormaEnt;
  pDBConnection: IDBConnection);
begin
  inherited Create(pDBConnection);
  FPagFormaEnt := pPagFormaEnt;
end;

function TPagFormaEdDBI.DescrsExistentesGet(pResultsSL: TStrings): boolean;
begin

end;

end.

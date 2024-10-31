unit Sis.DB.DBConfigDBI;

interface

uses Sis.DBI;

type
  IDBConfigDBI = interface(IDBI)
    ['{72FB7E93-47FF-4E39-9D38-DB2F53103B70}']
    procedure Gravar(pChave, pValor: string); overload;
    procedure Gravar(pChave: string; pValor: Boolean); overload;
  end;

implementation

end.

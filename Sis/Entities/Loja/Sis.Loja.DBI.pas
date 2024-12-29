unit Sis.Loja.DBI;

interface

uses Sis.DBI;

type
  ISisLojaDBI = interface(IDBI)
    ['{A4A5D15F-D4BC-41A9-8269-C16F28C9178F}']
    function Ler(out pMens: string): boolean;
  end;


implementation

end.

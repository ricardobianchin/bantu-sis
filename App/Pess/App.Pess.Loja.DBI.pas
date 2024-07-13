unit App.Pess.Loja.DBI;

interface

uses App.Pess.DBI;

type
  IPessLojaDBI = interface(IPessDBI)
    ['{6855FBFC-BCA3-4030-AF80-1121883DFDC8}']
    function LojaIdExiste(pLojaId: SmallInt; out pApelido: string): boolean;
  end;

implementation

end.

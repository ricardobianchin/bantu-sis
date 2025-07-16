unit App.Est.Promo.DBI;

interface

uses App.Ent.DBI, Sis.Entities.Types, Sis.Types, App.Est.Promo.Ent;

type
  IEstPromoDBI = interface(IEntDBI)
    ['{190A9913-6677-4CCC-B457-2BD07850832B}']
    function NomeJaExistente(pNome: string; pPromoIdExceto: integer = 0): Boolean;
    function InserirItem: Boolean;
    function AlterarPromo: Boolean;
  end;

implementation

end.

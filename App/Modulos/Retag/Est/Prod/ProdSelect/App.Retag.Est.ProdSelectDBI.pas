unit App.Retag.Est.ProdSelectDBI;

interface

uses Sis.DBI, System.Classes, Sis.Types;

type
  IProdSelectDBI = interface(IDBI)
    ['{A6FD5B3E-B8C6-4D35-89CF-D30241E9A220}']
    // procedure ProdPelo(pProdIdExceto: integer; pFabrId: smallint;
    // pDescr, pDescrRed: string; pResultSL: TStringList): boolean;
    procedure PegarProd(pProdId: integer; var pValues: variant;
      out pErroDeu: boolean; out pErroMens: string);
    procedure BusqueProd(pStrBusca: string; out pProdId: TId;
      out pProdDescrRed: string; out pProdBalancaExige: boolean;
      out pProdFabrNome: string; out pCusto: Currency; out pMargem: Currency;
      out pPreco: Currency; out pBarras: string; out pErroDeu: boolean;
      out pMens: string);

  end;

implementation

end.

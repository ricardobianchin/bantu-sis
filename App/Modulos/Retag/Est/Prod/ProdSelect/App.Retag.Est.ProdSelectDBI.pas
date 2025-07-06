unit App.Retag.Est.ProdSelectDBI;

interface

uses Sis.DBI, System.Classes;

type
  IProdSelectDBI = interface(IDBI)
    ['{A6FD5B3E-B8C6-4D35-89CF-D30241E9A220}']
 // procedure ProdPelo(pProdIdExceto: integer; pFabrId: smallint;
//    pDescr, pDescrRed: string; pResultSL: TStringList): boolean;
    procedure PegarProd(pProdId: integer; var pValues: variant; out pErroDeu: boolean; out pErroMens: string);
  
  end;


implementation

end.

unit App.Retag.Est.Prod.Ed.DBI;

interface

uses Sis.DBI, System.Classes;

type
  IRetagEstProdEdDBI = interface(IDBI)
    ['{4028F4A5-EF6D-42E2-8C01-981584E79DB6}']
    procedure PreencherItens(pProdEdForm: TObject);
    function FabrDescrsExistentes(pProdIdExceto: integer; pFabrId: smallint; pDescr, pDescrRed: string; pResultSL: TStringList): boolean;
  end;

implementation

end.

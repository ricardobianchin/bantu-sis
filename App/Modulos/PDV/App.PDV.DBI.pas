unit App.PDV.DBI;

interface

uses Sis.DBI, FireDAC.Comp.Client;

type
  IAppPDVDBI = interface(IDBI)
    ['{DF20E6A5-9D46-40EC-B9E2-4102BC97981F}']
    procedure PagSomenteDinheiro;
    procedure PagamentoFormaPreencheDataSet(pFDMemTable: TFDMemTable);
  end;

implementation

end.

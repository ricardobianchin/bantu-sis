unit App.PDV.DBI;

interface

uses Sis.DBI, FireDAC.Comp.Client, Sis.Types, App.Est.EstMovItem;

type
  IAppPDVDBI = interface(IDBI)
    ['{DF20E6A5-9D46-40EC-B9E2-4102BC97981F}']
    procedure PagSomenteDinheiro;
    procedure PagFormaPreencheDataSet(pFDMemTable: TFDMemTable);
    procedure PagInserir(PAGAMENTO_FORMA_ID: TId; VALOR_DEVIDO, VALOR_ENTREGUE,
      TROCO: Currency);
    procedure PagCancelar(pOrdem: SmallInt);

    procedure EstMovCancele(out pCanceladoEm: TDateTime; out pErroDeu: boolean;
      out pErroMensagem: string);

    procedure EstMovItemCancele(pEstMovItem: IEstMovItem;  out pErroDeu: boolean;
      out pErroMensagem: string);

    procedure VendaFinalize;
  end;

implementation

end.

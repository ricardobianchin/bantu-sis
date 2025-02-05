unit App.PDV.UI.Balanca;

interface

type
  IBalanca = interface(IInterface)
    ['{D9333B1B-BE54-4134-B467-5CE082EBA73D}']
    procedure LePeso(out pPeso: string; out pDeuErro: Boolean; out pMens: string);
  end;

implementation

end.

unit App.Retag.Est.Custo;

interface

type
  ICusto = interface(IInterface)
    ['{FF4C8CC1-124D-4718-A663-3F32DDA315E1}']
    function GetCustoAtual(pProdId: integer): double;
  end;

implementation

end.

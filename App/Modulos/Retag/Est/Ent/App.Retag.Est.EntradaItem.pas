unit App.Retag.Est.EntradaItem;

interface

uses App.Est.EstMovItem;

type
  IRetagEntradaItem = interface(IEstMovItem)
    ['{9345242F-B185-42F5-BAF1-C0F25A244BE2}']

    function GetCusto: Currency;
    procedure SetCusto(Value: Currency);
    property Custo: Currency read GetCusto write SetCusto;
  end;

implementation

end.

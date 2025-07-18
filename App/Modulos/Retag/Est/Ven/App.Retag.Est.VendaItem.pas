unit App.Retag.Est.VendaItem;

interface

uses App.Est.EstMovItem;

type
  IRetagVendaItem = interface(IEstMovItem)
    ['{518CD011-0E4C-4B23-AA9C-A8D55A6327FB}']
    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;

    function GetPreco: Currency;
    procedure SetPreco(Value: Currency);
    property Preco: Currency read GetPreco write SetPreco;
  end;

implementation

end.

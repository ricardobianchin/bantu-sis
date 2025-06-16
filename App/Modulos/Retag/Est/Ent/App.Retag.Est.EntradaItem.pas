unit App.Retag.Est.EntradaItem;

interface

uses App.Est.EstMovItem, App.Types;

type
  IRetagEntradaItem = interface(IEstMovItem)
    ['{9345242F-B185-42F5-BAF1-C0F25A244BE2}']

    function GetProdIdDeles: string;
    procedure SetProdIdDeles(Value: string);
    property ProdIdDeles: string read GetProdIdDeles write SetProdIdDeles;

    function GetNItem: SmallInt;
    procedure SetNItem(Value: SmallInt);
    property NItem: SmallInt read GetNItem write SetNItem;

    function GetCusto: TCusto;
    procedure SetCusto(Value: TCusto);
    property Custo: TCusto read GetCusto write SetCusto;

    function GetMargem: Currency;
    procedure SetMargem(Value: Currency);
    property Margem: Currency read GetMargem write SetMargem;

    function GetPreco: TPreco;
    procedure SetPreco(Value: TPreco);
    property Preco: TPreco read GetPreco write SetPreco;
  end;

implementation

end.

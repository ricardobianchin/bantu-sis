unit App.PDV.VendaItem;

interface

uses App.Est.EstMovItem;

type
  IPDVVendaItem = interface(IEstMovItem)
    ['{A2E2E3F6-98A6-4A7D-935F-8997733192AB}']
    function GetBalancaExige: Boolean;
    procedure SetBalancaExige(Value: Boolean);
    property BalancaExige: Boolean read GetBalancaExige write SetBalancaExige;

    function GetCustoUnit: Currency;
    procedure SetCustoUnit(Value: Currency);
    property CustoUnit: Currency read GetCustoUnit write SetCustoUnit;

    function GetCusto: Currency;
    procedure SetCusto(Value: Currency);
    property Custo: Currency read GetCusto write SetCusto;

    function GetPrecoUnitOriginal: Currency;
    procedure SetPrecoUnitOriginal(Value: Currency);
    property PrecoUnitOriginal: Currency read GetPrecoUnitOriginal write SetPrecoUnitOriginal;

    function GetPrecoUnitPromo: Currency;
    procedure SetPrecoUnitPromo(Value: Currency);
    property PrecoUnitPromo: Currency read GetPrecoUnitPromo write SetPrecoUnitPromo;

    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;

    function GetPrecoBruto: Currency;
    procedure SetPrecoBruto(Value: Currency);
    property PrecoBruto: Currency read GetPrecoBruto write SetPrecoBruto;

    function GetDesconto: Currency;
    procedure SetDesconto(Value: Currency);
    property Desconto: Currency read GetDesconto write SetDesconto;

    function GetPreco: Currency;
    procedure SetPreco(Value: Currency);
    property Preco: Currency read GetPreco write SetPreco;

    function GetQtdVolumes: integer;
    property QtdVolumes: integer read GetQtdVolumes;

    function GetAsStringFita: string;
    property AsStringFita: string read GetAsStringFita;
  end;

implementation

end.

unit App.PDV.Venda;

interface

uses App.Est.Mov, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  App.Est.Venda.Caixa.CaixaSessao, Sis.DB.DBTypes;

type
  IPDVVenda = interface(IEstMov)
    ['{8E776452-E9BC-4D4B-BAAD-47B22DCFB1BE}']
//    FCaixaSessao: ICaixaSessao;

    function GetVendaId: TId;
    property VendaId: TId read GetVendaId;

    function GetCaixaSessao: ICaixaSessao;
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;

    function GetC: string;
    procedure SetC(Value: string);
    property C: string read GetC write SetC;

    function GetCli: TIdLojaTermRecord;
    property Cli: TIdLojaTermRecord read GetCli;

    function GetEnder: TIdLojaTermRecord;
    property Ender: TIdLojaTermRecord read GetEnder;

    function GetCustoTotal: Currency;
    procedure SetCustoTotal(Value: Currency);
    property CustoTotal: Currency read GetCustoTotal write SetCustoTotal;

    function GetDescontoTotal: Currency;
    procedure SetDescontoTotal(Value: Currency);
    property DescontoTotal: Currency read GetDescontoTotal write SetDescontoTotal;

    function GetTotalLiquido: Currency;
    procedure SetTotalLiquido(Value: Currency);
    property TotalLiquido: Currency read GetTotalLiquido write SetTotalLiquido;

    function GetEntregaTem: Boolean;
    procedure SetEntregaTem(Value: Boolean);
    property EntregaTem: Boolean read GetEntregaTem write SetEntregaTem;

    function GetEntregadorId: TId;
    procedure SetEntregadorId(Value: TId);
    property EntregadorId: TId read GetEntregadorId write SetEntregadorId;

    function GetEntregaEm: TDateTime;
    procedure SetEntregaEm(Value: TDateTime);
    property EntregaEm: TDateTime read GetEntregaEm write SetEntregaEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;
  end;

implementation

end.

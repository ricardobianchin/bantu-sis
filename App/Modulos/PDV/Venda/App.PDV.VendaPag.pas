unit App.PDV.VendaPag;

interface

uses Sis.Types;

type
  IVendaPag = interface
    ['{BA1CAF91-7AAE-43ED-83D5-CF4570B13274}']
    function GetOrdem: SmallInt;
    procedure SetOrdem(const Value: SmallInt);

    function GetPagamentoFormaId: TId;
    procedure SetPagamentoFormaId(const Value: TId);

    function GetValorDevido: Currency;
    procedure SetValorDevido(const Value: Currency);

    function GetValorEntregue: Currency;
    procedure SetValorEntregue(const Value: Currency);

    function GetTroco: Currency;
    procedure SetTroco(const Value: Currency);

    function GetCancelado: Boolean;
    procedure SetCancelado(const Value: Boolean);

    property Ordem: SmallInt read GetOrdem write SetOrdem;
    property PagamentoFormaId: TId read GetPagamentoFormaId write SetPagamentoFormaId;
    property ValorDevido: Currency read GetValorDevido write SetValorDevido;
    property ValorEntregue: Currency read GetValorEntregue write SetValorEntregue;
    property Troco: Currency read GetTroco write SetTroco;
    property Cancelado: Boolean read GetCancelado write SetCancelado;
  end;

implementation

end.

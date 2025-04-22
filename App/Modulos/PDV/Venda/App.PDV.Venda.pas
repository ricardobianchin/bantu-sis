unit App.PDV.Venda;

interface

uses App.Est.Mov, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  App.Est.Venda.Caixa.CaixaSessao, Sis.DB.DBTypes, App.PDV.VendaItem, App.PDV.VendaPag.List;

type
  IPDVVenda = interface(IEstMov<IPDVVendaItem>)
    ['{8E776452-E9BC-4D4B-BAAD-47B22DCFB1BE}']

    function GetVendaId: TId;
    procedure SetVendaId(Value: TId);
    property VendaId: TId read GetVendaId Write SetVendaId;

    function GetCod(pSeparador: string = '-'): string;

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

    function GetVendaAlteradoEm: TDateTime;
    procedure SetVendaAlteradoEm(Value: TDateTime);
    property VendaAlteradoEm: TDateTime read GetVendaAlteradoEm write SetVendaAlteradoEm;

    function GetVendaPagList: IVendaPagList;
    property VendaPagList: IVendaPagList read GetVendaPagList;

    function GetItensPrecoTot: Currency;
    function GetFalta: Currency;

    function GetQtdItensAtivos: integer;

    procedure ItensPegarTots( //
      out pTotalLiquido: Currency; //
      out pTotalDevido: Currency; //
      out pTotalEntregue: Currency; //
      out pFalta: Currency; //
      out pTroco: Currency //
      );
  end;

implementation

end.

unit App.Retag.Est.Venda.Ent;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.VendaItem;

type
  IRetagVendaEnt = interface(IEstMovEnt<IRetagVendaItem>)
    ['{F3709C28-0055-40CD-95F9-78AB8A498B79}']

    function GetVendaId: TId;
    procedure SetVendaId(Value: TId);
    property VendaId: TId read GetVendaId write SetVendaId;

    function GetDescontoTotal: Currency;
    procedure SetDescontoTotal(Value: Currency);
    property DescontoTotal: Currency read GetDescontoTotal write SetDescontoTotal;

    function GetTotalLiquido: Currency;
    procedure SetTotalLiquido(Value: Currency);
    property TotalLiquido: Currency read GetTotalLiquido write SetTotalLiquido;

    function GetCod(pSeparador: string = '-'): string;
  end;

implementation

end.

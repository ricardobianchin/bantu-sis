unit App.PDV.VendaPag.List;

interface

uses
  App.PDV.VendaPag, System.Classes, Sis.Types;

type
  IVendaPagList = interface(IInterfaceList)
    ['{2409BDD8-3588-4FBF-9A5F-01D673EC1489}']
    function GetItem(Index: Integer): IVendaPag;
    procedure SetItem(Index: Integer; const Value: IVendaPag);
    function Add(const Item: IVendaPag): Integer;
    property Items[Index: Integer]: IVendaPag read GetItem write SetItem; default;

    function GetTotal: Currency;
    property Total: Currency read GetTotal;

    procedure GetTots(out pDevido, pEntregue, pTroco: Currency);
    function GetProximaOrdem: SmallInt;

    function PagFormaTem(pPagFormaId: TId): Boolean;
  end;

implementation

end.

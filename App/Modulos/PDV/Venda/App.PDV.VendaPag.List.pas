unit App.PDV.VendaPag.List;

interface

uses
  App.PDV.VendaPag, System.Classes;

type
  IVendaPagList = interface(IInterfaceList)
    ['{2409BDD8-3588-4FBF-9A5F-01D673EC1489}']
    function GetItem(Index: Integer): IVendaPag;
    procedure SetItem(Index: Integer; const Value: IVendaPag);
    function Add(const Item: IVendaPag): Integer;
    property Items[Index: Integer]: IVendaPag read GetItem write SetItem; default;
  end;

implementation

end.

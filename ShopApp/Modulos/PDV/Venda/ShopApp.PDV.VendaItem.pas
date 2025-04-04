unit ShopApp.PDV.VendaItem;

interface

uses App.PDV.VendaItem;

type
  IShopPDVVendaItem = interface(IPDVVendaItem)
  ['{7A9499FF-8027-4989-8FD0-10842C8B8392}']
    function GetAsLinha1: string;
    function GetAsLinha2: string;
    function GetAsLinha3: string;

    property AsLinha1: string read GetAsLinha1;
    property AsLinha2: string read GetAsLinha2;
    property AsLinha3: string read GetAsLinha3;
  end;

implementation

end.

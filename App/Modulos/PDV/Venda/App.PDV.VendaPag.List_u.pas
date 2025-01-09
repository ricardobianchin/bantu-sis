unit App.PDV.VendaPag.List_u;

interface

uses
  App.PDV.VendaPag, App.PDV.VendaPag.List, System.Classes;

type
  TVendaPagList = class(TInterfaceList, IVendaPagList)
  protected
    function GetItem(Index: Integer): IVendaPag;
    procedure SetItem(Index: Integer; const Value: IVendaPag);
  public
    function Add(const Item: IVendaPag): Integer;
    property Items[Index: Integer]: IVendaPag read GetItem write SetItem; default;
  end;

implementation

function TVendaPagList.GetItem(Index: Integer): IVendaPag;
begin
  Result := inherited Items[Index] as IVendaPag;
end;

procedure TVendaPagList.SetItem(Index: Integer; const Value: IVendaPag);
begin
  inherited Items[Index] := Value;
end;

function TVendaPagList.Add(const Item: IVendaPag): Integer;
begin
  Result := inherited Add(Item);
end;

end.

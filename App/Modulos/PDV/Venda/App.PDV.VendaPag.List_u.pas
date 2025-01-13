unit App.PDV.VendaPag.List_u;

interface

uses
  App.PDV.VendaPag, App.PDV.VendaPag.List, System.Classes, Sis.Types;

type
  TVendaPagList = class(TInterfaceList, IVendaPagList)
  protected
    function GetItem(Index: Integer): IVendaPag;
    procedure SetItem(Index: Integer; const Value: IVendaPag);

    function GetTotal: Currency;
  public
    function Add(const Item: IVendaPag): Integer;
    property Items[Index: Integer]: IVendaPag read GetItem
      write SetItem; default;
    property Total: Currency read GetTotal;
    procedure GetTots(out pDevido, pEntregue, pTroco: Currency);
    function GetProximaOrdem: SmallInt;
    function PagFormaTem(pPagFormaId: TId): Boolean;
  end;

implementation

function TVendaPagList.GetItem(Index: Integer): IVendaPag;
begin
  Result := inherited Items[Index] as IVendaPag;
end;

function TVendaPagList.GetProximaOrdem: SmallInt;
begin
  Result := Count;
end;

function TVendaPagList.GetTotal: Currency;
var
  oPag: IVendaPag;
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    oPag := Items[i];
    if oPag.Cancelado then
      continue;

    Result := Result + oPag.ValorDevido;
  end;
end;

procedure TVendaPagList.GetTots(out pDevido, pEntregue, pTroco: Currency);
var
  oPag: IVendaPag;
  i: Integer;
begin
  pDevido := 0;
  pTroco := 0;
  pEntregue := 0;

  for i := 0 to Count - 1 do
  begin
    oPag := Items[i];
    if oPag.Cancelado then
      Continue;

    pDevido := pDevido + oPag.ValorDevido;
    pEntregue := pEntregue + oPag.ValorEntregue;
    pTroco := pTroco + oPag.Troco;
  end;
end;

function TVendaPagList.PagFormaTem(pPagFormaId: TId): Boolean;
var
  oPag: IVendaPag;
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
  begin
    oPag := Items[i];

    if oPag.Cancelado then
      continue;

    if oPag.PagamentoFormaId = pPagFormaId then
    begin
      Result := True;
      break;
    end;
  end;
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

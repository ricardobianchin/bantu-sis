unit Sis.Lists.IdCharHashItem_u;

interface

uses Sis.Lists.IdCharItem_u, Sis.Lists.IdCharHashItem;

type
  TIdCharHashItem = class(TIdCharItem, IIdCharHashItem)
  private
    FDescr: string;

    function GetDescr: string;
  protected
    procedure SetDescr(const Value: string);
  public
    property Descr: string read GetDescr write SetDescr;
    constructor Create(pDescr: string = ''; pId: string = '');
  end;

implementation

{ TIdCharHashItem }

constructor TIdCharHashItem.Create(pDescr: string; pId: string);
begin
  inherited Create(pId);
  FDescr := pDescr;
end;

function TIdCharHashItem.GetDescr: string;
begin
  Result := FDescr;
end;

procedure TIdCharHashItem.SetDescr(const Value: string);
begin
  FDescr := Value;
end;

end.

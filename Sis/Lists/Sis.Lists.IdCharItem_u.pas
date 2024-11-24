unit Sis.Lists.IdCharItem_u;

interface

uses Sis.Lists.IdCharItem;

type
  TIdCharItem = class(TInterfacedObject, IIdCharItem)
  private
    FId: Char;

    function GetId: Char;
  protected
    procedure SetId(Value: Char); virtual;
  public
    property Id: Char read GetId write SetId;
    constructor Create(pId: string = '');
    procedure PegarId(pId: string = '');
  end;

implementation

{ TIdCharItem }

constructor TIdCharItem.Create(pId: string);
begin
  PegarId(pId);
end;

function TIdCharItem.GetId: Char;
begin
  Result := FId;
end;

procedure TIdCharItem.PegarId(pId: string);
begin
  if pId = '' then
    FId := #0
  else
    FId := pId[1];
end;

procedure TIdCharItem.SetId(Value: Char);
begin
  FId := Value;
end;

end.

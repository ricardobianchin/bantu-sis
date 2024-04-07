unit Sis.Lists.IdItem_u;

interface

uses Sis.Lists.IdItem;

type
  TIdItem = class(TInterfacedObject, IIdItem)
  private
    FId: integer;
    function GetId: integer;
  protected
    procedure SetId(Value: integer); virtual;
  public
    procedure Zerar; virtual;
    procedure Pegar(pId: integer);

    function IgualA(pId: integer): boolean; overload;
    function IgualA(pIdItem: IIdItem): boolean; overload;

    procedure PegarDe(pIdItem: IIdItem);
    function GetToStrZero(pNCasas: integer = 0): string; virtual;

    property Id: integer read GetId write SetId;

    constructor Create(pId: integer = 0);
  end;

implementation

uses System.SysUtils;

{ TIdItem }

constructor TIdItem.Create(pId: integer);
begin
  FId := pId;
end;

function TIdItem.GetId: integer;
begin
  result := FId;
end;

function TIdItem.GetToStrZero(pNCasas: integer): string;
var
  sMascara, sResultado: string;
begin
  sMascara := '%.' +  pNCasas.ToString + 'd';
  sResultado := Format(sMascara, [FId]);
  Result := sResultado;
{
  result := FId.ToString;
  while Length(result) < pNCasas do
    result := '0' + result;
 }
end;

function TIdItem.IgualA(pIdItem: IIdItem): boolean;
begin
  result := Id = pIdItem.Id;

end;

function TIdItem.IgualA(pId: integer): boolean;
begin
  result := pId = FId;
end;

procedure TIdItem.Pegar(pId: integer);
begin
  SetId(pId);
end;

procedure TIdItem.PegarDe(pIdItem: IIdItem);
begin
  FId := pIdItem.Id;
end;

procedure TIdItem.SetId(Value: integer);
begin
  FId := Value;
end;

procedure TIdItem.Zerar;
begin
  SetId(0);
end;

end.

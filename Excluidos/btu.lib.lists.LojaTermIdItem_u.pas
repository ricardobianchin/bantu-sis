unit btu.lib.lists.LojaTermIdItem_u;

interface

uses btu.lib.lists.IdItem_u, btu.lib.lists.LojaTermIdItem;

type
  TLojaTermIdItem = class(TIdItem, ILojaTermIdItem)
  private
    FLojaId:integer;
    FTerminalId:integer;

    function GetLojaId:integer;
    procedure SetLojaId(Value:integer);

    function GetTerminalId:integer;
    procedure SetTerminalId(Value:integer);
  protected
  public
    procedure Zerar; override;

    function GetToStrZero(pNCasas:integer=0):string; override;

    property LojaId:integer read GetLojaId write SetLojaId;
    property TerminalId:integer read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId, pTerminalId, pId: Integer);
    procedure PegarDe(pLojaTermIdItem:ILojaTermIdItem);

    constructor Create(pLojaId:integer=0; pTerminalId:integer=0; pId:integer=0);
  end;

implementation

uses System.SysUtils, btu.lib.entit.LojaTermId.utils;

{ TLojaTermItem }

constructor TLojaTermIdItem.Create(pLojaId, pTerminalId, pId: integer);
begin
  inherited Create(pId);
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
end;

function TLojaTermIdItem.GetLojaId: integer;
begin
  Result := FLojaId;
end;

function TLojaTermIdItem.GetTerminalId: integer;
begin
  Result := FTerminalId;
end;

function TLojaTermIdItem.GetToStrZero(pNCasas: integer): string;
begin
  Result := CodsToStrZero(pNCasas, FLojaId, FTerminalId, Id);
end;

procedure TLojaTermIdItem.Pegar(pLojaId, pTerminalId, pId: Integer);
begin
  inherited Pegar(pId);
  SetLojaId(pLojaId);
  SetTerminalId(pTerminalId);
end;

procedure TLojaTermIdItem.PegarDe(pLojaTermIdItem: ILojaTermIdItem);
begin
  Pegar(pLojaTermIdItem.LojaId, pLojaTermIdItem.TerminalId, pLojaTermIdItem.Id);
end;

procedure TLojaTermIdItem.SetLojaId(Value: integer);
begin
  FLojaId := Value;
end;

procedure TLojaTermIdItem.SetTerminalId(Value: integer);
begin
  FTerminalId := Value;
end;

procedure TLojaTermIdItem.Zerar;
begin
  inherited Zerar;
  SetLojaId(0);
  SetTerminalId(0);
end;

end.

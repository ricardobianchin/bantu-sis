unit btu.lib.lists.LojaTermItem_u;

interface

uses btu.lib.lists.IdItem_u, btu.lib.lists.LojaTermItem;

type
  TLojaTermItem = class(TIdItem, ILojaTermItem)
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

    class function CodsToStrZero(pQtdCasasId: integer; pLojaId, pTerminalId, pId: Integer):string;
    function GetToStrZero(pNCasas:integer=0):string; override;

    property LojaId:integer read GetLojaId write SetLojaId;
    property TerminalId:integer read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId, pTerminalId, pId: Integer);
    procedure PegarDe(pLojaTermItem:ILojaTermItem);

    constructor Create(pQtdCasasId: integer = 7; pLojaId:integer=0; pTerminalId:integer=0; pId:integer=0);
  end;

implementation

uses System.SysUtils;

{ TLojaTermItem }

class function TLojaTermItem.CodsToStrZero(pQtdCasasId: integer;
  pLojaId, pTerminalId, pId: integer): string;
var
  Resultado: string;
  FormatString: string;
begin
  FormatString := '%d-%d-%.';

  if pQtdCasasId>0 then
    FormatString := FormatString + pQtdCasasId.ToString;

  FormatString := FormatString + 'd';

  Resultado := Format(FormatString, [FLojaId, FTerminalId, FId]);
  Result := Resultado;
end;

constructor TLojaTermItem.Create(pLojaId, pTerminalId, pId: integer);
begin
  inherited Create(pId);
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
end;

function TLojaTermItem.GetLojaId: integer;
begin
  Result := FLojaId;
end;

function TLojaTermItem.GetTerminalId: integer;
begin
  Result := FTerminalId;
end;

function TLojaTermItem.GetToStrZero(pNCasas: integer): string;
begin
  Result := CodsToStrZero(pNCasas, FLojaId, FTerminalId, FId);
end;

procedure TLojaTermItem.Pegar(pLojaId, pTerminalId, pId: Integer);
begin
  inherited Pegar(pId);
  SetLojaId(pLojaId);
  SetTerminalId(pTerminalId);
end;

procedure TLojaTermItem.PegarDe(pLojaTermItem: ILojaTermItem);
begin
  Pegar(pLojaTermItem.LojaId, pLojaTermItem.TerminalId, pLojaTermItem.Id);
end;

procedure TLojaTermItem.SetLojaId(Value: integer);
begin
  FLojaId := Value;
end;

procedure TLojaTermItem.SetTerminalId(Value: integer);
begin
  FTerminalId := Value;
end;

procedure TLojaTermItem.Zerar;
begin
  inherited Zerar;
  SetLojaId(0);
  SetTerminalId(0);
end;

end.

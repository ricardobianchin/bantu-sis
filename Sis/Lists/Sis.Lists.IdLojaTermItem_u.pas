unit Sis.Lists.IdLojaTermItem_u;

interface

uses Sis.Lists.IdItem_u, Sis.Lists.IdLojaTermItem;

type
  TIdLojaTermItem = class(TIdItem, IIdLojaTermItem)
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

    function GetCodsToStrZero(pLojaNCasas: integer = 0; pTermNCasas: integer = 0; pIdNCasas: integer = 7): string;

    property LojaId:integer read GetLojaId write SetLojaId;
    property TerminalId:integer read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId, pTerminalId, pId: Integer);
    procedure PegarDe(pIdLojaTermItem:IIdLojaTermItem);


    constructor Create(pLojaId:integer=0; pTerminalId:integer=0; pId:integer=0);
  end;

implementation

uses System.SysUtils;

{ TLojaTermItem }

constructor TIdLojaTermItem.Create(pLojaId, pTerminalId, pId: integer);
begin
  inherited Create(pId);
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
end;

function TIdLojaTermItem.GetCodsToStrZero(pLojaNCasas, pTermNCasas,
  pIdNCasas: integer): string;
var
  sMascara, sResultado: string;
begin
// exemplo '%d-%.2d-%.7d'
  sMascara :=
    '%.' +  pLojaNCasas.ToString + 'd' +
    '-%.' +  pTermNCasas.ToString + 'd' +
    '-%.' +  pIdNCasas.ToString + 'd'
    ;
  sResultado := Format(sMascara, [FLojaId, FTerminalId, Id]);
  Result := sResultado;
end;

function TIdLojaTermItem.GetLojaId: integer;
begin
  Result := FLojaId;
end;

function TIdLojaTermItem.GetTerminalId: integer;
begin
  Result := FTerminalId;
end;

procedure TIdLojaTermItem.Pegar(pLojaId, pTerminalId, pId: Integer);
begin
  inherited Pegar(pId);
  SetLojaId(pLojaId);
  SetTerminalId(pTerminalId);
end;

procedure TIdLojaTermItem.PegarDe(pIdLojaTermItem: IIdLojaTermItem);
begin
  Pegar(pIdLojaTermItem.LojaId, pIdLojaTermItem.TerminalId, pIdLojaTermItem.Id);
end;

procedure TIdLojaTermItem.SetLojaId(Value: integer);
begin
  FLojaId := Value;
end;

procedure TIdLojaTermItem.SetTerminalId(Value: integer);
begin
  FTerminalId := Value;
end;

procedure TIdLojaTermItem.Zerar;
begin
  inherited Zerar;
  SetLojaId(0);
  SetTerminalId(0);
end;

end.

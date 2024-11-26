unit Sis.Lists.IdLojaTermItem_u;

interface

uses Sis.Lists.IdItem_u, Sis.Lists.IdLojaTermItem, Sis.Entities.Types;

type
  TIdLojaTermItem = class(TIdItem, IIdLojaTermItem)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
  protected
  public
    procedure Zerar; override;

    function GetCodsToStrZero(pLojaNCasas: integer = 0;
      pTermNCasas: integer = 0; pIdNCasas: integer = 7): string;

    property LojaId: TLojaId read GetLojaId write SetLojaId;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer);
    procedure PegarDe(pIdLojaTermItem: IIdLojaTermItem);

    constructor Create(pLojaId: TLojaId = 0; pTerminalId: TTerminalId = 0;
      pId: integer = 0);
  end;

implementation

uses System.SysUtils;

{ TLojaTermItem }

constructor TIdLojaTermItem.Create(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pId: integer);
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
  sMascara := '%.' + pLojaNCasas.ToString + 'd' + '-%.' + pTermNCasas.ToString +
    'd' + '-%.' + pIdNCasas.ToString + 'd';
  sResultado := Format(sMascara, [FLojaId, FTerminalId, Id]);
  Result := sResultado;
end;

function TIdLojaTermItem.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TIdLojaTermItem.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TIdLojaTermItem.Pegar(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer);
begin
  inherited Pegar(pId);
  SetLojaId(pLojaId);
  SetTerminalId(pTerminalId);
end;

procedure TIdLojaTermItem.PegarDe(pIdLojaTermItem: IIdLojaTermItem);
begin
  Pegar(pIdLojaTermItem.LojaId, pIdLojaTermItem.TerminalId, pIdLojaTermItem.Id);
end;

procedure TIdLojaTermItem.SetLojaId(Value: TLojaId);
begin
  FLojaId := Value;
end;

procedure TIdLojaTermItem.SetTerminalId(Value: TTerminalId);
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

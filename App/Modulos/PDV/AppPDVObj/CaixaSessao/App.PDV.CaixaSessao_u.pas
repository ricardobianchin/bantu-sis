unit App.PDV.CaixaSessao_u;

interface

uses Sis.Entities.Types, App.PDV.CaixaSessao;

type
  TCaixaSessao = class(TInterfacedObject, ICaixaSessao)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FId: integer;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetId: integer;
    procedure SetId(Value: integer);
  public
    property LojaId: TLojaId read GetLojaId write SetLojaId;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
    property Id: integer read GetId write SetId;
    constructor Create(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer);
  end;

implementation

{ TCaixaSessao }

constructor TCaixaSessao.Create(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer);
begin
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FId := pId;
end;

function TCaixaSessao.GetId: integer;
begin
  Result := FId;
end;

function TCaixaSessao.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TCaixaSessao.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TCaixaSessao.SetId(Value: integer);
begin
  FId := Value;
end;

procedure TCaixaSessao.SetLojaId(Value: TLojaId);
begin
  FLojaId := Value;
end;

procedure TCaixaSessao.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

end.

unit App.Est.Venda.Caixa.CaixaSessao_u;

interface

uses Sis.Entities.Types, App.Est.Venda.Caixa.CaixaSessao;

type
  TCaixaSessao = class(TInterfacedObject, ICaixaSessao)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FSessId: integer;
    FLogId: integer;
    FAberto: Boolean;
    FConferido: Boolean;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetSessId: integer;
    procedure SetSesslId(Value: integer);

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);

    function GetAberto: Boolean;
    procedure SetAberto(Value: Boolean);

    function GetConferido: Boolean;
    procedure SetConferido(Value: Boolean);
    procedure SetSessId(const Value: integer);
  public
    procedure Zerar; override;

    property LojaId: TLojaId read GetLojaId write SetLojaId;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
    property SesslId: integer read GetSessId write SetSessId;
    property LogId: Int64 read GetLogId write SetLogId;
    property Aberto: Boolean read GetAberto write SetAberto;
    property Conferido: Boolean read GetConferido write SetConferido;

    constructor Create(pLojaId:integer=0; pTerminalId:integer=0; pId:integer=0);
  end;

implementation

{ TCaixaSessao }

constructor TCaixaSessao.Create(pLojaId, pTerminalId, pId: integer);
begin
  inherited Zerar;

end;

function TCaixaSessao.GetAberto: Boolean;
begin
  Result := FAberto;
end;

function TCaixaSessao.GetConferido: Boolean;
begin
  Result := FConferido;
end;

function TCaixaSessao.GetLogId: Int64;
begin
  Result := FLogId;
end;

function TCaixaSessao.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TCaixaSessao.GetSessId: integer;
begin
  Result := FSessId;
end;

function TCaixaSessao.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TCaixaSessao.SetAberto(Value: Boolean);
begin
  FAberto := Value;
end;

procedure TCaixaSessao.SetConferido(Value: Boolean);
begin
  FConferido := Value;
end;

procedure TCaixaSessao.SetLogId(Value: Int64);
begin
  FLogId := Value;
end;

procedure TCaixaSessao.SetLojaId(Value: TLojaId);
begin
  FLojaId := Value;
end;

procedure TCaixaSessao.SetSessId(const Value: integer);
begin
  FSessId := Value;
end;

procedure TCaixaSessao.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

procedure TCaixaSessao.Zerar;
begin
  inherited;
  FLojaId := 0;
  FTerminalId := 0;
  FSessId := 0;
  FLogId := 0;
  FAberto := False;
  FConferido := False;
end;

end.

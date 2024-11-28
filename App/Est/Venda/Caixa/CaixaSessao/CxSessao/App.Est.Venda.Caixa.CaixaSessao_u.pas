unit App.Est.Venda.Caixa.CaixaSessao_u;

interface

uses Sis.Lists.IdLojaTermItem_u, App.Est.Venda.Caixa.CaixaSessao, Sis.Usuario,
  Sis.Entities.Types;

type
  /// <summary>
  /// Zerar nao faz o intuitivo que é zerar tudo
  /// nao chama o inherited que zeraria os trer primeiros valores
  /// aí zera somente o id
  /// pois lojaid e terminalid devem fica intocaveis durante a vida do
  /// </summary>
  TCaixaSessao = class(TIdLojaTermItem, ICaixaSessao)
  private
    FLogUsuario: IUsuario;
    FLogId: integer;
    FAberto: Boolean;
    FConferido: Boolean;
    FMachineIdentId: SmallInt;

    function GetLogUsuario: IUsuario;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);

    function GetAberto: Boolean;
    procedure SetAberto(Value: Boolean);

    function GetConferido: Boolean;
    procedure SetConferido(Value: Boolean);

    function GetMachineIdentId: SmallInt;

    /// <summary>Criado pois Zerar foi alterado e nao apaga lojaId e TerminalId</summary>
    procedure Inicialize;
  public
    procedure Zerar; override;

    property LogUsuario: IUsuario read GetLogUsuario;
    property LogId: Int64 read GetLogId write SetLogId;
    property Aberto: Boolean read GetAberto write SetAberto;
    property Conferido: Boolean read GetConferido write SetConferido;
    property MachineIdentId: SmallInt read GetMachineIdentId;

    constructor Create(pLogUsuario: IUsuario; pMachineIdentId: SmallInt; pLojaId: TLojaId = 0;
      pTerminalId: TTerminalId = 0; pId: integer = 0);
  end;

implementation

{ TCaixaSessao }

constructor TCaixaSessao.Create(pLogUsuario: IUsuario; pMachineIdentId: SmallInt; pLojaId: TLojaId;
  pTerminalId: TTerminalId; pId: integer);
begin
  inherited Create(pLojaId, pTerminalId, pId);
  FLogUsuario := pLogUsuario;
  FMachineIdentId := pMachineIdentId;
  Inicialize;
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

function TCaixaSessao.GetLogUsuario: IUsuario;
begin
  Result := FLogUsuario;
end;

function TCaixaSessao.GetMachineIdentId: SmallInt;
begin
  Result := FMachineIdentId;
end;

procedure TCaixaSessao.Inicialize;
begin
  LojaId := 0;
  TerminalId := 0;
  Zerar;
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

procedure TCaixaSessao.Zerar;
begin
  // inherited;
  Id := 0;
  FLogId := 0;
  FAberto := False;
  FConferido := False;
end;

end.

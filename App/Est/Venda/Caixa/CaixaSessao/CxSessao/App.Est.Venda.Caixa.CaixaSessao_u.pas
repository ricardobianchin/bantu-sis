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
    FAberto: Boolean;
    FConferido: Boolean;
    FMachineIdentId: SmallInt;
    FAbertoEm: TDateTime;

    function GetLogUsuario: IUsuario;

    function GetAberto: Boolean;
    procedure SetAberto(Value: Boolean);

    function GetConferido: Boolean;
    procedure SetConferido(Value: Boolean);

    function GetMachineIdentId: SmallInt;

    function GetAbertoEm: TDateTime;
    procedure SetAbertoEm(Value : TDateTime);

    /// <summary>Criado pois Zerar foi alterado e nao apaga lojaId e TerminalId</summary>
  public
    procedure Zerar; override;

    property LogUsuario: IUsuario read GetLogUsuario;
    property Aberto: Boolean read GetAberto write SetAberto;
    property AbertoEm: TDateTime read GetAbertoEm write SetAbertoEm;
    property Conferido: Boolean read GetConferido write SetConferido;
    property MachineIdentId: SmallInt read GetMachineIdentId;

    function GetCod(pSeparador: string = '-'): string;

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
  Zerar;
end;

function TCaixaSessao.GetAberto: Boolean;
begin
  Result := FAberto;
end;

function TCaixaSessao.GetAbertoEm: TDateTime;
begin
  Result := FAbertoEm;
end;

function TCaixaSessao.GetConferido: Boolean;
begin
  Result := FConferido;
end;

function TCaixaSessao.GetLogUsuario: IUsuario;
begin
  Result := FLogUsuario;
end;

function TCaixaSessao.GetMachineIdentId: SmallInt;
begin
  Result := FMachineIdentId;
end;

function TCaixaSessao.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(LojaId, TerminalId, Id, 'CX',
    pSeparador);
end;

procedure TCaixaSessao.SetAberto(Value: Boolean);
begin
  FAberto := Value;
end;

procedure TCaixaSessao.SetAbertoEm(Value: TDateTime);
begin
  FAbertoEm := Value;
end;

procedure TCaixaSessao.SetConferido(Value: Boolean);
begin
  FConferido := Value;
end;

procedure TCaixaSessao.Zerar;
begin
  // inherited;
  Id := 0;
  FAberto := False;
  FConferido := False;
  FAbertoEm := 0;
end;

end.

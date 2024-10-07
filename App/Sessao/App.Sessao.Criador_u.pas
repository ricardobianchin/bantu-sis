unit App.Sessao.Criador_u;

interface

uses App.Sessao.Criador, App.Sessao, Sis.ModuloSistema.Types, Sis.Entities.Types;

type
  TSessaoCriador = class(TInterfacedObject, ISessaoCriador)
  private
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;

    FTerminalId: TTerminalId;
    FTitulo: string;
    FApelido: string;
    FNFSerie: smallint;
    FSempreOffline: boolean;

    function GetCaption: string;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetTitulo: string;
    procedure SetTitulo(Value: string);

    function GetApelido: string;
    procedure SetApelido(Value: string);

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);

    function GetSempreOffline: boolean;
    procedure SetSempreOffline(Value: boolean);
  protected
    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    procedure SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
  public
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo
      write SetTipoOpcaoSisModulo;
    function SessaoCreate: ISessao; virtual; abstract;

    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
    property Titulo: string read GetTitulo write SetTitulo;
    property Apelido: string read GetApelido write SetApelido;
    property NFSerie: smallint read GetNFSerie write SetNFSerie;
    property SempreOffline: boolean read GetSempreOffline write SetSempreOffline;
  end;

implementation

{ TSessaoCriador }

function TSessaoCriador.GetApelido: string;
begin
  Result := FApelido;
end;

function TSessaoCriador.GetCaption: string;
begin
  Result := TipoOpcaoSisModuloToStr(FTipoOpcaoSisModulo);
end;

function TSessaoCriador.GetNFSerie: smallint;
begin
  Result := FNFSerie;
end;

function TSessaoCriador.GetSempreOffline: boolean;
begin
  Result := FSempreOffline;
end;

function TSessaoCriador.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

function TSessaoCriador.GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
begin
  Result := FTipoOpcaoSisModulo;
end;

function TSessaoCriador.GetTitulo: string;
begin
  Result := FTitulo;
end;

procedure TSessaoCriador.SetApelido(Value: string);
begin
  FApelido := Value;
end;

procedure TSessaoCriador.SetNFSerie(Value: smallint);
begin
  FNFSerie := Value;
end;

procedure TSessaoCriador.SetSempreOffline(Value: boolean);
begin
  FSempreOffline := Value;
end;

procedure TSessaoCriador.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

procedure TSessaoCriador.SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
begin
  FTipoOpcaoSisModulo := Value;
end;

procedure TSessaoCriador.SetTitulo(Value: string);
begin
  FTitulo := Value;
end;

end.

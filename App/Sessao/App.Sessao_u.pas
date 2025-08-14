unit App.Sessao_u;

interface

uses App.Sessao, App.UI.Form.Bas.Modulo_u, Sis.Usuario, App.Constants,
  Sis.ModuloSistema.Types, Sis.Entities.Types;

type
  TSessao = class(TInterfacedObject, ISessao)
  private
    FModuloBasForm: TModuloBasForm;
    FUsuario: IUsuario;
    FIndex: TSessaoIndex;
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    FTerminalId: TTerminalId;

    function GetModuloBasForm: TModuloBasForm;
    function GetUsuario: IUsuario;
    function GetIndex: TSessaoIndex;
    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    function GetTerminalId: TTerminalId;
  public
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo;
    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;
    property Usuario: IUsuario read GetUsuario;
    property Index: TSessaoIndex read GetIndex;
    procedure EscondaModuloForm;

    property TerminalId: TTerminalId read GetTerminalId;

    constructor Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
      pUsuario: IUsuario; pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
      pTerminalId: TTerminalId);
  end;

implementation

{ TSessao }

constructor TSessao.Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pUsuario: IUsuario; pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pTerminalId: TTerminalId);
begin
  FModuloBasForm := pModuloBasForm;
  FTipoOpcaoSisModulo := pTipoOpcaoSisModulo;
  FUsuario := pUsuario;
  FIndex := pIndex;
  FTerminalId := pTerminalId;
end;

procedure TSessao.EscondaModuloForm;
begin
  if not ModuloBasForm.Visible then
    exit;

  ModuloBasForm.Hide;
end;

function TSessao.GetIndex: TSessaoIndex;
begin
  Result := FIndex;
end;

function TSessao.GetModuloBasForm: TModuloBasForm;
begin
  Result := FModuloBasForm;
end;

function TSessao.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

function TSessao.GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
begin
  Result := FTipoOpcaoSisModulo;
end;

function TSessao.GetUsuario: IUsuario;
begin
  Result := FUsuario;
end;

end.

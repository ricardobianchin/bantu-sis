unit App.Pess.Funcionario.Ent_u;

interface

uses App.Pess.Funcionario.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessFuncionarioEnt = class(TPessEnt, IPessFuncionarioEnt)
  private
    FNomeDeUsuario: string;
    FSenha: string;
    FCryVer: smallint;
    FUsuarioAtivo: boolean;

    function GetNomeDeUsuario: string;
    procedure SetNomeDeUsuario(const Value: string);

    function GetSenha: string;
    procedure SetSenha(const Value: string);

    function GetCryVer: smallint;
    procedure SetCryVer(const Value: smallint);

    function GetUsuarioAtivo: boolean;
    procedure SetUsuarioAtivo(Value: boolean);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetPessTipoAceito: TPessTipoAceito; override;
  public
    property NomeDeUsuario: string read GetNomeDeUsuario write SetNomeDeUsuario;
    property Senha: string read GetSenha write SetSenha;
    property CryVer: smallint read GetCryVer write SetCryVer;
    property UsuarioAtivo: boolean read GetUsuarioAtivo write SetUsuarioAtivo;

    procedure LimparEnt; override;
  end;

implementation

uses Data.DB;

{ TPessFuncionarioEnt }

function TPessFuncionarioEnt.GetCryVer: smallint;
begin
  Result := FCryVer;
end;

function TPessFuncionarioEnt.GetNomeDeUsuario: string;
begin
  Result := FNomeDeUsuario;
end;

function TPessFuncionarioEnt.GetNomeEnt: string;
begin
  Result := 'Funcion�rio';
end;

function TPessFuncionarioEnt.GetNomeEntAbrev: string;
begin
  Result := 'Func';
end;

function TPessFuncionarioEnt.GetPessTipoAceito: TPessTipoAceito;
begin
  Result := TPessTipoAceito.pestipacSoPessFisica;
end;

function TPessFuncionarioEnt.GetSenha: string;
begin
  Result := FSenha;
end;

function TPessFuncionarioEnt.GetTitulo: string;
begin
  Result := 'Funcion�rios';
end;

function TPessFuncionarioEnt.GetUsuarioAtivo: boolean;
begin
  Result := FUsuarioAtivo;
end;

procedure TPessFuncionarioEnt.LimparEnt;
begin
  inherited;
  FNomeDeUsuario := '';
  FSenha := '';
  FCryVer := 1;
  FUsuarioAtivo := True;
end;

procedure TPessFuncionarioEnt.SetCryVer(const Value: smallint);
begin
  FCryVer := Value;
end;

procedure TPessFuncionarioEnt.SetNomeDeUsuario(const Value: string);
begin
  FNomeDeUsuario := Value;
end;

procedure TPessFuncionarioEnt.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

procedure TPessFuncionarioEnt.SetUsuarioAtivo(Value: boolean);
begin
  FUsuarioAtivo := Value;
end;

end.

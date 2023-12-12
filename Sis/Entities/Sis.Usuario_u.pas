unit Sis.Usuario_u;

interface

uses Sis.Lists.IdLojaTermItem_u, Sis.Usuario;

type
  TUsuario = class(TIdLojaTermItem, IUsuario)
  private
    FNomeCompleto: string;
    FNomeExib: string;
    FNomeUsu: string;
    FSenha: string;

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);

    function GetNomeUsu: string;
    procedure SetNomeUsu(const Value: string);

    function GetSenha: string;
    procedure SetSenha(const Value: string);

    function GetNomeCompleto: string;
    procedure SetNomeCompleto(const Value: string);
  public
    property NomeCompleto: string read GetNomeCompleto write SetNomeCompleto;
    property NomeExib: string read GetNomeExib write SetNomeExib;
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;
    property Senha: string read GetSenha write SetSenha;

    constructor Create(pLojaId: integer = 0; pTerminalId: integer = 0;
      pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = '';
      pNomeUsu: string = ''; pSenha: string = ''
      );
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(pLojaId: integer; pTerminalId: integer;
      pId: integer; pNomeCompleto: string; pNomeExib: string; pNomeUsu: string;
      pSenha: string);
begin
  inherited Create(pLojaId, pTerminalId, pId);
  SetNomeCompleto(pNomeCompleto);
  SetNomeExib(pNomeExib);
  SetNomeUsu(pNomeUsu);
  SetSenha(pSenha);
end;

function TUsuario.GetNomeCompleto: string;
begin
  Result := FNomeCompleto;
end;

function TUsuario.GetNomeExib: string;
begin
  Result := FNomeExib;
end;

function TUsuario.GetNomeUsu: string;
begin
  Result := FNomeUsu;
end;

function TUsuario.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TUsuario.SetNomeCompleto(const Value: string);
begin
  FNomeCompleto := Value;
end;

procedure TUsuario.SetNomeExib(const Value: string);
begin
  FNomeExib := value;
end;

procedure TUsuario.SetNomeUsu(const Value: string);
begin
  FNomeUsu := value;
end;

procedure TUsuario.SetSenha(const Value: string);
begin
  FSenha := value;
end;

end.

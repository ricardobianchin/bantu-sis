unit Sis.Usuario_u;

interface

uses Sis.Lists.IdLojaTermItem_u, Sis.Usuario;

type
  TUsuario = class(TIdLojaTermItem, IUsuario)
  private
    FNomeCompleto: string;
    FNomeExib: string;
    FNomeDeUsuario: string;
    FSenha: string;
    FCryVer: smallint;

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);

    function GetNomeDeUsuario: string;
    procedure SetNomeDeUsuario(const Value: string);

    function GetSenha: string;
    procedure SetSenha(const Value: string);

    function GetNomeCompleto: string;
    procedure SetNomeCompleto(const Value: string);

    function GetCryVer: smallint;
    procedure SetCryVer(const Value: smallint);

  public
    property NomeCompleto: string read GetNomeCompleto write SetNomeCompleto;
    property NomeExib: string read GetNomeExib write SetNomeExib;
    property NomeDeUsuario: string read GetNomeDeUsuario write SetNomeDeUsuario;
    property Senha: string read GetSenha write SetSenha;
    property CryVer: smallint read GetCryVer write SetCryVer;

    constructor Create(pLojaId: integer = 0; pTerminalId: integer = 0;
      pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = ''
      ; pNomeUsu: string = ''; pSenha: string = ''
      );
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(pLojaId: integer; pTerminalId: integer;
      pId: integer; pNomeCompleto: string; pNomeExib: string
      ; pNomeUsu: string; pSenha: string
      );
begin
  inherited Create(pLojaId, pTerminalId, pId);
  SetNomeCompleto(pNomeCompleto);
  SetNomeExib(pNomeExib);
  SetNomeDeUsuario(pNomeUsu);
  SetSenha(pSenha);
  SetCryVer(1);
end;

function TUsuario.GetCryVer: smallint;
begin
  Result := FCryVer;
end;

function TUsuario.GetNomeCompleto: string;
begin
  Result := FNomeCompleto;
end;

function TUsuario.GetNomeExib: string;
begin
  Result := FNomeExib;
end;

function TUsuario.GetNomeDeUsuario: string;
begin
  Result := FNomeDeUsuario;
end;

function TUsuario.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TUsuario.SetCryVer(const Value: smallint);
begin
  FCryVer := Value;
end;

procedure TUsuario.SetNomeCompleto(const Value: string);
begin
  FNomeCompleto := Value;
end;

procedure TUsuario.SetNomeExib(const Value: string);
begin
  FNomeExib := value;
end;

procedure TUsuario.SetNomeDeUsuario(const Value: string);
begin
  FNomeDeUsuario := value;
end;

procedure TUsuario.SetSenha(const Value: string);
begin
  FSenha := value;
end;

end.

unit btu.lib.usu.Usuario_u;

interface

uses btu.lib.usu.Usuario, btu.lib.lists.LojaTermIdItem_u;

type
  TUsuario = class(TLojaTermIdItem, IUsuario)
  private
    FNomeExib: string;
    FNomeUsu: string;
    FSenha: string;

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);

    function GetNomeUsu: string;
    procedure SetNomeUsu(const Value: string);

    function GetSenha: string;
    procedure SetSenha(const Value: string);

  public
    property NomeExib: string read GetNomeExib write SetNomeExib;
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;
    property Senha: string read GetSenha write SetSenha;

    constructor Create(pLojaId: integer = 0; pTerminalId: integer = 0;
      pId: integer = 0; pNomeExib: string = ''; pNomeUsu: string = '';
      pSenha: string = ''
      );
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(pLojaId: integer; pTerminalId: integer;
      pId: integer; pNomeExib: string; pNomeUsu: string;
      pSenha: string);
begin
  inherited Create(pLojaId, pTerminalId, pId);
  SetNomeExib(pNomeExib);
  SetNomeUsu(pNomeUsu);
  SetSenha(pSenha);
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

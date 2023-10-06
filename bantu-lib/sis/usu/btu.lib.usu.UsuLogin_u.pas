unit btu.lib.usu.UsuLogin_u;

interface

uses btu.lib.usu.UsuLogin;

type
  TUsuLogin = class(TInterfacedObject, IUsuLogin)
  private
    FId: LongInt;
    FNomeExib: string;
    FNomeUsu: string;
    FSenha: string;

    function GetId: LongInt;
    procedure SetId(const Value: LongInt);

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);

    function GetNomeUsu: string;
    procedure SetNomeUsu(const Value: string);

    function GetSenha: string;
    procedure SetSenha(const Value: string);

  public
    property Id: LongInt read GetId write SetId;
    property NomeExib: string read GetNomeExib write SetNomeExib;
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;
    property Senha: string read GetSenha write SetSenha;

    constructor Create;
  end;

implementation

{ TUsuLogin }

constructor TUsuLogin.Create;
begin
  FId := 0;
  FNomeExib := '';
  FNomeUsu := '';
  FSenha := '';

end;

function TUsuLogin.GetId: LongInt;
begin
  Result := FId;
end;

function TUsuLogin.GetNomeExib: string;
begin
  Result := FNomeExib;
end;

function TUsuLogin.GetNomeUsu: string;
begin
  Result := FNomeUsu;
end;

function TUsuLogin.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TUsuLogin.SetId(const Value: LongInt);
begin
  FId := value;
end;

procedure TUsuLogin.SetNomeExib(const Value: string);
begin
  FNomeExib := value;
end;

procedure TUsuLogin.SetNomeUsu(const Value: string);
begin
  FNomeUsu := value;
end;

procedure TUsuLogin.SetSenha(const Value: string);
begin
  FSenha := value;
end;

end.

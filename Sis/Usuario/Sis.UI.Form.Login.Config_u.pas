unit Sis.UI.Form.Login.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Config_u,
  Sis.UI.Form.Login.Config, Sis.ModuloSistema.Types, Xml.XMLDoc, Xml.XMLIntf;

type
  TLoginConfig = class(TConfig, ILoginConfig)
  private
    FPreencheLogin: boolean;
    FTipoModuloSistema: TTipoModuloSistema;
    FNomeUsu: string;
    FSenha: string;

    PreencheLoginNode, TipoModuloSistemaNode, NomeUsuNode, SenhaNode: IXMLNODE;

    function GetPreencheLogin: boolean;
    procedure SetPreencheLogin(Value: boolean);

    function GetTipoModuloSistema: TTipoModuloSistema;
    procedure SetTipoModuloSistema(Value: TTipoModuloSistema);

    function GetNomeUsu: string;
    procedure SetNomeUsu(Value: string);

    function GetSenha: string;
    procedure SetSenha(Value: string);

  protected
    function Ler: boolean; override;
    procedure Gravar; override;
    procedure Inicialize; override;
    function GetNomeArq: string; override;

  public
    property PreencheLogin: boolean read GetPreencheLogin
      write SetPreencheLogin;
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema
      write SetTipoModuloSistema;
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;
    property Senha: string read GetSenha write SetSenha;
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u;

{ TLoginConfig }

function TLoginConfig.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

function TLoginConfig.GetNomeArq: string;
begin
  Result := 'Login.Config.xml';
end;

function TLoginConfig.GetNomeUsu: string;
begin
  Result := FNomeUsu;
end;

function TLoginConfig.GetPreencheLogin: boolean;
begin
  Result := FPreencheLogin;
end;

function TLoginConfig.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TLoginConfig.Gravar;
begin
  inherited;
  RootNode := XMLDocument1.AddChild('login');

  PreencheLoginNode := RootNode.AddChild('preenche_login');
  TipoModuloSistemaNode := RootNode.AddChild('modulo_sistema');
  NomeUsuNode := RootNode.AddChild('nome_usu');
  SenhaNode := RootNode.AddChild('senha');

  PreencheLoginNode.Text := BooleanToStr(FPreencheLogin);
  TipoModuloSistemaNode.Text := TipoModuloSistemaToNameStr(FTipoModuloSistema);
  NomeUsuNode.Text := FNomeUsu;
  SenhaNode.Text := FSenha;

  XMLDocumentSalvar;
end;

procedure TLoginConfig.Inicialize;
begin
  inherited;
  FPreencheLogin := False;
  FTipoModuloSistema := modsisNaoIndicado;
  FNomeUsu := '';
  FSenha := '';
end;

function TLoginConfig.Ler: boolean;
var
  s: string;
begin
  Result := inherited Ler;
  if not Result then
    exit;

  PreencheLoginNode := RootNode.ChildNodes['preenche_login'];
  TipoModuloSistemaNode := RootNode.ChildNodes['modulo_sistema'];
  NomeUsuNode := RootNode.ChildNodes['nome_usu'];
  SenhaNode := RootNode.ChildNodes['senha'];

  s := PreencheLoginNode.Text;
  FPreencheLogin := StrToBoolean(s);

  s := TipoModuloSistemaNode.Text;
  FTipoModuloSistema := NameStrToTipoModuloSistema(s);

  s := NomeUsuNode.Text;
  FNomeUsu := s;

  s := SenhaNode.Text;
  FSenha := s;
end;

procedure TLoginConfig.SetTipoModuloSistema(Value: TTipoModuloSistema);
begin
  FTipoModuloSistema := Value;
end;

procedure TLoginConfig.SetNomeUsu(Value: string);
begin
  FNomeUsu := Value;
end;

procedure TLoginConfig.SetPreencheLogin(Value: boolean);
begin
  FPreencheLogin := Value;
end;

procedure TLoginConfig.SetSenha(Value: string);
begin
  FSenha := Value;
end;

end.

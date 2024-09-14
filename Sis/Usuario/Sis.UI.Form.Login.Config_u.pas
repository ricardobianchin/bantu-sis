unit Sis.UI.Form.Login.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf,
  Sis.UI.Form.Login.Config, Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI_u;

type
  TLoginConfig = class(TConfigXMLI, ILoginConfig)
  private
    FPreencheLogin: boolean;
    FTipoModuloSistema: TTipoModuloSistema;
    FNomeDeUsuario: string;
    FSenhaAtual: string;
    FExecuteOk: boolean;

    PreencheLoginNode, TipoModuloSistemaNode, NomeDeUsuarioNode, SenhaAtualNode,
      ExecuteOkNode: IXMLNODE;

    function GetPreencheLogin: boolean;
    procedure SetPreencheLogin(Value: boolean);

    function GetTipoModuloSistema: TTipoModuloSistema;
    procedure SetTipoModuloSistema(Value: TTipoModuloSistema);

    function GetNomeDeUsuario: string;
    procedure SetNomeDeUsuario(Value: string);

    function GetSenhaAtual: string;
    procedure SetSenhaAtual(Value: string);

    function GetExecuteOk: boolean;
    procedure SetExecuteOk(Value: boolean);

  protected
    procedure Inicialize; override;
    function prepLer: boolean; override;
    function PrepGravar: boolean; override;

  public
    property PreencheLogin: boolean read GetPreencheLogin
      write SetPreencheLogin;
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema
      write SetTipoModuloSistema;
    property NomeDeUsuario: string read GetNomeDeUsuario write SetNomeDeUsuario;
    property SenhaAtual: string read GetSenhaAtual write SetSenhaAtual;
    property ExecuteOk: boolean read GetExecuteOk write SetExecuteOk;
    constructor Create(pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u;

{ TLoginConfig }

function TLoginConfig.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

constructor TLoginConfig.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create('login', 'Login.Config', '.xml', '', False, pProcessLog, pOutput);
end;

function TLoginConfig.GetExecuteOk: boolean;
begin
  Result := FExecuteOk;
end;

function TLoginConfig.GetNomeDeUsuario: string;
begin
  Result := FNomeDeUsuario;
end;

function TLoginConfig.GetPreencheLogin: boolean;
begin
  Result := FPreencheLogin;
end;

function TLoginConfig.GetSenhaAtual: string;
begin
  Result := FSenhaAtual;
end;

function TLoginConfig.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  PreencheLoginNode := RootNode.AddChild('preenche_login');
  TipoModuloSistemaNode := RootNode.AddChild('modulo_sistema');
  NomeDeUsuarioNode := RootNode.AddChild('nome_de_usuario');
  SenhaAtualNode := RootNode.AddChild('senha_atual');
  ExecuteOkNode := RootNode.AddChild('execute_ok');

  PreencheLoginNode.Text := BooleanToStr(FPreencheLogin);
  TipoModuloSistemaNode.Text := TipoModuloSistemaToNameStr(FTipoModuloSistema);
  NomeDeUsuarioNode.Text := FNomeDeUsuario;
  SenhaAtualNode.Text := FSenhaAtual;
  ExecuteOkNode.Text := BooleanToStr(FExecuteOk);

end;

procedure TLoginConfig.Inicialize;
begin
  inherited;
  FPreencheLogin := False;
  FTipoModuloSistema := modsisNaoIndicado;
  FNomeDeUsuario := '';
  FSenhaAtual := '';
  FExecuteOk := True;
end;

function TLoginConfig.PrepLer: boolean;
var
  s: string;
begin
  Result := inherited PrepLer;
  if not Result then
    exit;

  PreencheLoginNode := RootNode.ChildNodes['preenche_login'];
  TipoModuloSistemaNode := RootNode.ChildNodes['modulo_sistema'];
  NomeDeUsuarioNode := RootNode.ChildNodes['nome_de_usuario'];
  SenhaAtualNode := RootNode.ChildNodes['senha_atual'];
  ExecuteOkNode := RootNode.ChildNodes['execute_ok'];

  s := PreencheLoginNode.Text;
  FPreencheLogin := StrToBoolean(s);

  s := TipoModuloSistemaNode.Text;
  FTipoModuloSistema := NameStrToTipoModuloSistema(s);

  s := NomeDeUsuarioNode.Text;
  FNomeDeUsuario := s;

  s := SenhaAtualNode.Text;
  FSenhaAtual := s;

  s := ExecuteOkNode.Text;
  FExecuteOk := StrToBoolean(s);
end;

procedure TLoginConfig.SetTipoModuloSistema(Value: TTipoModuloSistema);
begin
  FTipoModuloSistema := Value;
end;

procedure TLoginConfig.SetExecuteOk(Value: boolean);
begin
  FExecuteOk := Value;
end;

procedure TLoginConfig.SetNomeDeUsuario(Value: string);
begin
  FNomeDeUsuario := Value;
end;

procedure TLoginConfig.SetPreencheLogin(Value: boolean);
begin
  FPreencheLogin := Value;
end;

procedure TLoginConfig.SetSenhaAtual(Value: string);
begin
  FSenhaAtual := Value;
end;

end.

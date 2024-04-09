unit Sis.UI.Form.Login.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf,
  Sis.UI.Form.Login.Config, Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI_u;

type
  TLoginConfig = class(TConfigXMLI, ILoginConfig)
  private
    FPreencheLogin: boolean;
    FTipoModuloSistema: TTipoModuloSistema;
    FNomeUsu: string;
    FSenha: string;
    FExecuteOk: boolean;

    PreencheLoginNode, TipoModuloSistemaNode, NomeUsuNode, SenhaNode,
      ExecuteOkNode: IXMLNODE;

    function GetPreencheLogin: boolean;
    procedure SetPreencheLogin(Value: boolean);

    function GetTipoModuloSistema: TTipoModuloSistema;
    procedure SetTipoModuloSistema(Value: TTipoModuloSistema);

    function GetNomeUsu: string;
    procedure SetNomeUsu(Value: string);

    function GetSenha: string;
    procedure SetSenha(Value: string);

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
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;
    property Senha: string read GetSenha write SetSenha;
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

function TLoginConfig.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  PreencheLoginNode := RootNode.AddChild('preenche_login');
  TipoModuloSistemaNode := RootNode.AddChild('modulo_sistema');
  NomeUsuNode := RootNode.AddChild('nome_usu');
  SenhaNode := RootNode.AddChild('senha');
  ExecuteOkNode := RootNode.AddChild('execute_ok');

  PreencheLoginNode.Text := BooleanToStr(FPreencheLogin);
  TipoModuloSistemaNode.Text := TipoModuloSistemaToNameStr(FTipoModuloSistema);
  NomeUsuNode.Text := FNomeUsu;
  SenhaNode.Text := FSenha;
  ExecuteOkNode.Text := BooleanToStr(FExecuteOk);

end;

procedure TLoginConfig.Inicialize;
begin
  inherited;
  FPreencheLogin := False;
  FTipoModuloSistema := modsisNaoIndicado;
  FNomeUsu := '';
  FSenha := '';
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
  NomeUsuNode := RootNode.ChildNodes['nome_usu'];
  SenhaNode := RootNode.ChildNodes['senha'];
  ExecuteOkNode := RootNode.ChildNodes['execute_ok'];

  s := PreencheLoginNode.Text;
  FPreencheLogin := StrToBoolean(s);

  s := TipoModuloSistemaNode.Text;
  FTipoModuloSistema := NameStrToTipoModuloSistema(s);

  s := NomeUsuNode.Text;
  FNomeUsu := s;

  s := SenhaNode.Text;
  FSenha := s;

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

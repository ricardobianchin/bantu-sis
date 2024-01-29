unit Sis.UI.Form.Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Sis.Usuario, Sis.Config.SisConfig, Sis.Usuario.DBI,
  Sis.UI.Form.Login.Config, Sis.ModuloSistema, Sis.ModuloSistema.Types,
  Vcl.StdActns;

type
  TLoginForm = class(TDiagBtnBasForm)
    NomeUsuLabeledEdit: TLabeledEdit;
    SenhaLabeledEdit: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure NomeUsuLabeledEditChange(Sender: TObject);
    procedure SenhaLabeledEditChange(Sender: TObject);

    procedure NomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure SenhaLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FUsuario: IUsuario;
    FUsuarioDBI: IUsuarioDBI;
    FLoginConfig: ILoginConfig;
    FTipoModuloSistema: TTipoModuloSistema;

    function NomeUsuOk: Boolean;
    function SenhaOk: Boolean;
    function UsuEncontrado: Boolean;

    procedure ExecuteAutoLogin;
  protected
    function PodeOk: Boolean; override;

  public
    { Public declarations }
    constructor Create(pLoginConfig: ILoginConfig;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pUsuarioDBI: IUsuarioDBI); reintroduce;
  end;

function LoginPerg(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI): Boolean;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

function LoginPerg(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI): Boolean;
var
  Resultado: TModalResult;
begin
  LoginForm := TLoginForm.Create(pLoginConfig, pTipoModuloSistema, pUsuario,
    pUsuarioDBI);
  try
    Resultado := LoginForm.ShowModal;
    Result := IsPositiveResult(Resultado);
  finally
    FreeAndNil(LoginForm);
  end;
end;

{ TLoginForm }

constructor TLoginForm.Create(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI);
var
  sNameTipo: string;
begin
  inherited Create(nil);
  DisparaShowTimer := True;
  FUsuario := pUsuario;
  FUsuarioDBI := pUsuarioDBI;
  FLoginConfig := pLoginConfig;
  FTipoModuloSistema := pTipoModuloSistema;
  sNameTipo := TipoModuloSistemaToNameStr(pTipoModuloSistema);
  Caption := Format('Login %s...', [sNameTipo]);
end;

procedure TLoginForm.ExecuteAutoLogin;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

  NomeUsuLabeledEdit.Text := FLoginConfig.NomeUsu;
  SenhaLabeledEdit.Text := FLoginConfig.Senha;

  OkAct_Diag.Execute;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  inherited;
  MensLabel.Alignment := taCenter;

end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  // era pra ser no create, mas volta a false.
  // está aqui de forma anômala pra se conseguir que DisparaShowTimer fique true
  DisparaShowTimer := True;

  inherited;
end;

procedure TLoginForm.NomeUsuLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TLoginForm.NomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

function TLoginForm.NomeUsuOk: Boolean;
begin
  NomeUsuLabeledEdit.Text := StrSemCharRepetido(NomeUsuLabeledEdit.Text);

  Result := NomeUsuLabeledEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Campo Nome de Usuário é obrigatório');
  NomeUsuLabeledEdit.SetFocus;
end;

function TLoginForm.PodeOk: Boolean;
begin
  Result := NomeUsuOk;

  if not Result then
    exit;

  Result := SenhaOk;

  if not Result then
    exit;

  Result := UsuEncontrado;

//  if not Result then
//    exit;
end;

procedure TLoginForm.SenhaLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TLoginForm.SenhaLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if NomeUsuLabeledEdit.Text = '' then
      NomeUsuLabeledEdit.SetFocus
    else
      OkAct_Diag.Execute;
    exit;
  end;
  inherited;
end;

function TLoginForm.SenhaOk: Boolean;
begin
  Result := SenhaLabeledEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Campo Senha é obrigatório');
  SenhaLabeledEdit.SetFocus;
end;

procedure TLoginForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomeUsuLabeledEdit.SetFocus;
  ExecuteAutoLogin;
end;

function TLoginForm.UsuEncontrado: Boolean;
var
  sNomeUsuDigitado, sSenhaDigitada, sMens: string;
begin
  sNomeUsuDigitado := NomeUsuLabeledEdit.Text;
  sSenhaDigitada := SenhaLabeledEdit.Text;

  Result := FUsuarioDBI.LoginTente(sNomeUsuDigitado, sSenhaDigitada, sMens, FTipoModuloSistema);

  if not Result then
  begin
    ErroOutput.Exibir(sMens);
    NomeUsuLabeledEdit.SetFocus;
    exit;
  end;
end;

end.

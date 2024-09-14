unit Sis.UI.Form.LoginPerg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Sis.Usuario, Sis.Config.SisConfig, Sis.Usuario.DBI,
  Sis.UI.Form.Login.Config, Sis.ModuloSistema, Sis.ModuloSistema.Types,
  Vcl.StdActns, Sis.UI.Form.Login.Types_u;

type
  TLoginPergForm = class(TDiagBtnBasForm)
    NomeUsuLabeledEdit: TLabeledEdit;
    SenhaLabeledEdit: TLabeledEdit;
    TipoPanel: TPanel;
    ModoTitLabel: TLabel;
    LoginPergModoLabel: TLabel;
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
    FTestaAcessaModuloSistema: boolean;

    FLoginPergModo: TLoginPergModo;

    procedure SetLoginPergModo(Value: TLoginPergModo);
    property LoginPergModo: TLoginPergModo read FLoginPergModo write SetLoginPergModo;

    function NomeUsuOk: boolean;
    function SenhaOk: boolean;
    function UsuEncontrado: boolean;

    procedure ExecuteAutoLogin;
  protected
    procedure AjusteControles; override;
    function PodeOk: boolean; override;

  public
    { Public declarations }
    constructor Create(pLoginConfig: ILoginConfig;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean);
      reintroduce;
  end;

function LoginPerg(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean): boolean;

var
  LoginPergForm: TLoginPergForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

function LoginPerg(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean): boolean;
var
  Resultado: TModalResult;
begin
  LoginPergForm := TLoginPergForm.Create(pLoginConfig, pTipoModuloSistema, pUsuario,
    pUsuarioDBI, pTestaAcessaModuloSistema);
  try
    Resultado := LoginPergForm.ShowModal;
    Result := IsPositiveResult(Resultado);
  finally
    FreeAndNil(LoginPergForm);
  end;
end;

{ TLoginPergForm }

procedure TLoginPergForm.AjusteControles;
begin
  inherited;
  LoginPergModoLabel.Caption := LoginPergModoToStr(FLoginPergModo);
end;

constructor TLoginPergForm.Create(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean);
var
  sNomeTipo: string;
begin
  inherited Create(nil);
  FLoginPergModo := TLoginPergModo.ltLogando;
//  DisparaShowTimer := True;
  FUsuario := pUsuario;
  FUsuarioDBI := pUsuarioDBI;
  FLoginConfig := pLoginConfig;
  FTipoModuloSistema := pTipoModuloSistema;
  sNomeTipo := TipoModuloSistemaToStr(pTipoModuloSistema);
  Caption := Format('Login %s...', [sNomeTipo]);
end;

procedure TLoginPergForm.ExecuteAutoLogin;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

  NomeUsuLabeledEdit.Text := FLoginConfig.NomeUsu;
  SenhaLabeledEdit.Text := FLoginConfig.Senha;

  if not FLoginConfig.ExecuteOk then
    exit;

  OkAct_Diag.Execute;
end;

procedure TLoginPergForm.FormCreate(Sender: TObject);
begin
  inherited;
  MensLabel.Alignment := taCenter;

end;

procedure TLoginPergForm.FormShow(Sender: TObject);
begin
  // era pra ser no create, mas volta a false.
  // está aqui de forma anômala pra se conseguir que DisparaShowTimer fique true
//  DisparaShowTimer := True;

  inherited;
end;

procedure TLoginPergForm.NomeUsuLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TLoginPergForm.NomeUsuLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

function TLoginPergForm.NomeUsuOk: boolean;
begin
  NomeUsuLabeledEdit.Text := StrSemCharRepetido(NomeUsuLabeledEdit.Text);

  Result := NomeUsuLabeledEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Campo Nome de Usuário é obrigatório');
  NomeUsuLabeledEdit.SetFocus;
end;

function TLoginPergForm.PodeOk: boolean;
begin
  Result := NomeUsuOk;

  if not Result then
    exit;

  Result := SenhaOk;

  if not Result then
    exit;

  Result := UsuEncontrado;

  // if not Result then
  // exit;
end;

procedure TLoginPergForm.SenhaLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TLoginPergForm.SenhaLabeledEditKeyPress(Sender: TObject; var Key: Char);
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

function TLoginPergForm.SenhaOk: boolean;
begin
  Result := SenhaLabeledEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Campo Senha é obrigatório');
  SenhaLabeledEdit.SetFocus;
end;

procedure TLoginPergForm.SetLoginPergModo(Value: TLoginPergModo);
begin
  FLoginPergModo := Value;
  AjusteControles;
end;

procedure TLoginPergForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomeUsuLabeledEdit.SetFocus;
  ExecuteAutoLogin;
end;

function TLoginPergForm.UsuEncontrado: boolean;
var
  sNomeUsuDigitado, sSenhaDigitada, sMens: string;
  vTipoModuloSistema: TTipoModuloSistema;
begin

  if FTestaAcessaModuloSistema then
    vTipoModuloSistema := FTipoModuloSistema
  else
    vTipoModuloSistema := modsisNaoIndicado;

  sNomeUsuDigitado := NomeUsuLabeledEdit.Text;
  sSenhaDigitada := SenhaLabeledEdit.Text;

  Result := FUsuarioDBI.LoginTente(sNomeUsuDigitado, sSenhaDigitada, sMens,
    vTipoModuloSistema);

  if not Result then
  begin
    ErroOutput.Exibir(sMens);
    NomeUsuLabeledEdit.SetFocus;
    exit;
  end;
end;

end.

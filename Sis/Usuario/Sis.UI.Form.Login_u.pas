unit Sis.UI.Form.Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Sis.Usuario, Sis.Config.SisConfig, Sis.Usuario.DBI,
  Sis.UI.Form.Login.Config;

type
  TLoginForm = class(TDiagBtnBasForm)
    NomeUsuLabeledEdit: TLabeledEdit;
    SenhaLabeledEdit: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

    function NomeUsuOk: Boolean;
    function SenhaOk: Boolean;
    function UsuEncontrado: Boolean;

   protected
     function PodeOk: Boolean; override;

  public
    { Public declarations }
    constructor Create(pLoginConfig: ILoginConfig; pUsuario: IUsuario; pUsuarioDBI: IUsuarioDBI); reintroduce;
  end;

function LoginPerg(pLoginConfig: ILoginConfig; pUsuario: IUsuario; pUsuarioDBI: IUsuarioDBI): boolean;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

function LoginPerg(pLoginConfig: ILoginConfig; pUsuario: IUsuario; pUsuarioDBI: IUsuarioDBI): boolean;
var
  Resultado: TModalResult;
begin
  LoginForm := TLoginForm.Create(pLoginConfig, pUsuario, pUsuarioDBI);
  try
    Resultado := LoginForm.ShowModal;
    Result := IsPositiveResult(Resultado);
  finally
    FreeAndNil(LoginForm);
  end;
end;

{ TLoginForm }

constructor TLoginForm.Create(pLoginConfig: ILoginConfig; pUsuario: IUsuario; pUsuarioDBI: IUsuarioDBI);
begin
  inherited Create(nil);
  DisparaShowTimer := True;
  FUsuario := pUsuario;
  FUsuarioDBI := pUsuarioDBI;
  FLoginConfig := pLoginConfig;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  inherited;
  MensLabel.Alignment := taCenter;

end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
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
  EditKeyPress(Sender, key);
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
    Exit;

  Result := SenhaOk;

  if not Result then
    Exit;

  Result := UsuEncontrado;

  if not Result then
    Exit;
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
end;

function TLoginForm.UsuEncontrado: Boolean;
var
  sNomeUsuDig, sSenhaDig, sMens: string;
begin
  sNomeUsuDig := NomeUsuLabeledEdit.Text;
  sSenhaDig := SenhaLabeledEdit.Text;

  Result := FUsuarioDBI.LoginTente(sNomeUsuDig, sSenhaDig, sMens);

  if not Result  then
  begin
    ErroOutput.Exibir(sMens);
    NomeUsuLabeledEdit.SetFocus;
    exit;
  end;
end;

end.

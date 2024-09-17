unit Sis.UI.Form.LoginPerg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Sis.Usuario, Sis.Config.SisConfig,
  Sis.Usuario.DBI, Sis.UI.Form.Login.Config, Sis.ModuloSistema,
  Sis.ModuloSistema.Types, Vcl.StdActns, Sis.UI.Form.Login.Types_u,
  Sis.UI.IO.Output, Sis.UI.Controls.Alinhador;

type
  TLoginPergForm = class(TDiagBtnBasForm)
    NomeDeUsuarioLabeledEdit: TLabeledEdit;
    Senha1LabeledEdit: TLabeledEdit;
    TipoPanel: TPanel;
    ModoTitLabel: TLabel;
    LoginPergModoLabel: TLabel;
    NomeDeUsuarioStatusLabel: TLabel;
    Senha2LabeledEdit: TLabeledEdit;
    Senha3LabeledEdit: TLabeledEdit;
    SenhaMudarBitBtn_LoginPerg: TBitBtn;
    ObsLabel: TLabel;
    UsuGerenteExibSenhaCheckBox: TCheckBox;
    AvisoSenhaLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    // oculta mensagens de erro que estiverem visiveis
    procedure NomeDeUsuarioLabeledEditChange(Sender: TObject);
    procedure Senha1LabeledEditChange(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure MensCopyAct_DiagExecute(Sender: TObject);
    procedure UsuGerenteExibSenhaCheckBoxClick(Sender: TObject);

    // retiram o foco do controle se enter
    // garantem maiusculas exceto pra senha
    procedure NomeDeUsuarioLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure Senha1LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure Senha2LabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure Senha3LabeledEditKeyPress(Sender: TObject; var Key: Char);

    // testam se ao sair, o foco deve voltar ao controle
    // basta colocar a function que testar o controle
    procedure NomeDeUsuarioLabeledEditExit(Sender: TObject);
    procedure Senha1LabeledEditExit(Sender: TObject);
    procedure Senha2LabeledEditExit(Sender: TObject);
    procedure Senha3LabeledEditExit(Sender: TObject);

    procedure OkAct_DiagExecute(Sender: TObject);

  private
    { Private declarations }
    FUsuario: IUsuario;
    FUsuarioDBI: IUsuarioDBI;
    FLoginConfig: ILoginConfig;
    FTipoModuloSistema: TTipoModuloSistema;

    FLoginPergModo: TLoginPergModo;
    FNomeDeUsuarioStatus: IOutput;

    /// / ajusta modo
    procedure SetLoginPergModo(Value: TLoginPergModo);

    property LoginPergModo: TLoginPergModo read FLoginPergModo
      write SetLoginPergModo;

    // controle = Vcl.Controls.TControl
    // func ControleOk = se o conteudo do controle está aceitavel
    // func DadosOk = se o conteudo do controle nao conflitará com regras de negocio
    // primeiro o usuario so sofre com as 'controle'
    // so na hora do ok da janela de dialogo é que executarah as dados
    function NomeDeUsuarioControleDadosOk: boolean;
    function Senha1ControleOk: boolean;
    function Senha2ControleOk: boolean;
    function Senha3ControleOk: boolean;
    function Senha1DadosOk: boolean;
    function Senha2DadosOk: boolean;

    procedure ExecuteAutoLogin;

    function ConsultaNomeDeUsuario(pNomeDeUsuario: string; out pCryVer: integer;
      out pSenha, pApelido, pModulosSistema, pMens: string;
      out pEncontrado: boolean): boolean;
  protected
    procedure PreencherBaseControlsAlinhador(pBaseControlsAlinhador
      : IControlsAlinhador); override;
    function PodeOk: boolean; override;
    procedure AjusteControles; override;


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

uses Sis.Types.strings_u, Sis.Types.Utils_u, Sis.Sis.Constants,
  Sis.UI.IO.Factory, Sis.Types.Bool_u;

function LoginPerg(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean): boolean;
var
  Resultado: TModalResult;
begin
  LoginPergForm := TLoginPergForm.Create(pLoginConfig, pTipoModuloSistema,
    pUsuario, pUsuarioDBI, pTestaAcessaModuloSistema);
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
  NomeDeUsuarioLabeledEdit.SetFocus;
end;

function TLoginPergForm.ConsultaNomeDeUsuario(pNomeDeUsuario: string;
  out pCryVer: integer; out pSenha, pApelido, pModulosSistema, pMens: string;
  out pEncontrado: boolean): boolean;
begin
  FNomeDeUsuarioStatus.Exibir('Buscando usuário...');
  try
    Result := FUsuarioDBI.UsuarioPeloNomeDeUsuario(pNomeDeUsuario, pCryVer,
      pSenha, pApelido, pModulosSistema, pMens, pEncontrado);
  finally
    FNomeDeUsuarioStatus.Exibir('');
  end;
end;

constructor TLoginPergForm.Create(pLoginConfig: ILoginConfig;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pUsuarioDBI: IUsuarioDBI; pTestaAcessaModuloSistema: boolean);
var
  sNomeTipo: string;
begin
  inherited Create(nil);
  FNomeDeUsuarioStatus := LabelOutputCreate(NomeDeUsuarioStatusLabel);
  FNomeDeUsuarioStatus.Exibir('');

  LoginPergModo := TLoginPergModo.ltLogando;
  // DisparaShowTimer := True;
  FUsuario := pUsuario;
  FUsuarioDBI := pUsuarioDBI;
  FLoginConfig := pLoginConfig;
  FTipoModuloSistema := pTipoModuloSistema;
  sNomeTipo := TipoModuloSistemaToStr(pTipoModuloSistema);
  Caption := Format('Login %s...', [sNomeTipo]);
end;

function TLoginPergForm.Senha1DadosOk: boolean;
var
  sSenha: string;
  sMens: string;
begin
  case FLoginPergModo of
    ltLogando:
    begin
      sSenha := Senha1LabeledEdit.Text;
      Result := sSenha = FUsuario.Senha;
      if not Result then
      begin
        ErroOutput.Exibir('Senha incorreta');
        Senha1LabeledEdit.SetFocus;
        exit;
      end;
    end;
    ltMudandoSenha:
    begin
      sSenha := Senha1LabeledEdit.Text;
      Result := sSenha = FUsuario.Senha;
      if not Result then
      begin
        ErroOutput.Exibir(Senha1LabeledEdit.EditLabel.Caption + ' incorreta');
        Senha1LabeledEdit.SetFocus;
        exit;
      end;
    end;
    ltCriandoSenha:
    begin
      sSenha := Senha1LabeledEdit.Text;
      FUsuario.Senha := sSenha;
      Result := FUsuarioDBI.GravarSenha(sMens);
    end;
  end;
  if not Result then
    ErroOutput.Exibir(sMens);
end;

procedure TLoginPergForm.ExecuteAutoLogin;
var
  Key: Char;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

  NomeDeUsuarioLabeledEdit.Text := FLoginConfig.NomeDeUsuario;

//  Key := #13;
//  NomeDeUsuarioLabeledEditKeyPress(NomeDeUsuarioLabeledEdit, Key);

  // Senha1LabeledEdit.Text := FLoginConfig.SenhaAtual;

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
  // DisparaShowTimer := True;

  inherited;
end;

procedure TLoginPergForm.MensCopyAct_DiagExecute(Sender: TObject);
begin
  inherited;
  if not NomeDeUsuarioControleDadosOk then
    exit;

  if LoginPergModo = TLoginPergModo.ltCriandoSenha then
  begin
    ErroOutput.Exibir('É necessário criar uma senha');
    Senha1LabeledEdit.SetFocus;
    exit;
  end;
  SetLoginPergModo(TLoginPergModo.ltMudandoSenha);
  NomeDeUsuarioLabeledEdit.SetFocus;
end;

procedure TLoginPergForm.NomeDeUsuarioLabeledEditChange(Sender: TObject);
begin
  inherited;
  if FLoginPergModo <> TLoginPergModo.ltLogando then
    SetLoginPergModo(TLoginPergModo.ltLogando);
  MensLimpar;
end;

procedure TLoginPergForm.NomeDeUsuarioLabeledEditExit(Sender: TObject);
begin
  inherited;
  NomeDeUsuarioControleDadosOk;
end;

procedure TLoginPergForm.NomeDeUsuarioLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

function TLoginPergForm.NomeDeUsuarioControleDadosOk: boolean;
var
  sNomeDeUsuario: string;

  iCryVer: integer;
  sSenha, sApelido, sModulosSistema, sMens: string;
  bEncontrado: boolean;
begin
  Result :=
    (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) //
    ; //

  if Result then
    exit;

  sNomeDeUsuario := StrSemCharRepetido(NomeDeUsuarioLabeledEdit.Text,
    CHAR_ESPACO);

  NomeDeUsuarioLabeledEdit.Text := sNomeDeUsuario;

  Result := sNomeDeUsuario <> '';

  if not Result then
  begin
    ErroOutput.Exibir('Campo ''Nome de Usuário'' é obrigatório');
    NomeDeUsuarioLabeledEdit.SetFocus;
    exit;
  end;

  Result := ConsultaNomeDeUsuario(sNomeDeUsuario, iCryVer, sSenha, sApelido,
    sModulosSistema, sMens, bEncontrado);

  if not Result then
  begin
    ErroOutput.Exibir('Erro buscando o usuário: ' + sMens);
    NomeDeUsuarioLabeledEdit.SetFocus;
    exit;
  end;

  if not bEncontrado then
  begin
    ErroOutput.Exibir(sMens);
    NomeDeUsuarioLabeledEdit.SetFocus;
    exit;
  end;

  if sMens = SENHA_ZERADA_MENS then
  begin
    SetLoginPergModo(TLoginPergModo.ltCriandoSenha);
    exit;
  end;
end;

procedure TLoginPergForm.OkAct_DiagExecute(Sender: TObject);
begin
//  inherited;
  if not PodeOk then
    exit;

  if not Senha1DadosOk then
    exit;

  if not Senha2DadosOk then
    exit;

  ModalResult := mrOk;
end;

function TLoginPergForm.PodeOk: boolean;
begin
  Result := NomeDeUsuarioControleDadosOk;

  if not Result then
    exit;

  Result := Senha1ControleOk;
  if not Result then
    exit;

  Result := Senha2ControleOk;
  if not Result then
    exit;

  Result := Senha3ControleOk;
  if not Result then
    exit;
end;

procedure TLoginPergForm.PreencherBaseControlsAlinhador(pBaseControlsAlinhador
  : IControlsAlinhador);
begin
  inherited;
  pBaseControlsAlinhador.PegarControl(SenhaMudarBitBtn_LoginPerg);

end;

procedure TLoginPergForm.Senha1LabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TLoginPergForm.Senha1LabeledEditExit(Sender: TObject);
begin
  inherited;
  Senha1ControleOk;
end;

procedure TLoginPergForm.Senha1LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    case FLoginPergModo of
      ltLogando:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else
            OkAct_Diag.Execute;
        end;
      ltMudandoSenha:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else if Senha1LabeledEdit.Text <> '' then
            Senha2LabeledEdit.SetFocus;
        end;
      ltCriandoSenha:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else
            Senha2LabeledEdit.SetFocus;
        end;
    end;
    exit;
  end;
  //inherited;
end;

procedure TLoginPergForm.Senha2LabeledEditExit(Sender: TObject);
begin
  inherited;
  Senha2ControleOk
end;

procedure TLoginPergForm.Senha2LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    case FLoginPergModo of
      ltLogando:
        begin
        end;
      ltMudandoSenha:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else if Senha1LabeledEdit.Text = '' then
            Senha1LabeledEdit.SetFocus
          else
            Senha3LabeledEdit.SetFocus;
        end;
      ltCriandoSenha:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else if Senha1LabeledEdit.Text = '' then
            Senha1LabeledEdit.SetFocus
          else
            OkAct_Diag.Execute;
        end;
    end;
    exit;
  end;
  //inherited;
end;

function TLoginPergForm.Senha2ControleOk: boolean;
var
  sCaption1: string;
  sCaption2: string;
  sSenhaDig1: string;
  sSenhaDig2: string;
  sFormat: string;
  sMens: string;
begin
  Result :=
    (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = Senha1LabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ;//

  if Result then
    exit;

  case FLoginPergModo of
    ltLogando:
    begin
      Result := True;
    end;
    ltMudandoSenha:
    begin
      sSenhaDig1 := Senha1LabeledEdit.Text;
      sSenhaDig2 := Senha2LabeledEdit.Text;
      Result := sSenhaDig1 <> sSenhaDig2;

      if not Result then
      begin
        sCaption1 := Senha1LabeledEdit.EditLabel.Caption;
        sCaption2 := Senha2LabeledEdit.EditLabel.Caption;

        sFormat := 'Campo ''%s'' deve ser DIFERENTE do campo ''%s''';
        sMens := Format(sFormat, [sCaption1, sCaption2]);

        ErroOutput.Exibir(sMens);
        Senha1LabeledEdit.SetFocus;
        exit;
      end;
    end;
    ltCriandoSenha:
    begin
      sSenhaDig2 := Senha2LabeledEdit.Text;
      sCaption2 := Senha2LabeledEdit.EditLabel.Caption;

      if sSenhaDig2 = '' then
      begin
        ErroOutput.Exibir('Campo ''' + sCaption2 + ''' é obrigatório');
        Senha2LabeledEdit.SetFocus;
        exit;
      end;

      sSenhaDig1 := Senha1LabeledEdit.Text;
      Result := sSenhaDig1 = sSenhaDig2;

      if not Result then
      begin
        sCaption1 := Senha1LabeledEdit.EditLabel.Caption;

        sFormat := 'Campo ''%s'' deve ser igual ao campo ''%s''';
        sMens := Format(sFormat, [sCaption1, sCaption2]);

        ErroOutput.Exibir(sMens);
        Senha1LabeledEdit.SetFocus;
        exit;
      end;
    end;
  end;
end;

function TLoginPergForm.Senha2DadosOk: boolean;
var
  sSenha: string;
  sMens: string;
begin
  case FLoginPergModo of
    ltLogando:
    begin
      Result := True;
    end;
    ltMudandoSenha:
    begin
      sSenha := Senha2LabeledEdit.Text;
      FUsuario.Senha := sSenha;
      Result := FUsuarioDBI.GravarSenha(sMens);
    end;
    ltCriandoSenha:
    begin
      Result := True;
    end;
  end;
  if not Result then
    ErroOutput.Exibir(sMens);
end;

procedure TLoginPergForm.Senha3LabeledEditExit(Sender: TObject);
begin
  inherited;
  Senha3ControleOk;
end;

procedure TLoginPergForm.Senha3LabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    case FLoginPergModo of
      ltLogando:
        begin
        end;
      ltMudandoSenha:
        begin
          if NomeDeUsuarioLabeledEdit.Text = '' then
            NomeDeUsuarioLabeledEdit.SetFocus
          else if Senha1LabeledEdit.Text = '' then
            Senha1LabeledEdit.SetFocus
          else if Senha2LabeledEdit.Text = '' then
            Senha2LabeledEdit.SetFocus
          else
            OkAct_Diag.Execute;
        end;
      ltCriandoSenha:
        begin
        end;
    end;
    exit;
  end;
  inherited;
end;

function TLoginPergForm.Senha3ControleOk: boolean;
var
  sCaption2: string;
  sCaption3: string;

  sSenhaDig2: string;
  sSenhaDig3: string;

  sFormat: string;
  sMens: string;
begin
  Result :=
    (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = Senha1LabeledEdit) or //
    (ActiveControl = Senha2LabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ;//

  if Result then
    exit;

  case FLoginPergModo of
    ltLogando:
    begin
      Result := True;
    end;
    ltMudandoSenha:
    begin
      sSenhaDig2 := Senha1LabeledEdit.Text;
      sSenhaDig3 := Senha2LabeledEdit.Text;
      Result := sSenhaDig2 = sSenhaDig3;

      if not Result then
      begin
        sCaption2 := Senha2LabeledEdit.EditLabel.Caption;
        sCaption3 := Senha3LabeledEdit.EditLabel.Caption;

        sFormat := 'Campo ''%s'' deve ser igual do campo ''%s''';
        sMens := Format(sFormat, [sCaption2, sCaption3]);

        ErroOutput.Exibir(sMens);
        Senha1LabeledEdit.SetFocus;
        exit;
      end;
    end;
    ltCriandoSenha:
    begin
      Result := True;
    end;
  end;
end;

function TLoginPergForm.Senha1ControleOk: boolean;
var
  sEditCaption: string;
begin
  Result :=
    (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ;//

  if Result then
    exit;

  Result := Senha1LabeledEdit.Text <> '';

  if not Result then
  begin
    sEditCaption := Senha1LabeledEdit.EditLabel.Caption;
    ErroOutput.Exibir('Campo '''+sEditCaption+''' é obrigatório');
    Senha1LabeledEdit.SetFocus;
    exit;
  end;
end;

procedure TLoginPergForm.SetLoginPergModo(Value: TLoginPergModo);
begin
  FLoginPergModo := Value;
  case FLoginPergModo of
    ltLogando:
      begin
        LoginPergModoLabel.Caption := 'Logando';
        Senha1LabeledEdit.EditLabel.Caption := 'Senha';
        Senha2LabeledEdit.EditLabel.Visible := False;
        Senha3LabeledEdit.EditLabel.Visible := False;
      end;
    ltMudandoSenha:
      begin
        LoginPergModoLabel.Caption := 'Mudando Senha';
        Senha1LabeledEdit.EditLabel.Caption := 'Senha Atual';

        Senha2LabeledEdit.EditLabel.Caption := 'Nova Senha';
        Senha3LabeledEdit.EditLabel.Caption := 'Repita a Nova Senha';

        Senha2LabeledEdit.Visible := True;
        Senha3LabeledEdit.Visible := True;
      end;
    ltCriandoSenha:
      begin
        LoginPergModoLabel.Caption := 'Criando Senha';
        Senha1LabeledEdit.EditLabel.Caption := 'Senha';

        Senha2LabeledEdit.EditLabel.Caption := 'Repita a Senha';
        Senha2LabeledEdit.Visible := True;

        Senha3LabeledEdit.Visible := False;
      end;
  end;
end;

procedure TLoginPergForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ExecuteAutoLogin;
end;

procedure TLoginPergForm.UsuGerenteExibSenhaCheckBoxClick(Sender: TObject);
begin
  inherited;
  if UsuGerenteExibSenhaCheckBox.Checked then
  begin
    Senha1LabeledEdit.PasswordChar := CHAR_NULO;
    Senha2LabeledEdit.PasswordChar := CHAR_NULO;
    Senha3LabeledEdit.PasswordChar := CHAR_NULO;
    AvisoSenhaLabel.Visible := True;
  end
  else
  begin
    Senha1LabeledEdit.PasswordChar := '*';
    Senha2LabeledEdit.PasswordChar := '*';
    Senha3LabeledEdit.PasswordChar := '*';
    AvisoSenhaLabel.Visible := False;
  end;
  NomeDeUsuarioLabeledEdit.SetFocus;
end;

end.

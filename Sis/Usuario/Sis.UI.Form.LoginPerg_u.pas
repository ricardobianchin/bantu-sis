unit Sis.UI.Form.LoginPerg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Sis.Usuario, Sis.Config.SisConfig,
  Sis.Usuario.DBI, Sis.UI.Form.Login.Config, Sis.ModuloSistema,
  Sis.ModuloSistema.Types, Vcl.StdActns, Sis.UI.Form.Login.Types_u,
  Sis.UI.IO.Output, Sis.UI.Controls.Alinhador, Sis.DB.DBTypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Sis.Entities.Types;

type
  TLoginPergForm = class(TDiagBtnBasForm)
    SenhaMudarBitBtn_LoginPerg: TBitBtn;
    Logo1Image: TImage;
    MeioPanel: TPanel;
    ControlesPanel: TPanel;
    NomeDeUsuarioStatusLabel: TLabel;
    ObsLabel: TLabel;
    AvisoSenhaLabel: TLabel;
    TopoPanel: TPanel;
    ModoTitLabel: TLabel;
    LoginPergModoLabel: TLabel;
    Senha1LabeledEdit: TLabeledEdit;
    NomeDeUsuarioLabeledEdit: TLabeledEdit;
    Senha2LabeledEdit: TLabeledEdit;
    Senha3LabeledEdit: TLabeledEdit;
    UsuAdminiExibSenhaCheckBox: TCheckBox;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    // oculta mensagens de erro que estiverem visiveis
    procedure NomeDeUsuarioLabeledEditChange(Sender: TObject);
    procedure Senha1LabeledEditChange(Sender: TObject);
    procedure UsuAdminiExibSenhaCheckBoxClick(Sender: TObject);

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
    procedure MensCopyAct_DiagExecute(Sender: TObject);

  private
    { Private declarations }
    FDBConnectionParams: TDBConnectionParams;

    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FId: integer;
    FNomeCompleto: string;
    FNomeExib: string;
    FNomeDeUsuario: string;
    FSenha: string;
    FCryVer: smallint;

    FLoginConfig: ILoginConfig;
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;

    FLoginPergModo: TLoginPergModo;
    FNomeDeUsuarioStatus: IOutput;
    FLogo1NomeArq: string;
    FMachiceIdentId: SmallInt;

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

    function ConsultaNomeDeUsuario(pNomeUsuDig: string;
      out pApelido, pMens: string; out pEncontrado: boolean): boolean;

    function LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
      out pAceito: boolean; out pMens: string): boolean;

    function GravarSenha(out pMens: string): boolean;
  protected
    procedure PreencherBaseControlsAlinhador(pBaseControlsAlinhador
      : IControlsAlinhador); override;
    function PodeOk: boolean; override;
    procedure AjusteControles; override;

  public
    { Public declarations }
    property LojaId: TLojaId read FLojaId;
    property TerminalId: TTerminalId read FTerminalId;
    property Id: integer read FId;
    property NomeCompleto: string read FNomeCompleto;
    property NomeExib: string read FNomeExib;
    property NomeDeUsuario: string read FNomeDeUsuario;
    property Senha: string read FSenha;
    property CryVer: smallint read FCryVer;

    constructor Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
      pDBConnectionParams: TDBConnectionParams;
      pTestaAcessaModuloSistema: boolean; pLogo1NomeArq: string; pMachiceIdentId: SmallInt;
      out pLojaId: TLojaId; out pTerminalId: TTerminalId; out pId: integer;
      out pNomeCompleto: string; out pNomeExib: string;
      out pNomeDeUsuario: string; out pSenha: string; out pCryVer: smallint);
      reintroduce;
  end;

function LoginPerg({pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pDBConnectionParams: TDBConnectionParams; pTestaAcessaModuloSistema: boolean;
  pLogo1NomeArq: string; pMachiceIdentId: SmallInt; out pLojaId: TLojaId; out pTerminalId: TTerminalId;
  out pId: integer; out pNomeCompleto: string; out pNomeExib: string;
  out pNomeDeUsuario: string; out pSenha: string;
  out pCryVer: smallint}): boolean;

var
  LoginPergForm: TLoginPergForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.Types.Utils_u, Sis.Sis.Constants,
  Sis.UI.IO.Factory, Sis.Types.Bool_u, Sis.UI.Controls.Utils,
  Sis.Usuario.Factory, Sis.DB.Factory, Sis.Usuario.DBI.GetSQL_u,
  Sis.Types.strings.Crypt_u, Sis.Usuario.Senha_u;

function LoginPerg({pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pDBConnectionParams: TDBConnectionParams; pTestaAcessaModuloSistema: boolean;
  pLogo1NomeArq: string; pMachiceIdentId: SmallInt; out pLojaId: TLojaId; out pTerminalId: TTerminalId;
  out pId: integer; out pNomeCompleto: string; out pNomeExib: string;
  out pNomeDeUsuario: string; out pSenha: string;
  out pCryVer: smallint}): boolean;
//var
//  Resultado: TModalResult;
begin
//    pLojaId := 1;
//    pTerminalId := 0;
//    pId := -2;
//    pNomeCompleto := 'SUPORTE TECNICO';
//    pNomeExib := 'SUPORTE';
//    pNomeDeUsuario := 'SUP';
//    pSenha := '123';
//    pCryVer := 1;
    RESULT := tRUE;
  exit;

//  LoginPergForm := TLoginPergForm.Create(pTipoOpcaoSisModulo,
//    pDBConnectionParams, pTestaAcessaModuloSistema, pLogo1NomeArq, pMachiceIdentId, pLojaId,
//    pTerminalId, pId, pNomeCompleto, pNomeExib, pNomeDeUsuario, pSenha,
//    pCryVer);
//  try
//    Resultado := LoginPergForm.ShowModal;
//    Result := IsPositiveResult(Resultado);
//    if not Result then
//      exit;
//
//    pLojaId := LoginPergForm.LojaId;
//    pTerminalId := LoginPergForm.TerminalId;
//    pId := LoginPergForm.Id;
//    pNomeCompleto := LoginPergForm.NomeCompleto;
//    pNomeExib := LoginPergForm.NomeExib;
//    pNomeDeUsuario := LoginPergForm.NomeDeUsuario;
//    pSenha := LoginPergForm.Senha;
//    pCryVer := LoginPergForm.CryVer;
//
//  finally
//    FreeAndNil(LoginPergForm);
//  end;
end;

{ TLoginPergForm }

procedure TLoginPergForm.AjusteControles;
begin
  inherited;
  AlteracaoTextoLabel.Parent := ControlesPanel;
  BasePanel.Parent := ControlesPanel;
  MensLabel.Parent := ControlesPanel;
  ControlAlignToCenter(ControlesPanel);
  ControlesPanel.Visible := True;

  TrySetFocus(NomeDeUsuarioLabeledEdit);
end;

function TLoginPergForm.ConsultaNomeDeUsuario(pNomeUsuDig: string;
  out pApelido, pMens: string; out pEncontrado: boolean): boolean;
var
  sSql: string;
  q: TDataSet;
begin
  try
    FDConnection1.Open;
    Result := FDConnection1.connected;
  except
    on e: exception do
    begin
      pMens := e.Message;
      Result := False;
    end;
  end;

  if Result = False then
    exit;

  try
    q := FDQuery1;
    FDQuery1.SQL.Text := GetSQLUsuarioPeloNomeDeUsuario(pNomeUsuDig);

    FDQuery1.Open;
    try
      pEncontrado := not q.IsEmpty;

      if not pEncontrado then
      begin
        pMens := 'Nome de Usuário não encontrado';
        exit;
      end;

      FLojaId := q.FieldByName('LOJA_ID').AsInteger;
      FTerminalId := 0;
      FId := q.FieldByName('PESSOA_ID').AsInteger;
      FNomeCompleto := q.FieldByName('NOME').AsString.Trim;
      FNomeExib := q.FieldByName('APELIDO').AsString.Trim;

      if q.FieldByName('SENHA_ZERADA').AsBoolean then
      begin
        pMens := SENHA_ZERADA_MENS;
        exit;
      end;
    finally
      FDQuery1.Close;
    end;

    {


      iLojaId := q.FieldByName('LOJA_ID').AsInteger;
      iPessoaId := q.FieldByName('PESSOA_ID').AsInteger;
      sNomeCompleto := q.FieldByName('NOME').AsString.Trim;
      sApelido := q.FieldByName('APELIDO').AsString.Trim;

      q.Free;

      FUsuario.Pegar(iLojaId, 0, iPessoaId);
      FUsuario.NomeCompleto := sNomeCompleto;
      FUsuario.NomeExib := sApelido;

      if pTipoModuloSistema = modsisNaoIndicado then
      exit;

      sSql := GetSQLUsuarioAcessaModuloSistema(iLojaId, iPessoaId,
      pTipoModuloSistema);
      // sSql := 'SELECT ACESSA FROM USUARIO_PA.USUARIO_ACESSA_MODULO_GET(1, 2,''!'');';
      DBConnection.QueryDataSet(sSql, q);
      Result := not q.IsEmpty;

      if not Result then
      begin
      q.Free;
      sTipoModuloSistema := TipoModuloSistemaToStr(pTipoModuloSistema);
      pMens := 'Usuário sem direitos para abrir o módulo ' + sTipoModuloSistema;
      exit;
      end;

      Result := q.Fields[0].AsBoolean;
      q.Free;

      if not Result then
      begin
      sTipoModuloSistema := TipoModuloSistemaToStr(pTipoModuloSistema);
      pMens := 'Usuário sem direitos para abrir o módulo ' + sTipoModuloSistema;
      exit;
      end;
    }
  finally
    FDConnection1.Close;
  end;
end;

constructor TLoginPergForm.Create(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pDBConnectionParams: TDBConnectionParams; pTestaAcessaModuloSistema: boolean;
  pLogo1NomeArq: string; pMachiceIdentId: SmallInt; out pLojaId: TLojaId; out pTerminalId: TTerminalId;
  out pId: integer; out pNomeCompleto: string; out pNomeExib: string;
  out pNomeDeUsuario: string; out pSenha: string; out pCryVer: smallint);
var
  sNomeTipo: string;
begin
  inherited Create(nil);
  MensLabel.Alignment := taCenter;
  FNomeDeUsuarioStatus := LabelOutputCreate(NomeDeUsuarioStatusLabel);
  FNomeDeUsuarioStatus.Exibir('');

  LoginPergModo := TLoginPergModo.ltLogando;
  // DisparaShowTimer := True;

  FTerminalId := 0;
  FCryVer := 1;


  FDBConnectionParams := pDBConnectionParams;
  FDConnection1.Params.Values['Database'] := FDBConnectionParams.Arq;
  FDConnection1.Params.Values['Server'] := FDBConnectionParams.Server;

  FLoginConfig := LoginConfigCreate;
  FLoginConfig.Ler;
  FTipoOpcaoSisModulo := pTipoOpcaoSisModulo;
  sNomeTipo := AnsiUpperCase(TipoOpcaoSisModuloToStr(pTipoOpcaoSisModulo));
  Caption := Format('Login em %s...', [sNomeTipo]);
  FLogo1NomeArq := pLogo1NomeArq;
  FMachiceIdentId := pMachiceIdentId;
  Logo1Image.Picture.LoadFromFile(FLogo1NomeArq);

end;

function TLoginPergForm.Senha1DadosOk: boolean;
var
  sSenha: string;
  sMens: string;
  bAceito: boolean;
begin
  case FLoginPergModo of
    ltLogando:
      begin
        FSenha := Senha1LabeledEdit.Text;

        ErroOutput.Exibir('');
        Result := LoginValide(TOpcaoSisId(FTipoOpcaoSisModulo), bAceito, sMens);

        if not Result then
        begin
          ErroOutput.Exibir(sMens);
          NomeDeUsuarioLabeledEdit.SetFocus;
          exit;
        end;

        Result := sMens <> SENHA_ZERADA_MENS;
        if not Result then
        begin
          SetLoginPergModo(TLoginPergModo.ltCriandoSenha);
          exit;
        end;

        Result := bAceito;

        if not Result then
        begin
          ErroOutput.Exibir(sMens);
          NomeDeUsuarioLabeledEdit.SetFocus;
          exit;
        end;
      end;
    ltMudandoSenha:
      begin
        FSenha := Senha1LabeledEdit.Text;

        ErroOutput.Exibir('');
        Result := LoginValide(TOpcaoSisId(FTipoOpcaoSisModulo), bAceito, sMens);

        if not Result then
        begin
          ErroOutput.Exibir(sMens);
          NomeDeUsuarioLabeledEdit.SetFocus;
          exit;
        end;

        Result := sMens <> SENHA_ZERADA_MENS;
        if not Result then
        begin
          SetLoginPergModo(TLoginPergModo.ltCriandoSenha);
          exit;
        end;

        Result := bAceito;

        if not Result then
        begin
          if sMens = SENHA_INCORRETA_MENS then
            ErroOutput.Exibir('Senha atual incorreta')
          else
            ErroOutput.Exibir(sMens);
          NomeDeUsuarioLabeledEdit.SetFocus;
          exit;
        end;
      end;
    ltCriandoSenha:
      begin
        sSenha := Senha1LabeledEdit.Text;
        FSenha := sSenha;
        ErroOutput.Exibir('');
        Result := GravarSenha(sMens);
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

  Key := #13;
  NomeDeUsuarioLabeledEditKeyPress(NomeDeUsuarioLabeledEdit, Key);

  Senha1LabeledEdit.Text := FLoginConfig.SenhaAtual;

  if not FLoginConfig.ExecuteOk then
    exit;

  OkAct_Diag.Execute;
end;

function TLoginPergForm.GravarSenha(out pMens: string): boolean;
var
  sComandoSql: string;
  sSenhaEncriptada: string;
begin
  Encriptar(FCryVer, FSenha, sSenhaEncriptada);

  try
    FDConnection1.Open;
    Result := FDConnection1.connected;
  except
    on e: exception do
    begin
      ErroOutput.Exibir(e.Message);
      Result := False;
    end;
  end;
  if Result = False then
    Exit;

  try
    sComandoSql := 'EXECUTE PROCEDURE USUARIO_PA.SENHA_SET(' //
    + FLojaId.ToString // pLojaId.ToString //
    + ', ' + FId.ToString // pUsuarioPessoaId.ToString //
    + ', ' + FId.ToString // pLogPessoaId.ToString //
    + ', ' + FMachiceIdentId.ToString // pMachineId.ToString //

    + ', ' + QuotedStr(sSenhaEncriptada) //
    + ', ' + FCryVer.ToString //
    + ');'; //


    FDConnection1.ExecSQL(sComandoSql);
  finally
    FDConnection1.Close;
  end;
end;

function TLoginPergForm.LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
  out pAceito: boolean; out pMens: string): boolean;
var
  sSql: string;
  q: TDataSet;
  iCryVer: smallint;
  sSenhaEncriptada: string;
  sSenhaDesencriptada: string;
  bOpcaoSisIdModuloPode: boolean;
begin
  try
    FDConnection1.Open;
    Result := FDConnection1.connected;
  except
    on e: exception do
    begin
      pMens := e.Message;
      Result := False;
    end;
  end;
  if Result = False then
    Exit;

  sSql := 'SELECT'#13#10 //
    + 'NOME_DE_USUARIO_OK -- 0'#13#10 //
    + ', CRY_VER -- 1'#13#10 //
    + ', SENHA -- 2'#13#10 //
    + ', OPCAO_SIS_ID_MODULO_PODE -- 3'#13#10 //

    + 'FROM USUARIO_PA.LOGIN_VALID_GET('#13#10 //

    + FLojaId.ToString + ' -- LOJA_ID'#13#10 //
    + ', ' + FId.ToString + ' -- PESSOA_ID'#13#10 //
    + ', ' + FNomeDeUsuario.QuotedString + ' -- NOME_DE_USUAR'#13#10 //
    + ', ' + pOpcaoSisIdModuloTentando.ToString + ' -- OPCAO_SIS_ID'#13#10 //

    + ');'; //

  try
    try
      FDQuery1.Sql.Text := sSql;
      FDQuery1.Open;
    except
      on e: exception do
      begin
        pMens := e.Message;
        Result := False;
        raise;
      end;
    end;

    try
      q := FDQuery1;
      pAceito := not q.IsEmpty;

      if not pAceito then
      begin
        pMens := 'Erro buscando o registro do Usuário';
        exit;
      end;

      pAceito := q.Fields[0 { NOME_DE_USUARIO_OK } ].AsBoolean;

      if not pAceito then
      begin
        pMens := 'Nome de Usuário incorreto';
        exit;
      end;

      iCryVer := q.Fields[1 { CRY_VER } ].AsInteger;
      sSenhaEncriptada := q.Fields[2 { SENHA } ].AsString.Trim;

      Desencriptar(iCryVer, sSenhaEncriptada, sSenhaDesencriptada);

      pAceito := sSenhaDesencriptada <> SENHA_ZERADA;
      if not pAceito then
      begin
        pMens := SENHA_ZERADA_MENS;
        exit;
      end;

      pAceito := FSenha = sSenhaDesencriptada;
      if not pAceito then
      begin
        pMens := 'Senha incorreta';
        exit;
      end;

      FCryVer := iCryVer;

      bOpcaoSisIdModuloPode := q.FieldByName('OPCAO_SIS_ID_MODULO_PODE')
        .AsBoolean;

      pAceito := bOpcaoSisIdModuloPode;

      if not pAceito then
      begin
        pMens := 'Usuário sem direitos de acesso a este módulo do sistema';
        exit;
      end;
    finally
      q.Free;
    end;
  finally
    FDConnection1.Close;
  end;
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
  Senha1LabeledEdit.Clear;
  Senha2LabeledEdit.Clear;
  Senha3LabeledEdit.Clear;
  SetLoginPergModo(TLoginPergModo.ltMudandoSenha);
  Senha1LabeledEdit.SetFocus;
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

  sApelido, sMens: string;
  bEncontrado: boolean;
begin
  Result := (ActiveControl = CancelBitBtn_DiagBtn) or //
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

  Result := ConsultaNomeDeUsuario(sNomeDeUsuario, sApelido, sMens, bEncontrado);

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
  // inherited;
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
  // inherited;
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
  // inherited;
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
  Result := (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = Senha1LabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ; //

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
        FSenha := sSenha;
        Result := GravarSenha(sMens);
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
  Result := (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = Senha1LabeledEdit) or //
    (ActiveControl = Senha2LabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ; //

  if Result then
    exit;

  case FLoginPergModo of
    ltLogando:
      begin
        Result := True;
      end;
    ltMudandoSenha:
      begin
        sSenhaDig2 := Senha2LabeledEdit.Text;
        sSenhaDig3 := Senha3LabeledEdit.Text;
        Result := sSenhaDig2 = sSenhaDig3;

        if not Result then
        begin
          sCaption2 := Senha2LabeledEdit.EditLabel.Caption;
          sCaption3 := Senha3LabeledEdit.EditLabel.Caption;

          sFormat := 'Campo ''%s'' deve ser igual do campo ''%s''';
          sMens := Format(sFormat, [sCaption2, sCaption3]);

          ErroOutput.Exibir(sMens);
          Senha2LabeledEdit.SetFocus;
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
  Result := (ActiveControl = CancelBitBtn_DiagBtn) or //
    (ActiveControl = NomeDeUsuarioLabeledEdit) or //
    (ActiveControl = SenhaMudarBitBtn_LoginPerg) //
    ; //

  if Result then
    exit;

  Result := Senha1LabeledEdit.Text <> '';

  if not Result then
  begin
    sEditCaption := Senha1LabeledEdit.EditLabel.Caption;
    ErroOutput.Exibir('Campo ''' + sEditCaption + ''' é obrigatório');
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

procedure TLoginPergForm.UsuAdminiExibSenhaCheckBoxClick(Sender: TObject);
begin
  inherited;
  if UsuAdminiExibSenhaCheckBox.Checked then
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

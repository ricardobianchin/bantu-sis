unit Sis.Usuario.DBI_u;

interface

uses Sis.Usuario.DBI, Sis.DBI_u, Sis.Usuario, Sis.DB.DBTypes,
  Sis.ModuloSistema.Types, Sis.Config.SisConfig;

type
  TUsuarioDBI = class(TDBI, IUsuarioDBI)
  private
    FUsuario: IUsuario;
    FSisConfig: ISisConfig;
  public
    function UsuarioPeloNomeDeUsuario(pNomeUsuDig: string;
      out pApelido, pMens: string; out pEncontrado: boolean): boolean;

    function LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
      out pAceito: boolean; out pMens: string): boolean;

    function GravarSenha(out pMens: string): boolean;

    procedure Leia;

    procedure LeiaAdmin;

    constructor Create(pDBConnection: IDBConnection; pUsuario: IUsuario;
      pSisConfig: ISisConfig);
  end;

implementation

uses Sis.Types.strings.Crypt_u, Sis.Usuario.DBI.GetSQL_u, Data.DB,
  System.SysUtils, Sis.Sis.Constants, Sis.Win.Utils_u, Sis.Usuario.Senha_u,
  Sis.Entities.Types;

{ TUsuarioDBI }

constructor TUsuarioDBI.Create(pDBConnection: IDBConnection; pUsuario: IUsuario;
  pSisConfig: ISisConfig);
begin
  inherited Create(pDBConnection);
  FUsuario := pUsuario;
  FSisConfig := pSisConfig;
end;

function TUsuarioDBI.GravarSenha(out pMens: string): boolean;
var
  sSenhaEncriptada: string;
begin
  Encriptar(FUsuario.CryVer, FUsuario.Senha, sSenhaEncriptada);

  // nao retire o nome da unit para nao conflitar com o identificador local
  // Sis.Usuario.Senha_u fica
  Result := Sis.Usuario.Senha_u.GravarSenha( //
    sSenhaEncriptada // pNovaSenha
    , FUsuario.CryVer // pCryVer
    , FUsuario.LojaId // pLojaId
    , FUsuario.Id // pUsuarioPessoaId
    , FUsuario.Id // pLogPessoaId
    , FSisConfig.LocalMachineId.IdentId // pMachineId
    , DBConnection // pDBConnection
    , pMens // pMens
    );
end;

procedure TUsuarioDBI.Leia;
var
  sSql: string;
  q: TDataSet;
  iCryVer: smallint;
  sSenhaEncriptada: string;
  sSenhaDesencriptada: string;
  bOpcaoSisIdModuloPode: boolean;
  Resultado: Boolean;
begin
  Resultado := DBConnection.Abrir;
  if not Resultado then
  begin
    raise Exception.Create(DBConnection.UltimoErro);
    exit;
  end;

  sSql :=
    'SELECT APELIDO'#13#10 //
    +'FROM pessoa'#13#10 //
    +'WHERE loja_id = ' +FUsuario.LojaId.ToString + #13#10 //
    +'AND terminal_id = 0'#13#10 //
    +'AND pessoa_id = ' +FUsuario.Id.ToString + #13#10 //
    ;

  // {$IFDEF DEBUG}
  // SetClipboardText(sSql);
  // {$ENDIF}
  try
    try
      DBConnection.QueryDataSet(sSql, q);
    except
      on E: Exception do
      begin
        raise Exception.Create(DBConnection.UltimoErro);
      end;
    end;

    try
      FUsuario.NomeExib := q.fields[0].AsString.Trim;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TUsuarioDBI.LeiaAdmin;
var
  sSql: string;
  q: TDataSet;
  Resultado: Boolean;
begin
  Resultado := DBConnection.Abrir;
  if not Resultado then
  begin
    raise Exception.Create(DBConnection.UltimoErro);
    exit;
  end;

  sSql :=
    'WITH USU AS ('#13#10 //
    +'SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME_DE_USUARIO'#13#10 //
    +'FROM USUARIO'#13#10 //
    +'), PER AS ('#13#10 //
    +'SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID'#13#10 //
    +'FROM USUARIO_TEM_PERFIL_DE_USO'#13#10 //
    +'WHERE PERFIL_DE_USO_ID = 2'#13#10 //
    +')'#13#10 //
    +'SELECT'#13#10 //
    +'FIRST(1)'#13#10 //
    +'USU.LOJA_ID,'#13#10 //0
    +'USU.TERMINAL_ID,'#13#10 //1
    +'USU.PESSOA_ID,'#13#10 //2
    +'USU.NOME_DE_USUARIO'#13#10 //3
    +'FROM USU'#13#10 //
    +'JOIN PER ON'#13#10 //
    +'USU.LOJA_ID = PER.LOJA_ID'#13#10 //
    +'AND USU.TERMINAL_ID = PER.TERMINAL_ID'#13#10 //
    +'AND USU.PESSOA_ID = PER.PESSOA_ID'#13#10 //
    +'ORDER BY USU.PESSOA_ID'#13#10 //
    ;

  // {$IFDEF DEBUG}
  // SetClipboardText(sSql);
  // {$ENDIF}
  try
    try
      DBConnection.QueryDataSet(sSql, q);
    except
      on E: Exception do
      begin
        raise Exception.Create(DBConnection.UltimoErro);
      end;
    end;

    try
      FUsuario.LojaId := q.fields[0].AsInteger;
      FUsuario.TerminalId := q.fields[1].AsInteger;
      FUsuario.Id := q.fields[2].AsInteger;
      FUsuario.NomeDeUsuario := q.fields[3].AsString.Trim;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TUsuarioDBI.LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
  out pAceito: boolean; out pMens: string): boolean;
var
  sSql: string;
  q: TDataSet;
  iCryVer: smallint;
  sSenhaEncriptada: string;
  sSenhaDesencriptada: string;
  bOpcaoSisIdModuloPode: boolean;
begin
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  sSql := 'SELECT'#13#10 //
    + 'NOME_DE_USUARIO_OK -- 0'#13#10 //
    + ', CRY_VER -- 1'#13#10 //
    + ', SENHA -- 2'#13#10 //
    + ', OPCAO_SIS_ID_MODULO_PODE -- 3'#13#10 //

    + 'FROM USUARIO_PA.LOGIN_VALID_GET('#13#10 //

    + FUsuario.LojaId.ToString + ' -- LOJA_ID'#13#10 //
    + ', ' + FUsuario.Id.ToString + ' -- PESSOA_ID'#13#10 //
    + ', ' + FUsuario.NomeDeUsuario.QuotedString + ' -- NOME_DE_USUAR'#13#10 //
    + ', ' + pOpcaoSisIdModuloTentando.ToString + ' -- OPCAO_SIS_ID'#13#10 //

    + ');'; //
  // {$IFDEF DEBUG}
  // SetClipboardText(sSql);
  // {$ENDIF}
  try
    try
      DBConnection.QueryDataSet(sSql, q);
    except
      on E: Exception do
      begin
        pMens := DBConnection.UltimoErro;
        Result := False;
        raise;
      end;
    end;

    try
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

      pAceito := FUsuario.Senha = sSenhaDesencriptada;
      if not pAceito then
      begin
        pMens := 'Senha incorreta';
        exit;
      end;

      FUsuario.CryVer := iCryVer;

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
    DBConnection.Fechar;
  end;
end;

function TUsuarioDBI.UsuarioPeloNomeDeUsuario(pNomeUsuDig: string;
  out pApelido, pMens: string; out pEncontrado: boolean): boolean;
var
  sSql: string;
  q: TDataSet;
  iLojaId, iPessoaId: integer;
  sNomeCompleto, sApelido: string;
begin
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    sSql := GetSQLUsuarioPeloNomeDeUsuario(pNomeUsuDig);
    // {$IFDEF DEBUG}
    // SetClipboardText(sSql);
    // {$ENDIF}
    DBConnection.QueryDataSet(sSql, q);
    try
      pEncontrado := not q.IsEmpty;

      if not pEncontrado then
      begin
        pMens := 'Nome de Usuário não encontrado';
        exit;
      end;

      iLojaId := q.FieldByName('LOJA_ID').AsInteger;
      iPessoaId := q.FieldByName('PESSOA_ID').AsInteger;
      sNomeCompleto := q.FieldByName('NOME').AsString.Trim;
      sApelido := q.FieldByName('APELIDO').AsString.Trim;

      FUsuario.Pegar(iLojaId, 0, iPessoaId);
      FUsuario.NomeCompleto := sNomeCompleto;
      FUsuario.NomeDeUsuario := pNomeUsuDig;
      FUsuario.NomeExib := sApelido;

      if q.FieldByName('SENHA_ZERADA').AsBoolean then
      begin
        pMens := SENHA_ZERADA_MENS;
        exit;
      end;
    finally
      q.Free;
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
    DBConnection.Fechar;
  end;
end;

end.

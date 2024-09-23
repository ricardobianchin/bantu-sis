unit Sis.Usuario.DBI_u;

interface

uses Sis.Usuario.DBI, Sis.DBI_u, Sis.Usuario, Sis.DB.DBTypes,
  Sis.ModuloSistema.Types;

type
  TUsuarioDBI = class(TDBI, IUsuarioDBI)
  private
    FUsuario: IUsuario;
  public
    function UsuarioPeloNomeDeUsuario(pNomeUsuDig: string;
      out pApelido, pMens: string; out pEncontrado: boolean): boolean;

    function LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
      out pAceito: boolean; out pMens: string): boolean;

    function GravarSenha(out pMens: string): boolean;

    constructor Create(pDBConnection: IDBConnection; pUsuario: IUsuario);
  end;

implementation

uses Sis.Types.strings.Crypt_u, Sis.Usuario.DBI.GetSQL_u, Data.DB,
  System.SysUtils, Sis.Sis.Constants, Sis.Win.Utils_u, Sis.Usuario.Senha_u;

{ TUsuarioDBI }

constructor TUsuarioDBI.Create(pDBConnection: IDBConnection;
  pUsuario: IUsuario);
begin
  inherited Create(pDBConnection);
  FUsuario := pUsuario;
end;

function TUsuarioDBI.GravarSenha(out pMens: string): boolean;
var
  sSenhaEncriptada: string;
begin
  Encriptar(FUsuario.CryVer, FUsuario.Senha, sSenhaEncriptada);

  // nao retire o nome da unit para nao conflitar com o identificador local
  // Sis.Usuario.Senha_u fica
  Result := Sis.Usuario.Senha_u.GravarSenha(sSenhaEncriptada, FUsuario.CryVer,
    FUsuario.LojaId, FUsuario.TerminalId, FUsuario.Id, DBConnection, pMens);
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
  {$IFDEF DEBUG}
    SetClipboardText(sSql);
  {$ENDIF}
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
        pMens := 'Erro buscando o registro do Usu�rio';
        exit;
      end;

      pAceito := q.Fields[0 { NOME_DE_USUARIO_OK } ].AsBoolean;

      if not pAceito then
      begin
        pMens := 'Nome de Usu�rio incorreto';
        exit;
      end;

      iCryVer := q.Fields[1{CRY_VER}].AsInteger;
      sSenhaEncriptada := q.Fields[2{SENHA}].AsString.Trim;

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
        pMens := 'Usu�rio sem direitos de acesso a este m�dulo do sistema';
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
        pMens := 'Nome de Usu�rio n�o encontrado';
        exit;
      end;

      iLojaId := q.FieldByName('LOJA_ID').AsInteger;
      iPessoaId := q.FieldByName('PESSOA_ID').AsInteger;
      sNomeCompleto := q.FieldByName('NOME').AsString.Trim;
      sApelido := q.FieldByName('APELIDO').AsString.Trim;

      FUsuario.Pegar(iLojaId, 0, iPessoaId);
      FUsuario.NomeCompleto := sNomeCompleto;
      FUsuario.NomeDeUsuario  := pNomeUsuDig;
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
      pMens := 'Usu�rio sem direitos para abrir o m�dulo ' + sTipoModuloSistema;
      exit;
      end;

      Result := q.Fields[0].AsBoolean;
      q.Free;

      if not Result then
      begin
      sTipoModuloSistema := TipoModuloSistemaToStr(pTipoModuloSistema);
      pMens := 'Usu�rio sem direitos para abrir o m�dulo ' + sTipoModuloSistema;
      exit;
      end;
    }
  finally
    DBConnection.Fechar;
  end;
end;

end.

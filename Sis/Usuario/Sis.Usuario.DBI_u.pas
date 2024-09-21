unit Sis.Usuario.DBI_u;

interface

uses Sis.Usuario.DBI, Sis.DBI_u, Sis.Usuario, Sis.DB.DBTypes,
  Sis.ModuloSistema.Types;

type
  TUsuarioDBI = class(TDBI, IUsuarioDBI)
  private
    FUsuario: IUsuario;
  public
    function UsuarioPeloNomeDeUsuario(pNomeUsuDig: string; out pApelido,
      pModulosSistema, pMens: string; out pEncontrado: boolean): boolean;

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
    FUsuario.LojaId, FUsuario.TerminalId, FUsuario.Id,
    DBConnection, pMens);
end;

function TUsuarioDBI.UsuarioPeloNomeDeUsuario(pNomeUsuDig: string; out pCryVer: integer;
  out Senha, pApelido, pModulosSistema, pMens: string;
  out pEncontrado: boolean): boolean;
var
  sSql: string;
  sSenhaDigEncriptada: string;
  q: TDataSet;
  iLojaId, iPessoaId: integer;
  sSenhaDBDesencriptada, sSenhaDBEncriptada: string;
  sNomeCompleto, sApelido: string;
  CryVer: Word;
  sTipoModuloSistema: string;
  // LOJA_ID SMALLINT, PESSOA_ID INTEGER, NOME VARCHAR(90), APELIDO VARCHAR(20),
  // , SENHA VARCHAR(80))
begin
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    sSql := GetSQLUsuarioPeloNomeDeUsuario(pNomeUsuDig);
    //{$IFDEF DEBUG}
    //SetClipboardText(sSql);
    //{$ENDIF}
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
      FUsuario.NomeExib := sApelido;

      sSenhaDBEncriptada := q.FieldByName('SENHA').AsString.Trim;

      if sSenhaDBEncriptada = SENHA_ZERADA then
      begin
        pMens := SENHA_ZERADA_MENS;
        exit;
      end;

      CryVer := Word(q.FieldByName('CRY_VER').AsInteger);
      Desencriptar(CryVer, sSenhaDBEncriptada, sSenhaDBDesencriptada);

      FUsuario.Senha := sSenhaDBDesencriptada;
      {
      Result := sSenhaDBEncriptada = sSenhaDigEncriptada;

      if not Result then
      begin
        pMens := 'Nome de Usuário ou Senha incorretos';
        exit;
      end;
      }
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

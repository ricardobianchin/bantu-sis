unit Sis.Usuario.DBI_u;

interface

uses Sis.Usuario.DBI, Sis.DBI_u, Sis.Usuario, Sis.DB.DBTypes,
  Sis.ModuloSistema.Types;

type
  TUsuarioDBI = class(TDBI, IUsuarioDBI)
  private
    FUsuario: IUsuario;
  public
    function LoginTente(pNomeUsuDig: string; pSenhaDig: string;
      out pMens: string; pTipoModuloSistema: TTipoModuloSistema): boolean;

    constructor Create(pDBConnection: IDBConnection; pUsuario: IUsuario);
  end;

implementation

uses Sis.Types.strings.Crypt_u, Sis.Usuario.DBI.GetSQL_u, Data.DB,
  System.SysUtils;

{ TUsuarioDBI }

constructor TUsuarioDBI.Create(pDBConnection: IDBConnection;
  pUsuario: IUsuario);
begin
  inherited Create(pDBConnection);
  FUsuario := pUsuario;
end;

function TUsuarioDBI.LoginTente(pNomeUsuDig: string; pSenhaDig: string;
  out pMens: string; pTipoModuloSistema: TTipoModuloSistema): boolean;
var
  sSql: string;
  sSenhaDigEncriptada: string;
  q: TDataSet;
  iLojaId, iPessoaId: integer;
  sNomeCompleto, sApelido, sSenhaDBEncriptada, sSenhaDigitadaEncriptada: string;
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
    sSql := GetSQLUsuarioPeloNomeUsu(pNomeUsuDig);
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.IsEmpty;

    if not Result then
    begin
      q.Free;
      pMens := 'Nome de Usuário ou Senha incorretos';
      exit;
    end;

    CryVer := Word(q.FieldByName('CRY_VER').AsInteger);
    sSenhaDBEncriptada := q.FieldByName('SENHA').AsString.Trim;

    Encriptar(CryVer, pSenhaDig, sSenhaDigEncriptada);

    Result := sSenhaDBEncriptada = sSenhaDigEncriptada;

    if not Result then
    begin
      q.Free;
      pMens := 'Nome de Usuário ou Senha incorretos';
      exit;
    end;

    iLojaId := q.FieldByName('LOJA_ID').AsInteger;
    iPessoaId := q.FieldByName('PESSOA_ID').AsInteger;
    sNomeCompleto := q.FieldByName('NOME').AsString.Trim;
    sApelido := q.FieldByName('APELIDO').AsString.Trim;

    q.Free;

    sSql := GetSQLUsuarioAcessaModuloSistema(iLojaId, iPessoaId,
      pTipoModuloSistema);
    //sSql := 'SELECT ACESSA FROM USUARIO_PA.USUARIO_ACESSA_MODULO_GET(1, 2,''!'');';
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.IsEmpty;

    if not Result then
    begin
      q.Free;
      sTipoModuloSistema := TipoModuloSistemaToStr(pTipoModuloSistema);
      pMens := 'Usuário sem direitos para abrir o módulo '+sTipoModuloSistema;
      exit;
    end;

    Result := q.Fields[0].AsBoolean;
    q.Free;

    if not Result then
    begin
      sTipoModuloSistema := TipoModuloSistemaToStr(pTipoModuloSistema);
      pMens := 'Usuário sem direitos para abrir o módulo '+sTipoModuloSistema;
      exit;
    end;

    FUsuario.Pegar(iLojaId, 0, iPessoaId);
    FUsuario.NomeCompleto := sNomeCompleto;
    FUsuario.NomeExib := sApelido;
  finally
    DBConnection.Fechar;
  end;
end;

end.

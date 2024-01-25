unit Sis.Usuario.DBI_u;

interface

uses Sis.Usuario.DBI, Sis.DBI_u, Sis.Usuario, Sis.DB.DBTypes;

type
  TUsuarioDBI = class(TDBI, IUsuarioDBI)
  private
    FUsuario: IUsuario;
  public
    function LoginTente(pNomeUsuDig: string; pSenhaDig: string; out pMens: string): boolean;

    constructor Create(pDBConnection: IDBConnection; pUsuario: IUsuario);
  end;

implementation

uses Sis.Types.strings.Crypt_u, Sis.Usuario.DBI.GetSQL_u, Data.DB;

{ TUsuarioDBI }

constructor TUsuarioDBI.Create(pDBConnection: IDBConnection;
  pUsuario: IUsuario);
begin
  inherited Create(pDBConnection);
  FUsuario := pUsuario;
end;

function TUsuarioDBI.LoginTente(pNomeUsuDig: string; pSenhaDig: string; out pMens: string): boolean;
var
  sSql: string;
  sSenhaDigEncriptada: string;
  q: TDataSet;
begin
  sSql := GetSQLUsuarioPeloNomeUsu(pNomeUsuDig);
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.IsEmpty;
  finally
    DBConnection.Fechar;
  end;

  pMens := 'Erro conectando';
end;

end.

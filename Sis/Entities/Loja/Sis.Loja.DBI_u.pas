unit Sis.Loja.DBI_u;

interface

uses Sis.DBI_u, Sis.Loja.DBI, Sis.Loja, Sis.DB.DBTypes;

type
  TLojaDBI = class(TDBI, ILojaDBI)
  private
    FLoja: ILoja;
  public
    constructor Create(pLoja: ILoja; pDBConnection: IDBConnection);
    function Ler(out pMens: string): boolean;
  end;


implementation

uses Data.DB;

{ TLojaDBI }

constructor TLojaDBI.Create(pLoja: ILoja; pDBConnection: IDBConnection);
begin
  inherited Create(pDBConnection);
  FLoja := pLoja;
end;

function TLojaDBI.Ler(out pMens: string): boolean;
var
  sSql: string;
  q: TDataSet;
begin
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    sSql := 'SELECT LOJA_ID, APELIDO FROM LOJA_INICIAL_PA.ATIVO_GET';
    DBConnection.QueryDataSet(sSql, q);
    try
      FLoja.Id := q.Fields[0].AsInteger;
      FLoja.Descr := q.Fields[1].AsString;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.

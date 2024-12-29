unit Sis.Loja.DBI_u;

interface

uses Sis.DBI_u, Sis.Loja.DBI, Sis.Loja, Sis.DB.DBTypes;

type
  TSisLojaDBI = class(TDBI, ISisLojaDBI)
  private
    FLoja: ISisLoja;
  public
    constructor Create(pLoja: ISisLoja; pDBConnection: IDBConnection);
    function Ler(out pMens: string): boolean; virtual;
  end;


implementation

uses Data.DB;

{ TSisLojaDBI }

constructor TSisLojaDBI.Create(pLoja: ISisLoja; pDBConnection: IDBConnection);
begin
  inherited Create(pDBConnection);
  FLoja := pLoja;
end;

function TSisLojaDBI.Ler(out pMens: string): boolean;
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
    sSql := 'SELECT LOJA_ID, APELIDO FROM LOJA_INICIAL_PA.SELECIONADO_GET';
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

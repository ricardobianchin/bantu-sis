unit App.DB.Import.Form_Finalizar_ProdTipo_u;

interface

uses Sis.DB.DBTypes;

procedure GarantirProdTipo(pDBConnection: IDBConnection);

implementation

uses Data.DB, System.SysUtils;

procedure GarantirProdTipo(pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  iProdTipoId: integer;
  sProdTipoDescr: string;
begin
  sSql := 'SELECT PROD_TIPO_ID, DESCR FROM IMPORT_PROD_TIPO ORDER BY PROD_TIPO_ID;';

  pDBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      iProdTipoId := q.Fields[0].AsInteger;
      sProdTipoDescr := q.Fields[1].AsString;

      sSql := 'EXECUTE PROCEDURE PROD_TIPO_PA.GARANTIR(' + iProdTipoId.ToString
        + ', ' + QuotedStr(sProdTipoDescr) + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;
  finally
    q.Free;
  end;
end;

end.

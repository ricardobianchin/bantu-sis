unit App.DB.Import.Form_Finalizar_ProdTipo_u;

interface

uses Sis.DB.DBTypes, System.Classes;

procedure GarantirProdTipo(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);

implementation

uses Data.DB, System.SysUtils, System.Math;

procedure GarantirProdTipo(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);
var
  sSql: string;
  q: TDataSet;
  iId: integer;
  sProdTipoDescr: string;
  iMaiorId: integer;
begin
  sSql := 'SELECT PROD_TIPO_ID, DESCR FROM IMPORT_PROD_TIPO ORDER BY PROD_TIPO_ID;';

  pDBConnection.QueryDataSet(sSql, q);
  try
    iMaiorId := 0;
    while not q.Eof do
    begin
      iId := q.Fields[0].AsInteger;
      sProdTipoDescr := q.Fields[1].AsString;
      iMaiorId := Max( iMaiorId, iId);

      sSql := 'EXECUTE PROCEDURE PROD_TIPO_PA.GARANTIR(' + iId.ToString
        + ', ' + QuotedStr(sProdTipoDescr) + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;

    sSql := 'ALTER SEQUENCE PROD_TIPO_SEQ RESTART WITH '+(iMaiorId+1).ToString+';';
    pComandosPendentesSL.Add(sSql);
  finally
    q.Free;
  end;
end;

end.

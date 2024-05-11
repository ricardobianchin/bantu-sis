unit App.DB.Import.Form_Finalizar_ICMS_u;

interface

uses Sis.DB.DBTypes;

procedure GarantirICMS(pDBConnection: IDBConnection);

implementation

uses Data.DB, System.SysUtils;

procedure GarantirICMS(pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  iICMSId: integer;
  sICMSNome: string;
begin
  sSql := 'SELECT ICMS_ID, NOME FROM IMPORT_ICMS ORDER BY ICMS_ID;';
  pDBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      iICMSId := q.Fields[0].AsInteger;
      sICMSNome := q.Fields[1].AsString;

      sSql := 'EXECUTE PROCEDURE ICMS_PA.GARANTIR(' + iICMSId.ToString + ', ' +
        QuotedStr(sICMSNome) + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;
  finally
    q.Free;
  end;
end;

end.

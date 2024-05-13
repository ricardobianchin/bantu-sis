unit App.DB.Import.Form_Finalizar_Fabr_u;

interface

uses Sis.DB.DBTypes;

procedure GarantirFabr(pDBConnection: IDBConnection);

implementation

uses Data.DB, System.SysUtils;

procedure GarantirFabr(pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  iFabrId: integer;
  sFabrNome: string;
begin
  sSql := 'SELECT FABR_ID, NOME FROM IMPORT_FABR ORDER BY FABR_ID;';
  pDBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      iFabrId := q.Fields[0].AsInteger;
      sFabrNome := q.Fields[1].AsString;

      sSql := 'EXECUTE PROCEDURE FABR_PA.GARANTIR(' + iFabrId.ToString + ', ' +
        QuotedStr(sFabrNome) + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;
  finally
    q.Free;
  end;
end;

end.

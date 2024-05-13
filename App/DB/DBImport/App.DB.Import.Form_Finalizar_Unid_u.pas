unit App.DB.Import.Form_Finalizar_Unid_u;

interface

uses Sis.DB.DBTypes;

procedure GarantirUnid(pDBConnection: IDBConnection);

implementation

uses Data.DB, System.SysUtils;

function UnidSiglaToDescr(pUnidSigla: string): string;
begin
  if pUnidSigla = 'PC' then
    Result := 'PECAS'
  else
    Result := 'PECAS';
end;

procedure GarantirUnid(pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  iUnidId: integer;
  sUnidDescr: string;
  sUnidSigla: string;
begin
  sSql := 'SELECT UNID_ID, UNID_SIGLA FROM IMPORT_UNID;';
  pDBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      iUnidId := q.Fields[0].AsInteger;
      sUnidSigla := Trim(q.Fields[1].AsString);
      sUnidDescr := UnidSiglaToDescr(sUnidSigla);

      sSql := 'EXECUTE PROCEDURE UNID_PA.GARANTIR(' + iUnidId.ToString
        + ', ' + QuotedStr(sUnidDescr)
        + ', ' + QuotedStr(sUnidSigla)
        + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;
  finally
    q.Free;
  end;
end;

end.

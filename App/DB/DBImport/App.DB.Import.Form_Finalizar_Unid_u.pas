unit App.DB.Import.Form_Finalizar_Unid_u;

interface

uses Sis.DB.DBTypes, System.Classes;

procedure GarantirUnid(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);

implementation

uses Data.DB, System.SysUtils, System.Math;

function UnidSiglaToDescr(pUnidSigla: string): string;
begin
  if pUnidSigla = 'PC' then
    Result := 'PECAS'
  else
    Result := 'PECAS';
end;

procedure GarantirUnid(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);
var
  sSql: string;
  q: TDataSet;
  iId: integer;
  sUnidDescr: string;
  sUnidSigla: string;
  iMaiorId: integer;
begin
  sSql := 'SELECT UNID_ID, UNID_SIGLA FROM IMPORT_UNID;';
  pDBConnection.QueryDataSet(sSql, q);
  try
    iMaiorId := 0;
    while not q.Eof do
    begin
      iId := q.Fields[0].AsInteger;
      sUnidSigla := Trim(q.Fields[1].AsString);
      sUnidDescr := UnidSiglaToDescr(sUnidSigla);
      iMaiorId := Max( iMaiorId, iId);

      sSql := 'EXECUTE PROCEDURE UNID_PA.GARANTIR(' + iId.ToString
        + ', ' + QuotedStr(sUnidDescr)
        + ', ' + QuotedStr(sUnidSigla)
        + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;

    sSql := 'ALTER SEQUENCE UNID_SEQ RESTART WITH '+(iMaiorId+1).ToString+';';
    pComandosPendentesSL.Add(sSql);
  finally
    q.Free;
  end;
end;

end.

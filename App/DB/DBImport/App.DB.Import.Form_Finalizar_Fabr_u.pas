unit App.DB.Import.Form_Finalizar_Fabr_u;

interface

uses Sis.DB.DBTypes, System.Classes;

procedure GarantirFabr(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);

implementation

uses Data.DB, System.SysUtils, System.Math;

procedure GarantirFabr(pDBConnection: IDBConnection; pComandosPendentesSL: TStrings);
var
  sSql: string;
  q: TDataSet;
  iId: integer;
  sFabrNome: string;
  iMaiorId: integer;
begin
  sSql := 'SELECT FABR_ID, NOME FROM IMPORT_FABR ORDER BY FABR_ID;';
  pDBConnection.QueryDataSet(sSql, q);
  try
    iMaiorId := 0;
    while not q.Eof do
    begin
      iId := q.Fields[0].AsInteger;
      iMaiorId := Max( iMaiorId, iId);
      sFabrNome := q.Fields[1].AsString;

      sSql := 'EXECUTE PROCEDURE FABR_PA.GARANTIR(' + iId.ToString + ', ' +
        QuotedStr(sFabrNome) + ');';

      pDBConnection.ExecuteSQL(sSql);

      q.Next;
    end;

    sSql := 'ALTER SEQUENCE FABR_SEQ RESTART WITH '+(iMaiorId+1).ToString+';';
    pComandosPendentesSL.Add(sSql);
  finally
    q.Free;
  end;
end;

end.

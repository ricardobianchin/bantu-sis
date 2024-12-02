unit App.Retag.Aju.VersaoDB.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Ent.Ed, App.Retag.Aju.VersaoDB.Ent;

type
  TVersaoDBDBI = class(TEntDBI)
  private
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
  end;

implementation

uses System.SysUtils;

{ TVersaoDBDBI }

function TVersaoDBDBI.GetSqlForEach(pValues: variant): string;
var
  sBusca: string;
begin
  sBusca := vartostr(pValues);

  Result := 'SELECT NUM, CRIADO_EM, ASSUNTO, OBJETIVO, OBS' //
    + ' FROM DBUPDATE_PA.LISTA_GET(' + QuotedStr(sBusca) + ')' //
    + ' ORDER BY NUM DESC;' //
    ; //

  // SetClipboardText(Result);
end;

end.

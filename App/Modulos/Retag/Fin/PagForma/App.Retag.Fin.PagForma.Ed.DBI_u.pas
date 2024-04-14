unit App.Retag.Fin.PagForma.Ed.DBI_u;

interface

uses App.Retag.Fin.PagForma.Ed.DBI, Sis.DBI_u, App.Retag.Fin.PagForma.Ent,
  System.Classes, Sis.DB.DBTypes;

type
  TPagFormaEdDBI = class(TDBI, IPagFormaEdDBI)
  public
    function DescrsExistentesGet(pPagFormaIdExceto: smallint;
      pPagFormaTipoId: char; pDescr, pDescrRed: string;
      pResultSL: TStrings): boolean;
    constructor Create(pDBConnection: IDBConnection);
  end;

implementation

uses System.SysUtils, Data.DB;

{ TPagFormaEdDBI }

constructor TPagFormaEdDBI.Create(pDBConnection: IDBConnection);
begin
  inherited Create(pDBConnection);
end;

function TPagFormaEdDBI.DescrsExistentesGet(pPagFormaIdExceto: smallint;
  pPagFormaTipoId: char; pDescr, pDescrRed: string;
  pResultSL: TStrings): boolean;
var
  q: TDataSet;
  sSql: string;
  Id: integer;
  Descr: string;
  DescrRed: string;
  sLinha: string;
  sFormat: string;
begin
  Result := False;

  sFormat := 'SELECT PAGAMENTO_FORMA_ID_RET, DESCR_RET, DESCR_RED_RET' +
    ' FROM PAGAMENTO_FORMA_ED_PA.DESCRS_EXISTENTES_GET(' +
    ' %d, ''%s'', ''%s'', ''%s'');';

  sSql := Format(sFormat, [pPagFormaIdExceto, pPagFormaTipoId, pDescr,
    pDescrRed]);

  pResultSL.Clear;

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    while not q.Eof do
    begin
      Id := q.Fields[0].AsInteger;
      Descr := q.Fields[1].AsString.Trim;
      DescrRed := q.Fields[2].AsString.Trim;

      if Descr = pDescr then
      begin
        sLinha := '1' + Id.ToString + '-' + Descr;
        pResultSL.Add(sLinha);
      end;

      if DescrRed = pDescrRed then
      begin
        sLinha := '2' + Id.ToString + '-' + DescrRed;
        pResultSL.Add(sLinha);
      end;

      q.Next;
    end;
    Result := True;
  finally
    DBConnection.Fechar;
  end;
end;

end.

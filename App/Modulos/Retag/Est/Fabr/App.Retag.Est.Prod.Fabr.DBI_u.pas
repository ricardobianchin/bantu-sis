unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, App.Retag.Est.Prod.Fabr, Sis.DB.DBTypes, Data.DB,
  App.Retag.Est.Prod.Fabr.DBI;

type
  TProdFabrDBI = class(TDBI, IProdFabrDBI)
  private
    FProdFabr: IProdFabr;
  public
    procedure PreencherDataSet(var pDataSet: TDataSet; pStrBusca: string);
    constructor Create(pDBConnection: IDBConnection; pProdFabr: IProdFabr);
  end;

implementation

uses System.SysUtils;

{ TProdFabrDBI }

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pProdFabr: IProdFabr);
begin
  inherited Create(pDBConnection);
  FProdFabr := pProdFabr;
end;

procedure TProdFabrDBI.PreencherDataSet(var pDataSet: TDataSet;
  pStrBusca: string);
var
  sSql: string;
begin
  pDataSet.Open;
  pDataSet.DisableControls;
  DBConnection.Abrir;
  try
    sSql := 'select FABRICANTE_ID, NOME from FABRICANTE_PA.LISTA_GET('
      + QuotedStr(pStrBusca)
      + ');';
    DBConnection.QueryDataSet(sSql, pDataSet);
  finally
    DBConnection.Fechar;
    pDataSet.First;
    pDataSet.EnableControls;
  end;
end;

end.

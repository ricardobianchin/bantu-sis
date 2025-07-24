unit App.UI.Form.Est.Saldo.HistProd.DBI_u;

interface

uses App.UI.Form.Est.Saldo.HistProd.DBI, Sis.DBI_u, Sis.DB.DBTypes, App.AppObj;

type
  TEstSaldoHistProdFormDBI = class(TDBI, IEstSaldoHistProdFormDBI)
  private
    FAppObj: IAppObj;
  protected
    function GetSqlForEach(pValues: variant): string;
  public
    function GetNomeArqTabView(pValues: variant): string;
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj);
  end;

implementation

{ TEstSaldoHistProdFormDBI }

constructor TEstSaldoHistProdFormDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
end;

function TEstSaldoHistProdFormDBI.GetNomeArqTabView(pValues: variant): string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Saldo\tabview.est.saldo.hist.prod.csv';

  Result := sNomeArq;
end;

function TEstSaldoHistProdFormDBI.GetSqlForEach(pValues: variant): string;
begin

end;

end.

unit AppShop.PDV.Prod.ProdSelect.DBI_u;

interface

uses Sis.DBI_u, Sis.DB.DBTypes, App.AppObj;

type
  TShopProdSelectDBI = class(TDBI)
  private
    FAppObj: IAppObj;
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
    function GetNomeArqTabView(pValues: variant): string; override;
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj);
      reintroduce;
  end;

implementation

uses App.PDV.Preco.Utils, Sis.Types.strings_u, System.SysUtils;

{ TShopProdSelectDBI }
constructor TShopProdSelectDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
end;

function TShopProdSelectDBI.GetNomeArqTabView(pValues: variant): string;
begin
  var
    sNomeArq: string;
  begin
    sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
      'ShopApp\PDV\tabview.shopapp.pdv.prod.prodselect.csv';
    Result := sNomeArq;
  end;
end;

function TShopProdSelectDBI.GetSqlForEach(pValues: variant): string;
var
  sBusca: string;
  eBuscaTipo: TProdBuscaTipo;
  sWhere: string;
begin
  sBusca := VarToString(pValues[0]);
  eBuscaTipo := StrToProdBuscaTipo(sBusca);

  case eBuscaTipo of
    prodbusProdId:
      sWhere := 'PROD.PROD_ID = ' + sBusca;
    prodbusBarras:
      sWhere := 'PROD_BARRAS.COD_BARRAS = ' + QuotedStr(sBusca);
    prodbusDescr:
      sWhere := 'DESCR LIKE ' + QuotedStr('%' + sBusca + '%');
  end;

  Result := 'SELECT PROD.PROD_ID, PROD.DESCR, PROD.FABR_NOME'#13#10 //
    + ', PROD.PRECO, LIST(PROD_BARRAS.COD_BARRAS) BARRAS'#13#10 //
    + 'FROM PROD'#13#10 //
    + 'JOIN PROD_BARRAS ON'#13#10 //
    + 'PROD.PROD_ID = PROD_BARRAS.PROD_ID'#13#10 //
    + 'WHERE ' + sWhere + #13#10 //
    + 'GROUP BY PROD.PROD_ID, PROD.DESCR, PROD.FABR_NOME' //
    + ', PROD.PRECO'#13#10 //
    + 'ORDER BY PROD.DESCR' //
    ;
end;

end.

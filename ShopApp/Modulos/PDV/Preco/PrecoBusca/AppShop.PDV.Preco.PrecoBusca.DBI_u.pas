unit AppShop.PDV.Preco.PrecoBusca.DBI_u;

interface

uses Sis.DBI_u, Sis.DB.DBTypes, App.AppObj;

type
  TShopPrecoBuscaDBI = class(TDBI)
  private
    FAppObj: IAppObj;
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
    function GetNomeArqTabView(pValues: variant): string; override;
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj); reintroduce;
  end;

implementation

uses App.Prod.BuscaTipo_u, Sis.Types.strings_u, System.SysUtils;

{ TShopPrecoBuscaDBI }

constructor TShopPrecoBuscaDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
end;

function TShopPrecoBuscaDBI.GetNomeArqTabView(pValues: variant): string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'ShopApp\PDV\tabview.shopapp.pdv.preco.busca.csv';
  Result := sNomeArq;
end;

function TShopPrecoBuscaDBI.GetSqlForEach(pValues: variant): string;
var
  sBusca: string;
  eBuscaTipo: TProdBuscaTipo;
begin
  sBusca := VarToString(pValues[0]);
  eBuscaTipo := StrToProdBuscaTipo(sBusca);

  case eBuscaTipo of
    prodbusProdId:
    begin
       Result := 'SELECT PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID,' //
        +'PROD.FABR_NOME, PROD.PRECO, LIST(PROD_BARRAS.COD_BARRAS) BARRAS'#13#10 //
        + 'FROM PROD'#13#10 //
        + 'JOIN PROD_BARRAS ON'#13#10 //
        + 'PROD.PROD_ID = PROD_BARRAS.PROD_ID'#13#10 //
        + 'WHERE PROD.PROD_ID = ' + sBusca + #13#10 //
        + 'GROUP BY PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID, PROD.FABR_NOME' //
        + ', PROD.PRECO'#13#10 //
        + 'ORDER BY PROD.DESCR' //
        ;
    end;
    prodbusBarras:
    begin
       Result := 'SELECT PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID,' //
        +'PROD.FABR_NOME, PROD.PRECO, LIST(PROD_BARRAS.COD_BARRAS) BARRAS'#13#10 //
        + 'FROM PROD'#13#10 //
        + 'JOIN PROD_BARRAS ON'#13#10 //
        + 'PROD.PROD_ID = PROD_BARRAS.PROD_ID'#13#10 //
        + 'WHERE PROD_BARRAS.COD_BARRAS = ''' + sBusca+''''#13#10 //
        + 'GROUP BY PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID, PROD.FABR_NOME' //
        + ', PROD.PRECO'#13#10 //
        + 'ORDER BY PROD.DESCR' //
        ;
    end;
    prodbusDescr:
    begin
       Result := 'SELECT PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID,' //
        +'PROD.FABR_NOME, PROD.PRECO, LIST(PROD_BARRAS.COD_BARRAS) BARRAS'#13#10 //
        + 'FROM PROD'#13#10 //
        + 'JOIN PROD_BARRAS ON'#13#10 //
        + 'PROD.PROD_ID = PROD_BARRAS.PROD_ID'#13#10 //
        + 'WHERE DESCR LIKE ''%' + sBusca+'%'''#13#10 //
        + 'GROUP BY PROD.PROD_ID, PROD.DESCR, PROD.FABR_ID, PROD.FABR_NOME' //
        + ', PROD.PRECO'#13#10 //
        + 'ORDER BY PROD.DESCR' //
        ;
    end;
  end;
end;

end.

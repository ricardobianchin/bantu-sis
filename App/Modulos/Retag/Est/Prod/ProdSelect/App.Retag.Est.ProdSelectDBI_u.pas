unit App.Retag.Est.ProdSelectDBI_u;

interface

uses Sis.DBI_u, Sis.DB.DBTypes, App.AppObj;

type
  TProdSelectDBI = class(TDBI)
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

uses App.PDV.Preco.Utils, Sis.Types.strings_u, System.SysUtils, Sis.Win.Utils_u;

{ TProdSelectDBI }

constructor TProdSelectDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
end;

function TProdSelectDBI.GetNomeArqTabView(pValues: variant): string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\tabview.est.prod.prodselect.csv';

  Result := sNomeArq;
end;

function TProdSelectDBI.GetSqlForEach(pValues: variant): string;
var
  sBusca: string;
  eBuscaTipo: TProdBuscaTipo;
  sWhere: string;
begin
  sBusca := VarToString(pValues[0]);
  eBuscaTipo := StrToProdBuscaTipo(sBusca);

  case eBuscaTipo of
    prodbusProdId:
      sWhere := 'P.PROD_ID = ' + sBusca;
    prodbusBarras:
      sWhere := 'B.COD_BARRAS = ' + QuotedStr(sBusca);
    prodbusDescr:
      sWhere := 'P.DESCR_RED LIKE ' + QuotedStr('%' + sBusca + '%');
  end;

  Result :=
    'SELECT P.PROD_ID, P.DESCR_RED, F.NOME,'#13#10 //
    +'C.BALANCA_EXIGE,'#13#10 //
    //+'PR.PRECO,'#13#10 //
    +'LIST(B.COD_BARRAS) BARRAS'#13#10 //

    +'FROM AMBIENTE_SIS A'#13#10 //

    +'JOIN PROD_COMPL C ON'#13#10 //
    +'A.LOJA_ID = C.LOJA_ID'#13#10 //

    //+'JOIN PROD_PRECO PR ON'#13#10 //
    //+'A.LOJA_ID = PR.LOJA_ID'#13#10 //

    +'JOIN PROD P ON'#13#10 //
    +'P.PROD_ID = C.PROD_ID'#13#10 //

    +'JOIN FABR F ON'#13#10 //
    +'F.FABR_ID = P.FABR_ID'#13#10 //

    +'LEFT JOIN PROD_BARRAS B ON'#13#10 //
    +'P.PROD_ID = B.PROD_ID'#13#10 //

    + 'WHERE ' + sWhere + #13#10 //
    + 'GROUP BY P.PROD_ID, P.DESCR_RED, F.NOME, C.BALANCA_EXIGE'#13#10 //
//    + ', PR.PRECO'#13#10 //
    +'ORDER BY P.DESCR_RED'#13#10 //
    ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.

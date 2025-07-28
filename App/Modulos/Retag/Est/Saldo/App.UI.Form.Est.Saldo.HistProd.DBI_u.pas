unit App.UI.Form.Est.Saldo.HistProd.DBI_u;

interface

uses App.UI.Form.Est.Saldo.HistProd.DBI, Sis.DBI_u, Sis.DB.DBTypes, App.AppObj,
  Sis.Types, Sis.Entities.Types;

type
  TEstSaldoHistProdFormDBI = class(TDBI, IEstSaldoHistProdFormDBI)
  private
    FAppObj: IAppObj;
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
    function GetNomeArqTabView(pValues: variant): string; override;
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj);
  end;

implementation

{ TEstSaldoHistProdFormDBI }

constructor TEstSaldoHistProdFormDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj);
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
var
  iLojaId: TLojaId;
  iProdId: TId;
begin
  iLojaId := pValues[0];
  iProdId := pValues[1];

  Result := 'SELECT'#13#10 //
    + 'FINALIZADO_EM'#13#10 // 0
    + ', PREFIXO'#13#10 // 1
    + ', LOJA_ID_RET'#13#10 // 2
    + ', TERMINAL_ID'#13#10 // 3
    + ', EST_MOV_ID'#13#10 // 4
    + ', ORDEM'#13#10 // 5
    + ', DOC_ID'#13#10 // 6
    + ', COD'#13#10 // 7
    + ', EST_MOV_TIPO_ID'#13#10 // 8
    + ', EST_MOV_TIPO_DESCR'#13#10 // 9
    + ', QTD'#13#10 // 10

    + 'FROM EST_SALDO_HIST_PROD_PA.HIST_GET(' //
    + iLojaId.ToString //
    + ', ' + iProdId.ToString //
    + ');';
end;

end.

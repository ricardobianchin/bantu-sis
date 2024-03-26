unit App.Est.Prod.Barras.GetSQL_u;

interface

function GetSQLBarrasExisteFormat: string;

implementation

function GetSQLBarrasExisteFormat: string;
begin
  Result := 'SELECT PROD_ID_RET'
    + ' FROM PROD_BARRAS_PA.BY_COD_BARRAS_GET(%s,%d);'
    ;
end;

end.

unit App.Est.EstPromoItem.DBI_u;

interface

uses Sis.DBI_u, App.Est.PromoItem;

type
  TEstPromoItemDBI = class(TDBI)
  private
  protected
    function GetSqlForEach(pValues: Variant): string; override;
  public

  end;

implementation

uses Sis.Entities.Types, Sis.Types, System.SysUtils, Sis.Win.Utils_u;

{ TEstPromoItemDBI }

function TEstPromoItemDBI.GetSqlForEach(pValues: Variant): string;
var
  iLojaId: TLojaId;
  iPromoId: integer;
begin
  iLojaId := pValues[0];
  iPromoId := pValues[1];

  Result := //
    'WITH PIT AS'#13#10 //
    + '('#13#10 //
    + '  SELECT PROD_ID, LOJA_ID, PROMO_ID,'#13#10 //
    + '    ATIVO, PRECO_PROMO, TERMINAL_ID, LOG_ID'#13#10 //
    + '  FROM PROMO_ITEM'#13#10 //
    + '), P AS ('#13#10 //
    + '  SELECT PROD_ID, DESCR_RED, FABR_ID'#13#10 //
    + '  FROM PROD'#13#10 //
    + ')'#13#10 //
    + 'SELECT'#13#10 //
    + '  P.PROD_ID,'#13#10 // 1
    + '  P.DESCR_RED,'#13#10 // 2
    + '  FA.NOME FABR_NOME,'#13#10 // 3
    + '  PIT.PRECO_PROMO,'#13#10 // 4
    + '  PIT.ATIVO'#13#10 // 5

    + 'FROM PIT'#13#10 //

    + 'JOIN P ON'#13#10 //
    + '  P.PROD_ID = PIT.PROD_ID'#13#10 //

    + 'JOIN FABR FA ON'#13#10 //
    + '  FA.FABR_ID  = P.FABR_ID'#13#10 //

    + 'ORDER BY'#13#10 //
    + '  PIT.PROD_ID'#13#10 //
    ;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.

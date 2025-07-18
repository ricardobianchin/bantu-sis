unit App.Retag.Est.VendaItem.DBI_u;

interface

uses Sis.DBI_u;

type
  TRetagVendaItemDBI = class(TDBI)
  private
  protected
    function GetSqlForEach(pValues: Variant): string; override;
  public

  end;

implementation

uses Sis.Entities.Types, Sis.Types, System.SysUtils, Sis.Win.Utils_u;

{ TRetagVendaItemDBI }

function TRetagVendaItemDBI.GetSqlForEach(pValues: Variant): string;
var
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEtMovId: Int64;
begin
  iLojaId := pValues[0];
  iTerminalId := pValues[1];
  iEtMovId := pValues[2];

  Result := //
    'SELECT'#13#10 //
    +'ORDEM,'#13#10 //
    +'PROD_ID,'#13#10 //
    +'DESCR_RED,'#13#10 //
    +'FABR_NOME,'#13#10 //
    +'UNID_SIGLA,'#13#10 //
    +'QTD,'#13#10 //
    +'PRECO_UNIT,'#13#10 //
    +'PRECO,'#13#10 //
    +'CANCELADO'#13#10 //

    +'FROM RETAG_VENDA_PA.VENDA_ITEM_LISTA_GET(' //
    + iLojaId.ToString
    + ', '+iTerminalId.ToString
    + ', '+iEtMovId.ToString
    + ');'#13#10;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.

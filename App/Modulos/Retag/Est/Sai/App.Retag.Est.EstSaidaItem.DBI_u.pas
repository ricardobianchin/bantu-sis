unit App.Retag.Est.EstSaidaItem.DBI_u;

interface

uses App.Retag.Est.EstSaidaItem, Sis.DBI_u;

type
  TEstSaidaItemDBI = class(TDBI)
  private
  protected
    function GetSqlForEach(pValues: Variant): string; override;

  public

  end;

implementation

uses Sis.Entities.Types, Sis.Types, System.SysUtils;

{ TEstSaidaItemDBI }

function TEstSaidaItemDBI.GetSqlForEach(pValues: Variant): string;
var
  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEtMovId: Int64;
begin
  iLojaId := pValues[0];
  iTerminalId := pValues[1];
  iEtMovId := pValues[2];

  Result := //
    'WITH EIT AS'#13#10 //
    + '('#13#10 //
    + '  SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID'#13#10 //
    + '    ORDEM, PROD_ID, QTD, CANCELADO'#13#10 //
    + '  FROM EST_MOV_ITEM'#13#10 //
    + '  WHERE LOJA_ID = ' + iLojaId.ToString + #13#10 //
    + '  AND TERMINAL_ID = ' + iTerminalId.ToString + #13#10 //
    + '  AND EST_MOV_ID = ' + iEtMovId.ToString + #13#10 //
    + '), P AS ('#13#10 //
    + '  SELECT PROD_ID, DESCR_RED, FABR_ID, UNID_ID'#13#10 //
    + '  FROM PROD'#13#10 //
    + ')'#13#10 //
    + 'SELECT'#13#10 //
    + '  EIT.ORDEM + 1 EORDEM,'#13#10 //0
    + '  P.PROD_ID,'#13#10 //1
    + '  P.DESCR_RED,'#13#10 //2
    + '  FA.NOME FABR_NOME,'#13#10 //3
    + '  U.SIGLA UNID_SIGLA,'#13#10 //4
    + '  EIT.QTD,'#13#10 //5
    + '  EIT.CANCELADO'#13#10 //6

    + 'FROM EIT'#13#10 //

    + 'JOIN P ON'#13#10 //
    + '  P.PROD_ID = EIT.PROD_ID'#13#10 //

    + 'JOIN FABR FA ON'#13#10 //
    + '  FA.FABR_ID  = P.FABR_ID'#13#10 //

    + 'JOIN UNID U ON'#13#10 //
    + '  U.UNID_ID = P.UNID_ID'#13#10 //
    ;
end;

end.

unit App.Retag.Est.EntradaItem.DBI_u;

interface

uses Sis.DBI_u;

type
  TEntradaItemDBI = class(TDBI)
  private
  protected
    function GetSqlForEach(pValues: Variant): string; override;
  public

  end;

implementation

uses Sis.Entities.Types, Sis.Types, System.SysUtils, Sis.Win.Utils_u;

{ TEntradaItemDBI }

function TEntradaItemDBI.GetSqlForEach(pValues: Variant): string;
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
    + '('#13#10 // est mov item
    + '  SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID, '#13#10 //
    + '    ORDEM, PROD_ID, QTD, CANCELADO, CRIADO_EM'#13#10 //
    + '  FROM EST_MOV_ITEM'#13#10 //
    + '  WHERE LOJA_ID = ' + iLojaId.ToString + #13#10 //
    + '  AND TERMINAL_ID = ' + iTerminalId.ToString + #13#10 //
    + '  AND EST_MOV_ID = ' + iEtMovId.ToString + #13#10 //

    + '), ENIT AS('#13#10 //
    + '  SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID,'#13#10 //
    + '    ORDEM, NITEM, PROD_ID_DELES, CUSTO, MARGEM, PRECO'#13#10 //
    + '  FROM ENTRADA_ITEM'#13#10 //
    + '  WHERE LOJA_ID = ' + iLojaId.ToString + #13#10 //
    + '  AND TERMINAL_ID = ' + iTerminalId.ToString + #13#10 //
    + '  AND EST_MOV_ID = ' + iEtMovId.ToString + #13#10 //

    + '), P AS ('#13#10 // prod
    + '  SELECT PROD_ID, DESCR_RED, FABR_ID, UNID_ID'#13#10 //
    + '  FROM PROD'#13#10 //
    + ')'#13#10 //

    + 'SELECT'#13#10 //
    + '  EIT.ORDEM + 1 EORDEM,'#13#10 // 0
    + '  ENIT.NITEM,'#13#10 // 1
    + '  ENIT.PROD_ID_DELES,'#13#10 // 2
    + '  P.PROD_ID,'#13#10 // 3
    + '  P.DESCR_RED,'#13#10 // 4
    + '  FA.NOME FABR_NOME,'#13#10 // 5
    + '  U.SIGLA UNID_SIGLA,'#13#10 // 6
    + '  EIT.QTD,'#13#10 // 7
    + '  ENIT.CUSTO,'#13#10 // 8
    + '  ENIT.MARGEM,'#13#10 // 9
    + '  ENIT.PRECO,'#13#10 // 10
    + '  EIT.CANCELADO,'#13#10 // 11
    + '  EIT.CRIADO_EM'#13#10 // 12

    + 'FROM EIT'#13#10 //

    + 'JOIN ENIT ON'#13#10 //
    + 'EIT.LOJA_ID = ENIT.LOJA_ID'#13#10 //
    + 'AND EIT.TERMINAL_ID = ENIT.TERMINAL_ID'#13#10 //
    + 'AND EIT.EST_MOV_ID = ENIT.EST_MOV_ID'#13#10 //
    + 'AND EIT.ORDEM = ENIT.ORDEM'#13#10 //

    + 'JOIN P ON'#13#10 //
    + '  P.PROD_ID = EIT.PROD_ID'#13#10 //

    + 'JOIN FABR FA ON'#13#10 //
    + '  FA.FABR_ID  = P.FABR_ID'#13#10 //

    + 'JOIN UNID U ON'#13#10 //
    + '  U.UNID_ID = P.UNID_ID'#13#10 //

    + 'ORDER BY EIT.ORDEM '#13#10 //
    ;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.

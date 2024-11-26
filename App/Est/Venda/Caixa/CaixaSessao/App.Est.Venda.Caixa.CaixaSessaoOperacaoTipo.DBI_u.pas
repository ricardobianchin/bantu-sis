unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI_u;

interface

uses Sis.DBI_u, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List, Sis.DB.DBTypes
  ;

type
  TCxOperacaoTipoDBI = class(TDBI, ICxOperacaoTipoDBI)
  private
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
  end;

implementation

uses Sis.Win.Utils_u;

{ TCxOperacaoTipoDBI }

function TCxOperacaoTipoDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT' //

    +' OPER_TIPO_ID' // 0
    +', NAME' // 1
    +', CAPTION' // 2
    +', HINT' // 3
    +', SINAL_NUMERICO' // 4
    +', HABILITADO_DURANTE_SESSAO' // 5

    +' FROM CAIXA_SESSAO_OPERACAO_TIPO' //
    +' WHERE ORDEM_EXIB IS NOT NULL' //
    +' ORDER BY ORDEM_EXIB' //
    ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.

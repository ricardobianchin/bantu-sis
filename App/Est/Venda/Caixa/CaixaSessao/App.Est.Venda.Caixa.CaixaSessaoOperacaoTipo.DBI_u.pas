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

{ TCxOperacaoTipoDBI }

{ TCxOperacaoTipoDBI }

function TCxOperacaoTipoDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT CAIXA_SESSAO_OPERACAO_TIPO_ID, CAPTION'
    +', HABILITADO_DURANTE_SESSAO'
    +' FROM CAIXA_SESSAO_OPERACAO_TIPO'
    +' WHERE ORDEM_EXIB IS NOT NULL'
    +' ORDER BY ORDEM_EXIB'
    ;
end;

end.

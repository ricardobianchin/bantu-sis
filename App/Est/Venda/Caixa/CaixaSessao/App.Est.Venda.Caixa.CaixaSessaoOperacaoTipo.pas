unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

interface

uses Sis.Lists.HashItem;

type
  ICxOperacaoTipo = interface(IHashItem)
    ['{E6FDCE32-E81A-4EDB-ACC1-0A5EC8EFA4E8}']

    //descr armazenará caption. name nao será trazido
    function GetHabilitado: Boolean;
    procedure SetHabilitado(Value: Boolean);
    property Habilitado: Boolean read GetHabilitado write SetHabilitado;
  end;
{

CAIXA_SESSAO_OPERACAO_TIPO_ID;ID_CHAR_DOM;S;S
NAME;NOME_INTERM_DOM;S;N;S
CAPTION;NOME_INTERM_DOM;S;N;S
HABILITADO_DURANTE_SESSAO;BOOLEAN;S

CAIXA_SESSAO_OPERACAO_TIPO_ID;NAME;CAPTION;HABILITADO_DURANTE_SESSAO
#033;ABERTURA;Abrir;FALSE
#034;SUPRIMENTO;Suprimento;TRUE
#035;SANGRIA;Sangria;TRUE
#036;DESPESA;Despesa, Pag;TRUE
#037;VALE;Vale para Funcionario;TRUE
#038;VENDA;Venda;TRUE
#039;DEVOLUCAO;Devolu#231#227o;TRUE
#040;CONVENIO;Conv#234nio, Baixa;TRUE
#041;CREDIARIO;Credi#225rio, Baixa;TRUE
#042;FECHAMENTO;Fechamento;TRUE

}
implementation

end.

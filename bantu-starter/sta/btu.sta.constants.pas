unit btu.sta.constants;

interface

uses btu.lib.types.constants;

const
  MSG_ERRO_WINVERSION = 'Erro detectando a versao do Windows';

  RESPTEC_DESCR =
    'O responsável técnico é quem vai cadastrar os terminais,'+ sNOVALIN +
    'usuários, incluindo da gerência, configurar impressoras...'+ sNOVALIN +
    'mas não terá direitos de visualizar informações'+ sNOVALIN +
    'críticas da empresa, como do RH ou Financeiro'
    ;

  LOJAID_DESCR =
    'O código da loja é um número que a identifica. Geralmente 1.'+ sNOVALIN +
    'No caso de rede de lojas, atribui-se um código diferente para cada loja.'+ sNOVALIN +
    sNOVALIN +
    'O apelido é um nome que identifica a loja na tela' + sNOVALIN +
    'e diferencia uma loja da outra' + sNOVALIN +
    'Não necessariamente a Razão Social nem o Nome Fantasia.' + sNOVALIN +
    'Por exemplo, a cidade ou bairro onde a loja se localiza,' + sNOVALIN +
    'se a loja é a principal ou a outlet...'
    ;

implementation

end.

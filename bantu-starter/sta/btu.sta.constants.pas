unit btu.sta.constants;

interface

uses btu.lib.types.constants;

const
  MSG_ERRO_WINVERSION = 'Erro detectando a versao do Windows';

  RESPTEC_DESCR =
    'O respons�vel t�cnico � quem vai cadastrar os terminais,'+ sNOVALIN +
    'usu�rios, incluindo da ger�ncia, configurar impressoras...'+ sNOVALIN +
    'mas n�o ter� direitos de visualizar informa��es'+ sNOVALIN +
    'cr�ticas da empresa, como do RH ou Financeiro'
    ;

  LOJAID_DESCR =
    'O c�digo da loja � um n�mero que a identifica. Geralmente 1.'+ sNOVALIN +
    'No caso de rede de lojas, atribui-se um c�digo diferente para cada loja.'+ sNOVALIN +
    sNOVALIN +
    'O apelido � um nome que identifica a loja na tela' + sNOVALIN +
    'e diferencia uma loja da outra' + sNOVALIN +
    'N�o necessariamente a Raz�o Social nem o Nome Fantasia.' + sNOVALIN +
    'Por exemplo, a cidade ou bairro onde a loja se localiza,' + sNOVALIN +
    'se a loja � a principal ou a outlet...'
    ;

implementation

end.

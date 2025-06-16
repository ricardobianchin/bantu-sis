unit App.Constants;

interface

type
  TSessaoIndex = Cardinal;
  TTabSheetIndex = Cardinal;

const
  SESSAO_INDEX_INVALIDO = TSessaoIndex(-1);// High(TSessaoIndex)//-1;
  SYNC_QTD_REGS = 50000;
  COD_BARRAS_LEN_MINIMO = 8;
  PROD_ID_MAX_LEN = COD_BARRAS_LEN_MINIMO - 1;

  ASSIST_NOME_ARQ_TERMINAR = 'Assist_precisa_fechar.txt';


implementation

end.

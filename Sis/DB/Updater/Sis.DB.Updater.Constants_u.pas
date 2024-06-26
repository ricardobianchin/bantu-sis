unit Sis.DB.Updater.Constants_u;

interface

const
  FB_MAX_IDENTIFIER_LENGHT = 31;

  DBATUALIZ_INI_CHAVE = 'DBATUALIZ INI';
  DBATUALIZ_FIM_CHAVE = 'DBATUALIZ FIM';
  NOMETAB_DBUPDATE_HIST = 'DBUPDATE_HIST';

  DBATUALIZ_ASSUNTO_CHAVE = 'DBATUALIZ_ASSUNTO';
  DBATUALIZ_OBJETIVO_CHAVE = 'DBATUALIZ_OBJETIVO';
  DBATUALIZ_OBS_CHAVE = 'DBATUALIZ_OBS';

  DBATUALIZ_COMANDO_INI_CHAVE = 'COMANDO INI';
  DBATUALIZ_COMANDO_FIM_CHAVE = 'COMANDO FIM';
  DBATUALIZ_TIPO_COMANDO = 'TIPO_COMANDO';
  DBATUALIZ_OBJETO_NOME_CHAVE = 'OBJETO_NOME';

  DBATUALIZ_TIPO_COMANDO_CREATE_TABLE = 'CREATE TABLE';
  DBATUALIZ_COLUNAS_INI_CHAVE = 'COLUNAS INI';
  DBATUALIZ_COLUNAS_FIM_CHAVE = 'COLUNAS FIM';

  PKINDEXNAME_SUFIXO = '_PK';

  DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PROCEDURE = 'CREATE OR ALTER PROCEDURE';
  SYNTAX_FIREBIRD_INI = '```FIREBIRD';
  SYNTAX_FIM = '```';

  DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PACKAGE = 'CREATE OR ALTER PACKAGE';
  DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS = 'CREATE DOMAINS';

  DBATUALIZ_TIPO_COMANDO_ENSURE_RECORDS = 'ENSURE RECORDS';

  DBATUALIZ_CSV_INI_CHAVE = 'CSV INI';
  DBATUALIZ_CSV_FIM_CHAVE = 'CSV FIM';

  DBATUALIZ_TIPO_COMANDO_CREATE_SEQUENCE = 'CREATE SEQUENCE';
  DBATUALIZ_VALOR_INICIAL_CHAVE = 'VALOR_INICIAL';

  DBATUALIZ_TIPO_COMANDO_CREATE_FOREIGN_KEY = 'CREATE FOREIGN KEY';
  DBATUALIZ_TABELA_FK_CHAVE  = 'TABELA_FK';
  DBATUALIZ_CAMPOS_FK_CHAVE = 'CAMPOS_FK';
  DBATUALIZ_TABELA_PK_CHAVE  = 'TABELA_PK';
  DBATUALIZ_CAMPOS_PK_CHAVE = 'CAMPOS_PK';

  DBATUALIZ_TABELA_CHAVE  = 'TABELA';
  DBATUALIZ_CAMPOS_CHAVE  = 'CAMPOS';

  UKINDEXNAME_SUFIXO = '_UK';
  DBATUALIZ_TIPO_COMANDO_CREATE_UNIQUE_KEY = 'CREATE UNIQUE KEY';

  INDEXNAME_SUFIXO = '_I';
  DBATUALIZ_TIPO_COMANDO_CREATE_INDEX = 'CREATE INDEX';

implementation

end.

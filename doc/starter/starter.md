unit btu.lib.db.updater_u
implementa a interface IDBUpdater

possui uma FComandoList: IComandoList; que vai conter os comandos do arquivo txt atual

## function Execute: boolean;
faz um loop, cada volta sendo para um arquivo de dbupdate
a cada volta do loop chama subrotinas pra tratar o arquivo atual
inicialmente preenche uma comandoList com os comandos do arquivo atual
a seguir, as procedures que sao chamadas pela execute

### procedure ComandosTesteFuncionou;
percorre cada comando da FComandoList e chama `Resultado := oComando.Funcionou;`, que consulta o banco de dados pra ver se funcionou

se um dos comandos nao funcionou, levanta uma exception

### procedure GravarVersao;
se chegou em GravarVersao é pq nao teve exceptions na `ComandosTesteFuncionou`

no caso de primeira instalacao, o banco de dados está completamente zerado
nao terá a stored procedure `DBUPDATE_HIST_INS`. entao, no inicio da primeira volta do loop, nao pode ser feita a DBExec.Prepare. 
Por isto, antes de gravar, vai testar se ja foi prepared. se nao foi, prepara
é uma exceção à regra que vai pre
FComandoList

PRECISA TER QUERY PREPAREDA
CRIAR PACKAGE




Você criou um pacote chamado DBUPDATE que contém uma função chamada DBUPDATE_VERSAO_GET. Essa função retorna o valor máximo da coluna NUM da tabela DBUPDATE_HIST, ou -1 se essa coluna for nula. Para usar essa função, você precisa primeiro criar o corpo do pacote com o comando CREATE PACKAGE BODY¹. Depois, você pode chamar a função em uma consulta SQL, por exemplo:

```
SELECT DBUPDATE.DBUPDATE_VERSAO_GET() FROM RDB$DATABASE;
```

Isso retornará o valor da função para o banco de dados atual. Você também pode usar a função em outras rotinas do pacote, como procedimentos ou triggers. Para mais informações sobre como criar e usar pacotes no Firebird, consulte a documentação oficial² ou este tutorial³. Espero que isso seja útil para você. 😊

Source: Conversation with Bing, 9/28/2023
(1) Packages - Firebird. https://www.firebirdsql.org/file/documentation/release_notes/html/en/3_0/rnfb30-psql-packages.html.
(2) Firebird: Third-party Tools & Drivers. https://www.firebirdsql.org/en/third-party-tools/.
(3) Firebird: About Firebird. http://firebirdsql.org/en/about-firebird/.
(4) the database experts Doc/Firebird 3.0 packages. http://www.ibexpert.net/ibe/index.php?n=Doc.Firebird30Packages.




Você adicionou um procedimento chamado DBUPDATE_HIST_INS ao seu pacote DBUPDATE. Esse procedimento recebe quatro parâmetros: NUM, OBJETIVO, DTH e OBS, que são usados para inserir um registro na tabela DBUPDATE_HIST. Para usar esse procedimento, você precisa primeiro criar o corpo do pacote com o comando CREATE PACKAGE BODY¹. Depois, você pode chamar o procedimento em uma consulta SQL, por exemplo:

```
EXECUTE PROCEDURE DBUPDATE.DBUPDATE_HIST_INS(1, 'Atualizar a versão do banco de dados', CURRENT_TIMESTAMP, 'Sem problemas');
```

Isso irá inserir um registro na tabela DBUPDATE_HIST com os valores fornecidos. Você também pode usar o procedimento em outras rotinas do pacote, como funções ou triggers. Para mais informações sobre como criar e usar procedimentos em pacotes no Firebird, consulte a documentação oficial² ou este tutorial³. Espero que isso seja útil para você. 😊

Source: Conversation with Bing, 9/28/2023
(1) Packages - Firebird. https://www.firebirdsql.org/file/documentation/release_notes/html/en/3_0/rnfb30-psql-packages.html.
(2) 7.5 Packages - firebirdsql.org. https://firebirdsql.org/file/documentation/chunk/en/refdocs/fblangref40/fblangref40-psql-package.html.
(3) Pontiac Firebird Body Kits - Andy's Auto Sport. https://www.andysautosport.com/body_kits/pontiac_firebird.html.




Para verificar se o pacote DBUPDATE foi criado, você pode usar a seguinte consulta SQL:

```
SELECT 1 FROM RDB$PACKAGES WHERE RDB$PACKAGE_NAME = 'DBUPDATE';
```

Se essa consulta retornar um valor, significa que o pacote existe. Caso contrário, significa que o pacote não existe ou não foi criado ainda.

Para verificar se a função DBUPDATE_VERSAO_GET existe no pacote DBUPDATE, você pode usar a seguinte consulta SQL:

```
SELECT 1 FROM RDB$FUNCTIONS WHERE RDB$FUNCTION_NAME = 'DBUPDATE_VERSAO_GET' AND RDB$PACKAGE_NAME = 'DBUPDATE';
```

Se essa consulta retornar um valor, significa que a função existe no pacote. Caso contrário, significa que a função não existe ou não foi criada ainda.

Para verificar se o procedimento DBUPDATE_HIST_INS existe no pacote DBUPDATE, você pode usar a seguinte consulta SQL:

```
SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = 'DBUPDATE_HIST_INS' AND RDB$PACKAGE_NAME = 'DBUPDATE';
```

Se essa consulta retornar um valor, significa que o procedimento existe no pacote. Caso contrário, significa que o procedimento não existe ou não foi criado ainda.

Espero que isso seja útil para você. 😊

Source: Conversation with Bing, 9/28/2023
(1) Firebird and stored procedures: if exists then else. https://stackoverflow.com/questions/20844485/firebird-and-stored-procedures-if-exists-then-else.
(2) firebird - Using exists in sql query - Stack Overflow. https://stackoverflow.com/questions/70336075/using-exists-in-sql-query.
(3) c# - Check if remote firebird backup file exists - Stack Overflow. https://stackoverflow.com/questions/54234031/check-if-remote-firebird-backup-file-exists.
(4) 5.9 FUNCTION - Firebird. https://firebirdsql.org/file/documentation/chunk/en/refdocs/fblangref40/fblangref40-ddl-function.html.
(5) Packages - Firebird. https://www.firebirdsql.org/file/documentation/release_notes/html/en/3_0/rnfb30-psql-packages.html.
(6) Check if given table or stored procedure exists in Firebird. https://www.sanjaysingh.net/2010/12/check-if-given-table-or-stored.html.





Sim, você pode usar outras consultas para verificar a existência do pacote e das rotinas no Firebird. Por exemplo, você pode usar a tabela RDB$PACKAGE_BODIES para verificar se o pacote tem um corpo definido¹. Você também pode usar as tabelas RDB$FUNCTIONS e RDB$PROCEDURES para verificar se as rotinas existem no pacote, sem especificar o nome do pacote. Aqui estão alguns exemplos de consultas alternativas:

- Para verificar se o pacote DBUPDATE tem um corpo definido:

```
SELECT 1 FROM RDB$PACKAGE_BODIES WHERE RDB$PACKAGE_NAME = 'DBUPDATE';
```

- Para verificar se a função DBUPDATE_VERSAO_GET existe, independente do pacote:

```
SELECT 1 FROM RDB$FUNCTIONS WHERE RDB$FUNCTION_NAME = 'DBUPDATE_VERSAO_GET';
```

- Para verificar se o procedimento DBUPDATE_HIST_INS existe, independente do pacote:

```
SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = 'DBUPDATE_HIST_INS';
```

Você também pode usar consultas que não envolvem tabelas, como sugerido nesta resposta². Por exemplo, você pode usar a palavra-chave EXISTS para verificar se uma rotina existe, sem retornar nenhum valor. Aqui estão alguns exemplos de consultas sem tabelas:

- Para verificar se o pacote DBUPDATE existe:

```
SELECT EXISTS (PACKAGE DBUPDATE);
```

- Para verificar se a função DBUPDATE_VERSAO_GET existe no pacote DBUPDATE:

```
SELECT EXISTS (FUNCTION DBUPDATE.DBUPDATE_VERSAO_GET);
```

- Para verificar se o procedimento DBUPDATE_HIST_INS existe no pacote DBUPDATE:

```
SELECT EXISTS (PROCEDURE DBUPDATE.DBUPDATE_HIST_INS);
```

Espero que isso seja útil para você. 😊

Source: Conversation with Bing, 9/28/2023
(1) Firebird: Third-party Tools & Drivers. https://www.firebirdsql.org/en/third-party-tools/.
(2) How to select data from non-table in Firebird? - Stack Overflow. https://stackoverflow.com/questions/5913574/how-to-select-data-from-non-table-in-firebird.
(3) SELECT - Firebird. https://firebirdsql.org/refdocs/langrefupd20-select.html.





SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'DBUPDATE_HIST';



TDBUpdater.DBDescubraVersaoEConecte
exige a function versao_get, mas na pri vez que executar no cliente novo, ela nao existe

entao faz um teste se a tabela dbupdate_hist existe
se nao existe, nao tenta usar a function

e também nao é feito o prepare da dbquery.
o prepare dela é feito no fim do loop, assim, ao fim da prim volta, tanto a table quanto a function já foram criadas

versao_get retorna -1 se a tabela estiver vazia
por isto, incrementa iVersao ja no inicio do loop. se tem versao 5 gravada, vai procurar pelo arquivo de comandos 6. se tem -1, vai buscar pelo zero...




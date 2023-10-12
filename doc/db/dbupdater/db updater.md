# db updater

## pasta

C:\Pr\app\bantu\bantu-sis\bantu-lib\sis\db\updater


## `TComandoFBEnsureRecords`

os valores chave primária tem que ser os mais a esquerda.

### function TComandoFBEnsureRecords.GetAsSql: string;


Primeiro, descubro a quantidade de campos compoem a chave primária e armazeno em `iQtdIndices: integer;` 

Loop percorre as linhas do csv, indice vai em `I: integer`

sReg contem o registro atual
de sReg preenchemos `aValores: TArray<string>` com cada coluna em separado

vai descobrir se o registro já existe usando `FTemDBQuery: IDBQuery`

loop com J preenche os params de FTemDBQuery, que sao chaves primarias

FTemDBQuery é aberta e se o regtistro ja existe é colocado em `bRegistroTem: boolean`

Se bRegistroTem, executa update, `FInsDBExec: IDBExec;`
Se nao, executa insert `FUpdDBExec: IDBExec;`


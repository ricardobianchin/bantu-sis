# codigos

## criar banco

/*
comando `create database`do firebird
que cria o arquivo C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Serv.fdb
com usuario sysdba e senha masterkey
*/
``` firebird
create database 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Serv.fdb' user 'sysdba' password 'masterkey';
```

``` firebird
create database 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Term.fdb' user 'sysdba' password 'masterkey';
```

## configurar atalho

``` bash
"C:\Program Files (x86)\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Serv.fdb" -user SYSDBA -password masterkey  -ch WIN1252


"C:\Program Files (x86)\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Term.fdb" -user SYSDBA -password masterkey  -ch WIN1252
```

# criar estrutura do banco

``` firebird
create table prod(prod_id integer, prod_nome varchar(50));

insert into prod(prod_id, prod_nome) values(1, 'produto 1');
insert into prod(prod_id, prod_nome) values(2, 'produto 2');
insert into prod(prod_id, prod_nome) values(3, 'produto 3');
insert into prod(prod_id, prod_nome) values(4, 'produto 4');
insert into prod(prod_id, prod_nome) values(5, 'produto 5');
commit;
```



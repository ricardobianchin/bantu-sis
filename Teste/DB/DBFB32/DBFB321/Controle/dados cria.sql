-- cria C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\Dados\DadosTeste.fdb

-- comando para isql do firebird que cria o banco
CREATE DATABASE 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\Dados\DadosTeste.fdb'
user 'SYSDBA' password 'masterkey';

-- comando isql para conectar ao banco
CONNECT 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\Dados\DadosTeste.fdb'
user 'SYSDBA' password 'masterkey';


"C:\Program Files\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\dados_mercado_retaguarda.fdb" -user SYSDBA -password masterkey  -ch WIN1252
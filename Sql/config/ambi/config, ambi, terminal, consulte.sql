set output to "C:\Pr\app\bantu\bantu-sis\Src\Sql\config\ambi\terminal.txt";

select * from terminal;

esta linha de comando abre uma sessao do isql ja conectando ao banco de dados

"C:\Program Files (x86)\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\Dados_Mercado_Terminal_001.fdb"
-user SYSDBA -password masterkey

altere-a para que nao abra, mas, execute o script em "C:\Pr\app\bantu\bantu-sis\Src\Sql\config\ambi\termial select.sql" configurando o output para o arquivo de saida "C:\Pr\app\bantu\bantu-sis\Src\Sql\config\ambi\termial select.txt"

obrigado!


"C:\Program Files (x86)\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\Dados_Mercado_Terminal_001.fdb" -user SYSDBA -password masterkey -i "C:\Pr\app\bantu\bantu-sis\Src\Sql\config\ambi\termial select.sql" -o "C:\Pr\app\bantu\bantu-sis\Src\Sql\config\ambi\termial select.txt"


C:\Pr\app\bantu\bantu-sis\Src\Sql

# configuracao dos componentes

## conexao com o banco de dados

```frm
object FDConnection1: TFDConnection
  Params.Strings = (
    
      'Database=C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\D' +
      'ados\DadosTeste.fdb'
    'User_Name=sysdba'
    'Password=masterkey'
    'Protocol=TCPIP'
    'DriverID=FB')
  LoginPrompt = False
  Left = 96
  Top = 48
end
```



"C:\Program Files\Firebird\Firebird_5_0\isql.exe"
"DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\dados_mercado_retaguarda.fdb"
-user SYSDBA -password masterkey  -ch WIN1252;


"C:\Program Files\Firebird\Firebird_5_0\isql.exe"
"DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\Dados\DadosTeste.fdb"
-user SYSDBA -password masterkey  -ch WIN1252;


"C:\Program Files (x86)\Firebird\Firebird_5_0\isql.exe" "DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\exe\dados\dados_mercado_retaguarda.fdb" -user SYSDBA -password masterkey  -ch WIN1252

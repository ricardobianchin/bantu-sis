object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    DriverID = 'FB'
    VendorHome = 'C:\Program Files (x86)\Firebird\Firebird_5_0'
    VendorLib = 'fbclient.dll'
    Left = 224
    Top = 40
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=DELPHI-BTU'
      'Protocol=TCPIP'
      
        'Database=C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\DBFB32\DBFB321\D' +
        'ados\DadosTeste.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 360
    Top = 48
  end
end

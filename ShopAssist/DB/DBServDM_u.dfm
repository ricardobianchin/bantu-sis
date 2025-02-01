object DBServDM: TDBServDM
  Height = 480
  Width = 640
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    DriverID = 'FB'
    VendorHome = 'C:\Program Files (x86)\Firebird\Firebird_5_0'
    VendorLib = 'fbclient.dll'
    Left = 184
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 24
  end
  object Connection: TFDConnection
    Params.Strings = (
      'Protocol=TCPIP'
      'Server=DELPHI-BTU'
      'Database=C:\Pr\app\bantu\bantu-sis\Exe\Dados\dados.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 312
    Top = 24
  end
end

object DBServDM: TDBServDM
  OnCreate = DataModuleCreate
  Height = 278
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
      'Server=192.168.0.91'
      'Database=C:\DarosPDV\Dados\Dados_Mercado_Retaguarda.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 312
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = Connection
    Left = 40
    Top = 104
  end
  object FDCommand1: TFDCommand
    Connection = Connection
    Left = 128
    Top = 104
  end
end

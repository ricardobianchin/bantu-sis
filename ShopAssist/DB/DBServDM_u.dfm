object DBServDM: TDBServDM
  OnCreate = DataModuleCreate
  Height = 278
  Width = 640
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    DriverID = 'FB'
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
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = ConnectionBeforeConnect
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

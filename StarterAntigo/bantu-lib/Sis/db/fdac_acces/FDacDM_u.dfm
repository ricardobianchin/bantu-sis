object FDacDM: TFDacDM
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Pr\app\bantu\bantu-sis\exe\dados\RETAG.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=DELPHI-BTU'
      'DriverID=FB'
      'Port=3050')
    TxOptions.Isolation = xiReadCommitted
    LoginPrompt = False
    Left = 72
    Top = 24
  end
  object FDConnection2: TFDConnection
    Left = 192
    Top = 24
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    Left = 320
    Top = 32
  end
end

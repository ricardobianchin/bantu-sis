object SessoesFrame: TSessoesFrame
  Left = 0
  Top = 0
  Width = 650
  Height = 336
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 650
    Height = 336
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object TopoPanel: TPanel
      Left = 0
      Top = 0
      Width = 650
      Height = 161
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      ParentColor = True
      TabOrder = 0
    end
    object BasePanel: TPanel
      Left = 0
      Top = 295
      Width = 650
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
    end
    object MeioPanel: TPanel
      Left = 0
      Top = 161
      Width = 650
      Height = 134
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      ParentColor = True
      TabOrder = 2
      object SessoesScrollBox: TScrollBox
        Left = 0
        Top = 0
        Width = 650
        Height = 134
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  object ActionList1: TActionList
    Left = 184
    Top = 97
    object Action1: TAction
      Caption = 'Action1'
      ImageIndex = 2
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Pr\app\bantu\bantu-sis\Exe\Dados\Dados_Mercado_Retag' +
        'uarda.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=192.168.1.65'
      'Protocol=TCPIP'
      'DriverID=FB')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 152
    Top = 16
  end
end

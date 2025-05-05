inherited DateTimeFrame: TDateTimeFrame
  Width = 179
  Height = 23
  ExplicitWidth = 179
  ExplicitHeight = 23
  object EstDtIniPessLabel: TLabel
    Left = 0
    Top = 3
    Width = 24
    Height = 15
    Caption = 'Data'
  end
  object DtMaskEdit: TMaskEdit
    Left = 31
    Top = 0
    Width = 80
    Height = 23
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnKeyPress = DtMaskEditKeyPress
  end
  object HoraMaskEdit: TMaskEdit
    Left = 119
    Top = 0
    Width = 60
    Height = 23
    EditMask = '!99:99:99;1;_'
    MaxLength = 8
    TabOrder = 1
    Text = '  :  :  '
  end
end

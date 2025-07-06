inherited DateTimeFrame: TDateTimeFrame
  Width = 174
  Height = 35
  Hint = 'teste'
  ExplicitWidth = 174
  ExplicitHeight = 35
  object NomeLabel: TLabel
    Left = 0
    Top = 3
    Width = 24
    Height = 15
    Caption = 'Data'
  end
  object ErroLabel: TLabel
    Left = 107
    Top = 22
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Data inv'#225'lida'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  object DataMaskEdit: TMaskEdit
    Left = 29
    Top = 0
    Width = 80
    Height = 23
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnChange = DataMaskEditChange
    OnKeyPress = DataMaskEditKeyPress
  end
  object HoraMaskEdit: TMaskEdit
    Left = 114
    Top = 0
    Width = 60
    Height = 23
    EditMask = '!99:99:99;1;_'
    MaxLength = 8
    TabOrder = 1
    Text = '  :  :  '
    OnChange = HoraMaskEditChange
  end
end

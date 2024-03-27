inherited ComboBoxBasFrame: TComboBoxBasFrame
  Width = 309
  Height = 38
  ExplicitWidth = 309
  ExplicitHeight = 38
  object MensLabel: TLabel
    Left = 252
    Top = 23
    Width = 57
    Height = 15
    Alignment = taRightJustify
    Caption = 'MensLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = [seClient, seBorder]
  end
  object ControlsPanel: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 23
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object TitLabel: TLabel
      Left = 0
      Top = 0
      Width = 103
      Height = 23
      Align = alLeft
      Caption = 'Unidade de Medida'
      FocusControl = ComboBox1
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object EspacadorLabel: TLabel
      Left = 103
      Top = 0
      Width = 6
      Height = 23
      Align = alLeft
      Caption = '  '
      ExplicitHeight = 15
    end
    object ComboBox1: TComboBox
      Left = 109
      Top = 0
      Width = 200
      Height = 23
      Align = alLeft
      TabOrder = 0
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
    end
  end
end

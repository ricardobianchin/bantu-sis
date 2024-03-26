inherited ComboBoxBasFrame: TComboBoxBasFrame
  Width = 309
  Height = 23
  AutoSize = True
  ExplicitWidth = 309
  ExplicitHeight = 23
  object TitLabel: TLabel
    Left = 0
    Top = 0
    Width = 103
    Height = 15
    Align = alLeft
    Caption = 'Unidade de Medida'
    FocusControl = ComboBox1
    Layout = tlCenter
  end
  object EspacadorLabel: TLabel
    Left = 103
    Top = 0
    Width = 6
    Height = 15
    Align = alLeft
    Caption = '  '
  end
  object ComboBox1: TComboBox
    Left = 109
    Top = 0
    Width = 200
    Height = 23
    Align = alLeft
    TabOrder = 0
    Text = 'ComboBox1'
    OnKeyPress = ComboBox1KeyPress
  end
end

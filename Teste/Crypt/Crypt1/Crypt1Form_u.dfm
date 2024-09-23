object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Edit1: TEdit
    Left = 32
    Top = 24
    Width = 177
    Height = 23
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 32
    Top = 64
    Width = 177
    Height = 23
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 32
    Top = 104
    Width = 177
    Height = 23
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 216
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
end

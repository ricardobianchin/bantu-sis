inherited ExclBasForm: TExclBasForm
  Caption = 'ExclBasForm'
  ClientHeight = 277
  ClientWidth = 556
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  ExplicitWidth = 568
  ExplicitHeight = 315
  TextHeight = 15
  object PerguntaLabel: TLabel [0]
    Left = 8
    Top = 8
    Width = 76
    Height = 15
    Caption = 'PerguntaLabel'
  end
  object SimButton: TButton [1]
    Left = 172
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Sim - Enter'
    TabOrder = 0
  end
  object NaoButton: TButton [2]
    Left = 308
    Top = 208
    Width = 75
    Height = 25
    Caption = 'N'#227'o - Esc'
    TabOrder = 1
    OnClick = NaoButtonClick
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 48
    Top = 88
  end
end

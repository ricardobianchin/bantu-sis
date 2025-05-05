inherited DtHFaixaFrame: TDtHFaixaFrame
  Width = 569
  Height = 35
  ExplicitWidth = 569
  ExplicitHeight = 35
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 420
    Height = 21
    Align = alNone
    ButtonHeight = 21
    ButtonWidth = 80
    Caption = 'ToolBar1'
    List = True
    ShowCaptions = True
    TabOrder = 0
    object MesAntToolButton: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'M'#234's Anterior'
      ImageIndex = 0
      OnClick = MesAntToolButtonClick
    end
    object MesAtuToolButton: TToolButton
      Left = 84
      Top = 0
      AutoSize = True
      Caption = 'M'#234's Atual'
      ImageIndex = 1
      OnClick = MesAtuToolButtonClick
    end
    object HojeToolButton: TToolButton
      Left = 153
      Top = 0
      AutoSize = True
      Caption = 'Hoje'
      ImageIndex = 2
      OnClick = HojeToolButtonClick
    end
    object Dias30ToolButton: TToolButton
      Left = 194
      Top = 0
      AutoSize = True
      Caption = '30 dias'
      ImageIndex = 3
      OnClick = Dias30ToolButtonClick
    end
  end
end

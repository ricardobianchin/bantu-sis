inherited FiltroParamsStringFrame: TFiltroParamsStringFrame
  Width = 158
  Height = 23
  ParentShowHint = False
  ShowHint = True
  ExplicitWidth = 158
  ExplicitHeight = 23
  object FiltroTitLabel: TLabel [0]
    Left = 0
    Top = 3
    Width = 27
    Height = 15
    Caption = 'Filtro'
  end
  object BuscaStringEdit: TEdit [1]
    Left = 29
    Top = 0
    Width = 129
    Height = 23
    TabOrder = 0
    Text = ' '
  end
  inherited ChangeTimer: TTimer
    Left = 72
  end
end

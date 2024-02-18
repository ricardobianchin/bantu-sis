inherited FiltroParamsStringFrame: TFiltroParamsStringFrame
  Width = 168
  Height = 23
  ParentShowHint = False
  ShowHint = True
  ExplicitWidth = 168
  ExplicitHeight = 23
  object FiltroTitLabel: TLabel [0]
    Left = 6
    Top = 3
    Width = 27
    Height = 15
    Caption = 'Filtro'
  end
  object BuscaStringEdit: TEdit [1]
    Left = 37
    Top = 0
    Width = 129
    Height = 23
    TabOrder = 0
    Text = ' '
    OnChange = BuscaStringEditChange
    OnKeyPress = BuscaStringEditKeyPress
  end
  inherited ChangeTimer: TTimer
    Left = 72
  end
end

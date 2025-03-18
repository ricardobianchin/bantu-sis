inherited FiltroStringFrame: TFiltroStringFrame
  Width = 160
  Height = 23
  ExplicitWidth = 160
  ExplicitHeight = 23
  object FiltroTitLabel: TLabel [0]
    Left = 0
    Top = 3
    Width = 27
    Height = 15
    Caption = 'Filtro'
  end
  object FiltroStringEdit: TEdit [1]
    Left = 31
    Top = 0
    Width = 129
    Height = 23
    TabOrder = 0
    OnChange = FiltroStringEditChange
    OnKeyPress = FiltroStringEditKeyPress
  end
end

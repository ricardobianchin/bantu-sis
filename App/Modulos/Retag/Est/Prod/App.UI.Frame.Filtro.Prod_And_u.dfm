inherited ProdAndFiltroFrame: TProdAndFiltroFrame
  Width = 700
  Height = 24
  ExplicitWidth = 700
  ExplicitHeight = 24
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 700
    Height = 24
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object FiltroStringLabeledEdit: TLabeledEdit
      Left = 32
      Top = 1
      Width = 121
      Height = 23
      EditLabel.Width = 27
      EditLabel.Height = 23
      EditLabel.Caption = 'Filtro'
      LabelPosition = lpLeft
      LabelSpacing = 5
      MaxLength = 120
      TabOrder = 0
      Text = ''
      OnChange = FiltroStringLabeledEditChange
      OnKeyPress = FiltroStringLabeledEditKeyPress
    end
    object CodCheckBox: TCheckBox
      Left = 160
      Top = 4
      Width = 61
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object BarrasCheckBox: TCheckBox
      Left = 250
      Top = 4
      Width = 90
      Height = 17
      Caption = 'C'#243'd. Barras'
      TabOrder = 2
    end
    object DescrCheckBox: TCheckBox
      Left = 340
      Top = 4
      Width = 97
      Height = 17
      Caption = 'Descri'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object FabrCheckBox: TCheckBox
      Left = 430
      Top = 4
      Width = 97
      Height = 17
      Caption = 'Fabricante'
      TabOrder = 4
    end
    object TipoCheckBox: TCheckBox
      Left = 520
      Top = 4
      Width = 71
      Height = 17
      Caption = 'Tipo'
      TabOrder = 5
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 184
    Top = 72
  end
end

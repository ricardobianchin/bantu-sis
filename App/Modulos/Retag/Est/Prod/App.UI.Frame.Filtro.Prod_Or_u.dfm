inherited ProdOrFiltroFrame: TProdOrFiltroFrame
  Width = 700
  Height = 39
  ExplicitWidth = 700
  ExplicitHeight = 39
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 700
    Height = 39
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitHeight = 24
    object ErroLabel: TLabel
      Left = 0
      Top = 23
      Width = 6
      Height = 15
      Caption = '  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
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
    object CodRadioButton: TRadioButton
      Left = 160
      Top = 4
      Width = 74
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object BarrasRadioButton: TRadioButton
      Left = 231
      Top = 4
      Width = 86
      Height = 17
      Caption = 'C'#243'd. Barras'
      TabOrder = 2
    end
    object DescrRadioButton: TRadioButton
      Left = 325
      Top = 4
      Width = 77
      Height = 17
      Caption = 'Descri'#231#227'o'
      Checked = True
      TabOrder = 3
      TabStop = True
    end
    object FabrRadioButton: TRadioButton
      Left = 415
      Top = 4
      Width = 85
      Height = 17
      Caption = 'Fabricante'
      TabOrder = 4
    end
    object TipoRadioButton: TRadioButton
      Left = 507
      Top = 4
      Width = 62
      Height = 17
      Caption = 'Tipo'
      TabOrder = 5
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 167
    Top = 27
  end
end

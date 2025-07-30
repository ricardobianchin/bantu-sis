inherited ProdAndFiltroFrame: TProdAndFiltroFrame
  Width = 700
  Height = 50
  ExplicitWidth = 700
  ExplicitHeight = 50
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 700
    Height = 50
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object FilIntelLabel: TLabel
      Left = 143
      Top = 31
      Width = 35
      Height = 12
      Hint = 
        'Se digitar texto, filtra por Descri'#231#227'o. N'#250'meros com menos de 8 d' +
        #237'gitos, filtra por C'#243'digo, sen'#227'o, por c'#243'digo de barras'
      CustomHint = SisImgDataModule.BalloonHint1
      Caption = 'O que '#233'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
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
    object FilIntelCheckBox: TCheckBox
      Left = 32
      Top = 29
      Width = 113
      Height = 17
      Hint = 
        'Se digitar texto, filtra por Descri'#231#227'o. N'#250'meros com menos de 8 d' +
        #237'gitos, filtra por C'#243'digo, sen'#227'o, por c'#243'digo de barras'
      CustomHint = SisImgDataModule.BalloonHint1
      Caption = 'Filtro Inteligente'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 184
    Top = 72
  end
end

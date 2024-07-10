inherited EnderControlsFrame: TEnderControlsFrame
  Width = 930
  Height = 290
  Align = alClient
  ExplicitWidth = 930
  ExplicitHeight = 290
  object LogradouroLabel: TLabel
    Left = 4
    Top = 45
    Width = 62
    Height = 15
    Caption = 'Logradouro'
  end
  object NumeroLabel: TLabel
    Left = 479
    Top = 45
    Width = 44
    Height = 15
    Caption = 'N'#250'mero'
  end
  object ComplementoLabel: TLabel
    Left = 606
    Top = 45
    Width = 77
    Height = 15
    Caption = 'Complemento'
  end
  object BairroLabel: TLabel
    Left = 593
    Top = 7
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object CEPLabel: TLabel
    Left = 4
    Top = 7
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object DDDLabel: TLabel
    Left = 4
    Top = 84
    Width = 24
    Height = 15
    Caption = 'DDD'
  end
  object TelefonesLabel: TLabel
    Left = 84
    Top = 84
    Width = 49
    Height = 15
    Caption = 'Telefones'
  end
  object ContatoLabel: TLabel
    Left = 470
    Top = 84
    Width = 43
    Height = 15
    Caption = 'Contato'
  end
  object ReferenciaLabel: TLabel
    Left = 4
    Top = 118
    Width = 55
    Height = 15
    Caption = 'Referencia'
  end
  object UFSiglaLabel: TLabel
    Left = 147
    Top = 8
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object MunicipioLabel: TLabel
    Left = 226
    Top = 8
    Width = 54
    Height = 15
    Caption = 'Munic'#237'pio'
  end
  object UFSiglaStatusLabel: TLabel
    Left = 115
    Top = 27
    Width = 115
    Height = 13
    Caption = 'Trazendo munic'#237'pios...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = []
  end
  object CEPStatusLabel: TLabel
    Left = 4
    Top = 27
    Width = 81
    Height = 13
    Caption = 'Buscando CEP...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = []
  end
  object CEPColarSpeedButton: TSpeedButton
    Left = 93
    Top = 4
    Width = 23
    Height = 22
    Hint = 'Colar CEP'
    ImageIndex = 4
    Images = SisImgDataModule.ImageList16Flat
    OnClick = CEPColarSpeedButtonClick
  end
  object SpeedButton1: TSpeedButton
    Left = 115
    Top = 4
    Width = 23
    Height = 22
    Hint = 'N'#227'o sei o CEP...'
    ImageIndex = 2
    Images = SisImgDataModule.ImageList16Flat
    OnClick = SpeedButton1Click
  end
  object LogradouroEdit: TEdit
    Left = 71
    Top = 42
    Width = 400
    Height = 23
    MaxLength = 70
    TabOrder = 4
    OnKeyPress = LogradouroEditKeyPress
  end
  object TopoPanel: TPanel
    Left = 0
    Top = 272
    Width = 930
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 13
    object EnderStatusLabel: TLabel
      Left = 8
      Top = 3
      Width = 9
      Height = 15
      Caption = '   '
    end
  end
  object NumeroEdit: TEdit
    Left = 526
    Top = 42
    Width = 73
    Height = 23
    MaxLength = 60
    TabOrder = 5
    OnKeyPress = NumeroEditKeyPress
  end
  object ComplementoEdit: TEdit
    Left = 688
    Top = 42
    Width = 115
    Height = 23
    MaxLength = 60
    TabOrder = 6
    OnKeyPress = ComplementoEditKeyPress
  end
  object BairroEdit: TEdit
    Left = 630
    Top = 4
    Width = 219
    Height = 23
    MaxLength = 60
    TabOrder = 3
    OnKeyPress = BairroEditKeyPress
  end
  object DDDEdit: TEdit
    Left = 33
    Top = 81
    Width = 47
    Height = 23
    MaxLength = 2
    TabOrder = 7
    OnKeyPress = DDDEditKeyPress
  end
  object Fone1Edit: TEdit
    Left = 138
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 8
    Text = '080059121172354'
    OnKeyPress = Fone1EditKeyPress
  end
  object Fone2Edit: TEdit
    Left = 249
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 9
    OnKeyPress = Fone2EditKeyPress
  end
  object Fone3Edit: TEdit
    Left = 359
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 10
    OnKeyPress = Fone3EditKeyPress
  end
  object ContatoEdit: TEdit
    Left = 518
    Top = 81
    Width = 192
    Height = 23
    MaxLength = 60
    TabOrder = 11
    OnKeyPress = ContatoEditKeyPress
  end
  object ReferenciaMemo: TMemo
    Left = 4
    Top = 134
    Width = 798
    Height = 81
    MaxLength = 1000
    TabOrder = 12
    WantReturns = False
    OnKeyPress = ReferenciaMemoKeyPress
  end
  object UFSiglaComboBox: TComboBox
    Left = 166
    Top = 3
    Width = 53
    Height = 23
    MaxLength = 2
    TabOrder = 1
    Text = 'UFSiglaComboBox'
    OnChange = UFSiglaComboBoxChange
    OnKeyPress = UFSiglaComboBoxKeyPress
  end
  object MunicipioComboBox: TComboBox
    Left = 286
    Top = 3
    Width = 300
    Height = 23
    MaxLength = 60
    TabOrder = 2
    Text = 'MunicipioComboBox'
    OnKeyPress = MunicipioComboBoxKeyPress
  end
  object CEPMaskEdit: TMaskEdit
    Left = 30
    Top = 4
    Width = 63
    Height = 23
    EditMask = '00000-000'
    MaxLength = 9
    TabOrder = 0
    Text = '23070-221'
    OnKeyDown = CEPMaskEditKeyDown
    OnKeyPress = CEPMaskEditKeyPress
  end
  object CepNaoSeiBitBtn: TBitBtn
    Left = 82
    Top = 144
    Width = 108
    Height = 25
    Caption = 'N'#227'o sei o CEP'
    ImageIndex = 2
    Images = SisImgDataModule.ImageList16Flat
    TabOrder = 14
  end
  object MunicipioPrepareListaTimer: TTimer
    Enabled = False
    Interval = 333
    OnTimer = MunicipioPrepareListaTimerTimer
    Left = 448
    Top = 128
  end
end

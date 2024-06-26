inherited EnderControlsFrame: TEnderControlsFrame
  Width = 930
  Height = 290
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
    Left = 544
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
    Left = 87
    Top = 84
    Width = 49
    Height = 15
    Caption = 'Telefones'
  end
  object ContatoLabel: TLabel
    Left = 473
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
    Left = 98
    Top = 8
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object MunicipioLabel: TLabel
    Left = 176
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
    StyleElements = [seClient, seBorder]
  end
  object LogradouroEdit: TEdit
    Left = 71
    Top = 42
    Width = 400
    Height = 23
    MaxLength = 70
    TabOrder = 0
  end
  object TopoPanel: TPanel
    Left = 0
    Top = 272
    Width = 930
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
    TabOrder = 2
  end
  object ComplementoEdit: TEdit
    Left = 688
    Top = 42
    Width = 115
    Height = 23
    MaxLength = 60
    TabOrder = 3
  end
  object BairroEdit: TEdit
    Left = 580
    Top = 4
    Width = 219
    Height = 23
    MaxLength = 60
    TabOrder = 4
  end
  object DDDEdit: TEdit
    Left = 33
    Top = 81
    Width = 47
    Height = 23
    MaxLength = 2
    TabOrder = 5
  end
  object Fone1Edit: TEdit
    Left = 141
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 6
    Text = '080059121172354'
  end
  object Fone2Edit: TEdit
    Left = 252
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 7
  end
  object Fone3Edit: TEdit
    Left = 362
    Top = 81
    Width = 103
    Height = 23
    MaxLength = 15
    TabOrder = 8
  end
  object ContatoEdit: TEdit
    Left = 521
    Top = 81
    Width = 115
    Height = 23
    MaxLength = 60
    TabOrder = 9
  end
  object ReferenciaMemo: TMemo
    Left = 4
    Top = 134
    Width = 798
    Height = 81
    MaxLength = 1000
    TabOrder = 10
    WantReturns = False
  end
  object UFSiglaComboBox: TComboBox
    Left = 115
    Top = 4
    Width = 53
    Height = 23
    TabOrder = 11
    Text = 'UFSiglaComboBox'
  end
  object MunicipioComboBox: TComboBox
    Left = 236
    Top = 4
    Width = 300
    Height = 23
    TabOrder = 12
    Text = 'MunicipioComboBox'
  end
  object CEPMaskEdit: TMaskEdit
    Left = 29
    Top = 4
    Width = 60
    Height = 23
    EditMask = '00000-000'
    MaxLength = 9
    TabOrder = 13
    Text = '     -   '
  end
end

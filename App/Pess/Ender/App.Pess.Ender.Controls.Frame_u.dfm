inherited EnderControlsFrame: TEnderControlsFrame
  Width = 930
  Height = 290
  ExplicitWidth = 930
  ExplicitHeight = 290
  object LogradouroLabel: TLabel
    Left = 4
    Top = 63
    Width = 62
    Height = 15
    Caption = 'Logradouro'
  end
  object NumeroLabel: TLabel
    Left = 478
    Top = 63
    Width = 44
    Height = 15
    Caption = 'N'#250'mero'
  end
  object ComplementoLabel: TLabel
    Left = 605
    Top = 63
    Width = 77
    Height = 15
    Caption = 'Complemento'
  end
  object BairroLabel: TLabel
    Left = 532
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
    Top = 105
    Width = 24
    Height = 15
    Caption = 'DDD'
  end
  object TelefonesLabel: TLabel
    Left = 87
    Top = 105
    Width = 49
    Height = 15
    Caption = 'Telefones'
  end
  object ContatoLabel: TLabel
    Left = 397
    Top = 105
    Width = 43
    Height = 15
    Caption = 'Contato'
  end
  object ReferenciaLabel: TLabel
    Left = 4
    Top = 137
    Width = 55
    Height = 15
    Caption = 'Referencia'
  end
  object LogradouroEdit: TEdit
    Left = 71
    Top = 60
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
    Top = 60
    Width = 73
    Height = 23
    MaxLength = 60
    TabOrder = 2
  end
  object ComplementoEdit: TEdit
    Left = 687
    Top = 60
    Width = 115
    Height = 23
    MaxLength = 60
    TabOrder = 3
  end
  object BairroEdit: TEdit
    Left = 571
    Top = 4
    Width = 219
    Height = 23
    MaxLength = 60
    TabOrder = 4
  end
  object CEPEdit: TEdit
    Left = 33
    Top = 4
    Width = 65
    Height = 23
    MaxLength = 8
    TabOrder = 5
    Text = '23070221'
  end
  object MunicipioSubPanel: TPanel
    Left = 212
    Top = 2
    Width = 309
    Height = 41
    Caption = 'MunicipioSubPanel'
    TabOrder = 6
  end
  object UFSiglaSubPanel: TPanel
    Left = 104
    Top = 2
    Width = 105
    Height = 41
    Caption = 'UFSiglaSubPanel'
    TabOrder = 7
  end
  object DDDEdit: TEdit
    Left = 33
    Top = 102
    Width = 47
    Height = 23
    MaxLength = 2
    TabOrder = 8
  end
  object Fone1Edit: TEdit
    Left = 143
    Top = 102
    Width = 77
    Height = 23
    MaxLength = 15
    TabOrder = 9
  end
  object Fone2Edit: TEdit
    Left = 226
    Top = 102
    Width = 77
    Height = 23
    MaxLength = 15
    TabOrder = 10
  end
  object Fone3Edit: TEdit
    Left = 308
    Top = 102
    Width = 77
    Height = 23
    MaxLength = 15
    TabOrder = 11
  end
  object ContatoEdit: TEdit
    Left = 447
    Top = 102
    Width = 115
    Height = 23
    MaxLength = 60
    TabOrder = 12
  end
  object ReferenciaMemo: TMemo
    Left = 4
    Top = 153
    Width = 798
    Height = 81
    MaxLength = 1000
    TabOrder = 13
    WantReturns = False
  end
end

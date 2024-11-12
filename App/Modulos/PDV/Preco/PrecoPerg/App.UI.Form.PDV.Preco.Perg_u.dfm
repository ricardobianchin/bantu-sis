inherited PrecoPregForm: TPrecoPregForm
  Caption = 'PrecoPregForm'
  OnCreate = FormCreate
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 292
    ExplicitTop = 346
    ExplicitWidth = 471
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 277
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 312
    Width = 471
    Height = 48
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitTop = 313
    object BuscaLabeledEdit: TLabeledEdit
      Left = 40
      Top = 8
      Width = 121
      Height = 23
      EditLabel.Width = 31
      EditLabel.Height = 23
      EditLabel.Caption = 'Busca'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = ''
    end
  end
end

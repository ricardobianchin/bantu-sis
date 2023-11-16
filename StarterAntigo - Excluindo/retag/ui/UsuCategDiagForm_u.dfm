inherited UsuCategDiagForm: TUsuCategDiagForm
  Caption = 'Categoria de Usu'#225'rios'
  ClientHeight = 125
  ClientWidth = 376
  ExplicitWidth = 388
  ExplicitHeight = 163
  DesignSize = (
    376
    125)
  TextHeight = 15
  inherited ErroLabel: TLabel
    Top = 107
  end
  inherited OkButton: TButton
    Left = 157
    Top = 83
    ExplicitLeft = 364
    ExplicitTop = 167
  end
  inherited CancButton: TButton
    Left = 269
    Top = 83
    ExplicitLeft = 476
    ExplicitTop = 167
  end
  object NomeLabeledEdit: TLabeledEdit [3]
    Left = 16
    Top = 24
    Width = 281
    Height = 23
    EditLabel.Width = 33
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome'
    MaxLength = 32
    TabOrder = 2
    Text = ''
  end
  inherited ActionList1: TActionList
    Left = 160
    Top = 16
  end
end

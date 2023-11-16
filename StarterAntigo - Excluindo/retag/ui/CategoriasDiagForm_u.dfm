inherited CategDiagForm: TCategDiagForm
  Caption = 'Categoria...'
  ClientHeight = 104
  ClientWidth = 377
  OnShow = FormShow
  ExplicitWidth = 393
  ExplicitHeight = 143
  TextHeight = 15
  inherited ErroLabel: TLabel
    Left = 7
    Top = 88
    ExplicitLeft = 7
    ExplicitTop = 89
  end
  inherited OkButton: TButton
    Left = 158
    Top = 62
    ExplicitLeft = 368
    ExplicitTop = 167
  end
  object NomeLabeledEdit: TLabeledEdit [2]
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
    OnChange = NomeLabeledEditChange
    OnKeyPress = NomeLabeledEditKeyPress
  end
  inherited CancButton: TButton
    Left = 270
    Top = 62
    ExplicitLeft = 480
    ExplicitTop = 167
  end
  inherited ActionList1: TActionList
    Left = 16
    Top = 32
  end
end

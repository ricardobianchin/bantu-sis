inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  ClientWidth = 423
  ExplicitWidth = 435
  ExplicitHeight = 306
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 423
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 423
  end
  object AtivoCheckBox: TCheckBox [3]
    Left = 232
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 1
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    Width = 423
  end
end

inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  TextHeight = 15
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  inherited BasePanel: TPanel
    ExplicitWidth = 431
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 585
      ExplicitLeft = 28
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 698
      ExplicitLeft = 141
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 778
      ExplicitLeft = 221
    end
  end
  inherited NomePessEdit: TEdit
    Left = 78
    ExplicitLeft = 78
  end
  object AtivoCheckBox: TCheckBox [7]
    Left = 280
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 2
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited NomeFantaPessEdit: TEdit
    TabOrder = 3
  end
end

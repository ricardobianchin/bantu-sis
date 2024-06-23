inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  TextHeight = 15
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  object AtivoCheckBox: TCheckBox [11]
    Left = 280
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 2
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    ExplicitWidth = 988
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 589
      ExplicitLeft = 589
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 702
      ExplicitLeft = 702
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 782
      ExplicitLeft = 782
    end
  end
  inherited NomePessEdit: TEdit
    Left = 78
    ExplicitLeft = 78
  end
  inherited NomeFantaPessEdit: TEdit
    TabOrder = 9
  end
  inherited EnderecoPanel: TPanel
    TabOrder = 10
  end
end

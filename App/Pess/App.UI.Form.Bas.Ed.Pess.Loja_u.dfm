inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ExplicitLeft = 2
  TextHeight = 15
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  object AtivoCheckBox: TCheckBox [12]
    Left = 448
    Top = 122
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 11
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    TabOrder = 8
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 585
      ExplicitLeft = 581
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 698
      ExplicitLeft = 694
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 778
      ExplicitLeft = 774
    end
  end
  inherited NomePessEdit: TEdit
    Left = 78
    ExplicitLeft = 78
  end
  inherited NomeFantaPessEdit: TEdit
    TabOrder = 9
  end
  inherited ApelidoPessEdit: TEdit
    TabOrder = 1
  end
  inherited CPessEdit: TEdit
    TabOrder = 2
  end
  inherited IPessEdit: TEdit
    TabOrder = 3
  end
  inherited MPessEditEdit: TEdit
    TabOrder = 4
  end
  inherited MUFPessEdit: TEdit
    TabOrder = 5
  end
  inherited EMailPessEdit: TEdit
    TabOrder = 6
  end
  inherited EnderecoPanel: TPanel
    TabOrder = 7
  end
end

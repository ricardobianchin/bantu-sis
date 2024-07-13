inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientWidth = 953
  ExplicitWidth = 969
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 953
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 953
  end
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  object LojaIdLabel: TLabel [12]
    Left = 513
    Top = 124
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
    FocusControl = CPessEdit
  end
  object AtivoCheckBox: TCheckBox [13]
    Left = 448
    Top = 122
    Width = 57
    Height = 17
    Caption = 'Ativo'
    TabOrder = 13
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    Width = 953
    ExplicitWidth = 953
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 549
      ExplicitLeft = 549
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 662
      ExplicitLeft = 662
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 742
      ExplicitLeft = 742
    end
  end
  inherited NomePessEdit: TEdit
    Left = 78
    OnKeyPress = nil
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
  object LojaIdEdit: TEdit [27]
    Left = 559
    Top = 120
    Width = 45
    Height = 23
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 14
    OnExit = LojaIdEditExit
    OnKeyPress = CPessEditKeyPress
  end
end

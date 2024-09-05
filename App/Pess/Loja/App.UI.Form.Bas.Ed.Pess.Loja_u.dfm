inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientWidth = 941
  ExplicitWidth = 957
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 941
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 941
  end
  inherited NomePessLabel: TLabel
    Width = 65
    Caption = 'Raz'#227'o Social'
    ExplicitWidth = 65
  end
  object LojaIdLabel: TLabel [12]
    Left = 606
    Top = 124
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
    FocusControl = CPessEdit
  end
  object SelecionadoCheckBox: TCheckBox [13]
    Left = 507
    Top = 122
    Width = 86
    Height = 17
    Hint = 'Ligado indica que '
    CustomHint = SisImgDataModule.BalloonHint1
    Caption = 'Selecionado'
    TabOrder = 13
    OnKeyPress = SelecionadoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
    Width = 941
    ExplicitWidth = 945
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 529
      ExplicitLeft = 529
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 642
      ExplicitLeft = 642
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 722
      ExplicitLeft = 722
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
    Left = 650
    Top = 119
    Width = 45
    Height = 23
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 14
    OnExit = LojaIdEditExit
    OnKeyPress = CPessEditKeyPress
  end
  inherited AtivoPessCheckBox: TCheckBox
    TabOrder = 15
  end
end

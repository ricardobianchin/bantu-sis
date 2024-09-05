inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientWidth = 941
  ExplicitWidth = 953
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 941
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 941
  end
  object LojaIdLabel: TLabel [3]
    Left = 606
    Top = 124
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
    FocusControl = CPessEdit
  end
  inherited BasePanel: TPanel
    Width = 941
    TabOrder = 0
    ExplicitWidth = 941
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 525
      ExplicitLeft = 525
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 638
      ExplicitLeft = 638
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 718
      ExplicitLeft = 718
    end
  end
  inherited EnderecoPanel: TPanel
    Width = 941
    TabOrder = 7
  end
  inherited TitPanel: TPanel
    Width = 941
    TabOrder = 1
  end
  inherited NomePanel: TPanel
    Width = 941
    TabOrder = 2
    inherited NomePessLabel: TLabel
      Width = 65
      Caption = 'Raz'#227'o Social'
      ExplicitWidth = 65
    end
    inherited NomePessEdit: TEdit
      Left = 78
      OnKeyPress = nil
      ExplicitLeft = 78
    end
  end
  inherited PesJurPanel: TPanel
    Width = 941
    TabOrder = 3
  end
  inherited DocsPanel: TPanel
    Width = 941
    TabOrder = 4
  end
  object SelecionadoCheckBox: TCheckBox [10]
    Left = 507
    Top = 122
    Width = 86
    Height = 17
    Hint = 'Ligado indica que '
    CustomHint = SisImgDataModule.BalloonHint1
    Caption = 'Selecionado'
    TabOrder = 5
    OnKeyPress = SelecionadoCheckBoxKeyPress
  end
  object LojaIdEdit: TEdit [11]
    Left = 650
    Top = 119
    Width = 45
    Height = 23
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 6
    OnExit = LojaIdEditExit
    OnKeyPress = CPessEditKeyPress
  end
end

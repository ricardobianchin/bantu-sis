inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientHeight = 532
  ClientWidth = 941
  ExplicitLeft = -86
  ExplicitWidth = 953
  ExplicitHeight = 570
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 460
    Width = 941
    ExplicitTop = 460
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 480
    Width = 941
    ExplicitTop = 480
  end
  inherited BasePanel: TPanel
    Top = 495
    Width = 941
    TabOrder = 0
    ExplicitTop = 494
    ExplicitWidth = 937
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 517
      ExplicitLeft = 513
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 630
      ExplicitLeft = 626
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 710
      ExplicitLeft = 706
    end
  end
  inherited EnderecoPanel: TPanel
    Width = 941
    TabOrder = 5
    ExplicitWidth = 937
  end
  inherited TitPanel: TPanel
    Width = 941
    TabOrder = 1
    ExplicitWidth = 937
  end
  inherited NomePanel: TPanel
    Width = 941
    TabOrder = 2
    ExplicitWidth = 937
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
    ExplicitWidth = 937
  end
  inherited DocsPanel: TPanel
    Width = 941
    TabOrder = 4
    ExplicitWidth = 937
    object LojaIdLabel: TLabel [6]
      Left = 606
      Top = 37
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
      FocusControl = CPessEdit
    end
    object SelecionadoCheckBox: TCheckBox
      Left = 507
      Top = 36
      Width = 86
      Height = 17
      Hint = 'Ligado indica que '
      CustomHint = SisImgDataModule.BalloonHint1
      Caption = 'Selecionado'
      TabOrder = 9
      OnKeyPress = SelecionadoCheckBoxKeyPress
    end
    object LojaIdEdit: TEdit
      Left = 650
      Top = 33
      Width = 45
      Height = 23
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 10
      OnExit = LojaIdEditExit
    end
  end
end

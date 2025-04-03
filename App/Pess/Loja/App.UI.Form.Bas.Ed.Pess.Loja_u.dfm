inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientHeight = 531
  ClientWidth = 937
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 953
  ExplicitHeight = 570
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 459
    Width = 937
    ExplicitTop = 459
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 479
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 479
  end
  inherited BasePanel: TPanel
    Top = 494
    Width = 937
    TabOrder = 0
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 494
    ExplicitWidth = 937
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 517
      ExplicitLeft = 517
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 630
      ExplicitLeft = 630
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 710
      ExplicitLeft = 710
    end
  end
  inherited EnderecoPanel: TPanel
    Width = 937
    TabOrder = 5
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
  end
  inherited TitPanel: TPanel
    Width = 937
    TabOrder = 1
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
  end
  inherited NomePanel: TPanel
    Width = 937
    TabOrder = 2
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited NomePessLabel: TLabel
      Width = 65
      Caption = 'Raz'#227'o Social'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 65
    end
    inherited NomePessEdit: TEdit
      Left = 78
      StyleElements = [seFont, seClient, seBorder]
      OnKeyPress = nil
      ExplicitLeft = 78
    end
  end
  inherited PesJurPanel: TPanel
    Width = 937
    TabOrder = 3
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited NomeFantaPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ApelidoPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited NomeFantaPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ApelidoPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited DocsPanel: TPanel
    Width = 937
    TabOrder = 4
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited MUFPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DtNascPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EMailPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited CPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited IPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    object LojaIdLabel: TLabel [6]
      Left = 606
      Top = 37
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
      FocusControl = CPessEdit
    end
    inherited CPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited IPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MPessEditEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EMailPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MUFPessComboBox: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    object SelecionadoCheckBox: TCheckBox [15]
      Left = 507
      Top = 36
      Width = 86
      Height = 17
      Hint = 'Ligado indica que '
      CustomHint = SisImgDataModule.BalloonHint1
      Caption = 'Selecionado'
      TabOrder = 8
      OnKeyPress = SelecionadoCheckBoxKeyPress
    end
    object LojaIdEdit: TEdit [16]
      Left = 650
      Top = 33
      Width = 45
      Height = 23
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 9
      OnExit = LojaIdEditExit
    end
    inherited DtNascMaskEdit: TMaskEdit
      TabOrder = 10
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end

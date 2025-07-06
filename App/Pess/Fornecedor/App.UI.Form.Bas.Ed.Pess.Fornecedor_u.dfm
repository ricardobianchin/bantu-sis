inherited PessFornecedorEdForm: TPessFornecedorEdForm
  Caption = 'PessFornecedorEdForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited MensLabel: TLabel
    CustomHint = SisImgDataModule.BalloonHint1
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    TabOrder = 4
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited EnderecoPanel: TPanel
    Top = 164
    Height = 262
    TabOrder = 3
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 164
    ExplicitHeight = 262
  end
  inherited TitPanel: TPanel
    TabOrder = 5
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited NomePanel: TPanel
    TabOrder = 0
    StyleElements = [seFont, seClient, seBorder]
    inherited NomePessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    object Label1: TLabel [1]
      Left = 43
      Top = 1
      Width = 5
      Height = 15
      Caption = '*'
      FocusControl = ApelidoPessEdit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    inherited NomePessEdit: TEdit
      Left = 53
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 53
    end
  end
  inherited PesJurPanel: TPanel
    Height = 47
    TabOrder = 1
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 47
    inherited NomeFantaPessLabel: TLabel
      Top = 18
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 18
    end
    inherited ApelidoPessLabel: TLabel
      Left = 375
      Top = 18
      Width = 41
      Caption = 'Apelido'
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 375
      ExplicitTop = 18
      ExplicitWidth = 41
    end
    object AjudaApelidoLabel: TLabel [2]
      Left = 561
      Top = 0
      Width = 35
      Height = 12
      CustomHint = SisImgDataModule.BalloonHint1
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'O que '#233'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object ApelidoObrigLabel: TLabel [3]
      Left = 417
      Top = 14
      Width = 5
      Height = 15
      Caption = '*'
      FocusControl = ApelidoPessEdit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    inherited NomeFantaPessEdit: TEdit
      Top = 14
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 14
    end
    inherited ApelidoPessEdit: TEdit
      Left = 427
      Top = 14
      Width = 169
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 427
      ExplicitTop = 14
      ExplicitWidth = 169
    end
  end
  inherited DocsPanel: TPanel
    Top = 98
    TabOrder = 2
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 98
    inherited MUFPessLabel: TLabel
      Left = 716
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 716
    end
    inherited MPessLabel: TLabel
      Left = 482
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 482
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
    object Label2: TLabel [6]
      Left = 65
      Top = 0
      Width = 5
      Height = 15
      Caption = '*'
      FocusControl = ApelidoPessEdit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    inherited CPessEdit: TEdit
      Left = 74
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 74
    end
    inherited IPessEdit: TEdit
      Left = 306
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 306
    end
    inherited MPessEditEdit: TEdit
      Left = 557
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 557
    end
    inherited EMailPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MUFPessComboBox: TComboBox
      Left = 818
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 818
    end
    inherited DtNascMaskEdit: TMaskEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end

inherited PessClienteEdForm: TPessClienteEdForm
  Caption = 'PessClienteEdForm'
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
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 494
    ExplicitWidth = 937
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 494
      ExplicitLeft = 494
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 607
      ExplicitLeft = 607
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 687
      ExplicitLeft = 687
    end
  end
  inherited EnderecoPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited TitPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited NomePanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    inherited NomePessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited NomePessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PesJurPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
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
    inherited DtNascMaskEdit: TMaskEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end

inherited PessFornecedorEdForm: TPessFornecedorEdForm
  Caption = 'PessFornecedorEdForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited OkBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
  end
  inherited EnderecoPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited TitPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited NomePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited NomePessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited NomePessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PesJurPanel: TPanel
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
    StyleElements = [seFont, seClient, seBorder]
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

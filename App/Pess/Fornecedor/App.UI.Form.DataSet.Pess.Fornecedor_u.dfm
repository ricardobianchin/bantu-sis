inherited AppPessFornecedorDataSetForm: TAppPessFornecedorDataSetForm
  Caption = 'AppPessFornecedorDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 30
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
end

inherited AppPessFornecedorDataSetForm: TAppPessFornecedorDataSetForm
  Caption = 'AppPessFornecedorDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited TitToolBar1_BasTabSheet: TToolBar
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 560
      end
    end
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
end

inherited InventarioEdForm: TInventarioEdForm
  Caption = 'InventarioEdForm'
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
  end
  inherited NotaGroupBox: TGroupBox
    Caption = 'Invent'#225'rio'
  end
  inherited ItemGroupBox: TGroupBox
    inherited QtdNumEditBtu: TNumEditBtu
      Text = '1,000'
      OnChange = QtdNumEditBtuChange
      OnKeyPress = QtdNumEditBtuKeyPress
      Valor = '1'
    end
  end
end

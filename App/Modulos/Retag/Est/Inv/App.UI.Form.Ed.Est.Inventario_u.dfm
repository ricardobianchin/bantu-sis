inherited InventarioEdForm: TInventarioEdForm
  Caption = 'InventarioEdForm'
  TextHeight = 15
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

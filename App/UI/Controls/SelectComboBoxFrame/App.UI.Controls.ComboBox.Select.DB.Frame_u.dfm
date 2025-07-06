inherited ComboBoxSelectDBFrame: TComboBoxSelectDBFrame
  inherited ControlsPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited BuscaSpeedButton: TSpeedButton
      OnClick = BuscaSpeedButtonClick
    end
    inherited EspacadorLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited Espacador2Label: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ComboBox1: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end

inherited AppPDVMenuForm: TAppPDVMenuForm
  Caption = 'AppPDVMenuForm'
  ClientWidth = 482
  ExplicitWidth = 482
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 482
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 482
  end
  inherited FundoPanel_AppMenuForm: TPanel
    Width = 482
    inherited FecharModuloButton_AppMenuForm: TButton
      Left = 249
      ExplicitLeft = 249
    end
    inherited OcultarModuloButton_AppMenuForm: TButton
      Left = 124
      ExplicitLeft = 124
    end
    object BuscaPrecoButton: TButton
      Left = 370
      Top = 8
      Width = 98
      Height = 25
      Caption = 'B - Busca Pre'#231'o'
      TabOrder = 3
      OnClick = BuscaPrecoButtonClick
    end
  end
end

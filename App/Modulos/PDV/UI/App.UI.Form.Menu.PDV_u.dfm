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
    ExplicitWidth = 482
    object BuscaPrecoButton: TButton [3]
      Left = 369
      Top = 48
      Width = 98
      Height = 25
      Caption = 'B - Busca Pre'#231'o'
      TabOrder = 4
      OnClick = BuscaPrecoButtonClick
    end
    inherited StatusPanel: TPanel
      Width = 480
      ExplicitTop = 333
      ExplicitWidth = 480
    end
    inherited TitleBarPanel: TPanel
      Width = 480
      TabOrder = 5
      ExplicitWidth = 480
      inherited ToolBar1: TToolBar
        OnClick = nil
        inherited FecharToolButton: TToolButton
          OnClick = nil
        end
      end
    end
  end
end

inherited PDVModuloBasForm: TPDVModuloBasForm
  Caption = 'PDVModuloBasForm'
  ClientHeight = 280
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 280
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    inherited TitleBarTextCaptionLabel: TLabel
      Top = 4
      Width = 202
      Height = 21
      Font.Height = -16
      Font.Name = 'Segoe UI Black'
      ExplicitTop = 4
      ExplicitWidth = 202
      ExplicitHeight = 21
    end
  end
  inherited BasePanel: TPanel
    Top = 251
    Visible = False
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 251
    inherited StatusPanel1: TPanel
      Visible = False
      StyleElements = [seFont, seClient, seBorder]
      inherited StatusLabel1: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited OutputLabel: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultaPreo1: TMenuItem
      Caption = 'Consulta &Pre'#231'o'
    end
  end
  object PDVActionList: TActionList
    Left = 280
    Top = 56
    object PrecoBuscaAction_PDVModuloBasForm: TAction
      Caption = 'Consulta &Pre'#231'o'
    end
    object CaixaSessaoAbrirTentarAction: TAction
      Category = 'CaixaSessao'
      Caption = 'Abrir o Caixa'
      OnExecute = CaixaSessaoAbrirTentarActionExecute
    end
    object SessFormAction: TAction
      Category = 'CaixaSessao'
      Caption = 'Rotinas de Caixa'
      OnExecute = SessFormActionExecute
    end
  end
end

inherited ConfigModuloBasForm: TConfigModuloBasForm
  Caption = 'ConfigModuloBasForm'
  ClientWidth = 604
  StyleElements = []
  ExplicitWidth = 604
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 604
    ExplicitWidth = 604
    DesignSize = (
      604
      30)
  end
  inherited BasePanel: TPanel
    Width = 604
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 604
    DesignSize = (
      604
      29)
    inherited StatusPanel1: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited StatusLabel1: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited OutputLabel: TLabel
        Width = 203
        Height = 27
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 160
    Top = 104
  end
  inherited TitleBarActionList_ModuloBasForm: TActionList
    Left = 336
    Top = 104
  end
  inherited PopupMenu1: TPopupMenu
    Left = 40
    Top = 104
  end
end

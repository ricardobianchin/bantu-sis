inherited ConfigModuloBasForm: TConfigModuloBasForm
  Caption = 'ConfigModuloBasForm'
  ClientHeight = 253
  ClientWidth = 472
  StyleElements = []
  ExplicitWidth = 472
  ExplicitHeight = 253
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 472
    ExplicitWidth = 604
    DesignSize = (
      472
      30)
    inherited TitleBarTextCaptionLabel: TLabel
      Left = 109
      Top = 7
      ExplicitLeft = 109
      ExplicitTop = 7
    end
    inherited ToolBar1: TToolBar
      Left = 382
    end
  end
  inherited BasePanel: TPanel
    Top = 224
    Width = 472
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 604
    DesignSize = (
      472
      29)
    inherited StatusPanel1: TPanel
      Left = 273
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

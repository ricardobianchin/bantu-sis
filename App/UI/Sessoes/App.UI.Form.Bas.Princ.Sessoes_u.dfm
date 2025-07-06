inherited SessoesPrincBasForm: TSessoesPrincBasForm
  Caption = 'SessoesPrincBasForm'
  ClientHeight = 583
  ClientWidth = 670
  Position = poDesktopCenter
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 670
  ExplicitHeight = 583
  TextHeight = 15
  inherited Logo1Image: TImage
    Width = 670
    ExplicitWidth = 670
  end
  inherited DtHCompileLabel: TLabel
    Left = 136
    Top = 450
    ExplicitLeft = 136
    ExplicitTop = 450
  end
  inherited TitleBarPanel: TPanel
    Width = 670
    ExplicitWidth = 670
    DesignSize = (
      670
      41)
    inherited ToolBar1: TToolBar
      Left = 569
      ExplicitLeft = 569
    end
  end
  object BasePanel: TPanel [3]
    Left = 0
    Top = 518
    Width = 670
    Height = 65
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object DtHCompilePanel: TPanel
      Left = 11
      Top = 2
      Width = 94
      Height = 50
      Caption = ' '
      TabOrder = 0
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    Left = 256
    Top = 56
  end
end

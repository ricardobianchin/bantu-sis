inherited SessoesPrincBasForm: TSessoesPrincBasForm
  Caption = 'SessoesPrincBasForm'
  ClientHeight = 583
  ClientWidth = 670
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  ExplicitWidth = 670
  ExplicitHeight = 583
  DesignSize = (
    670
    583)
  TextHeight = 15
  inherited Logo1Image: TImage
    Width = 670
    ExplicitWidth = 670
  end
  inherited AndamentoTitLabel: TLabel
    Left = 223
    Top = 443
    ExplicitLeft = 223
    ExplicitTop = 443
  end
  inherited StatusLabel: TLabel
    Left = 210
    Top = 443
    Width = 364
    Height = 28
    Font.Height = -13
    ExplicitLeft = 210
    ExplicitTop = 443
    ExplicitWidth = 364
    ExplicitHeight = 28
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
  inherited StatusMemo: TMemo
    Left = 8
    Top = 488
    Width = 612
    Height = 48
    Anchors = [akLeft, akBottom]
    ExplicitLeft = 8
    ExplicitTop = 488
    ExplicitWidth = 612
    ExplicitHeight = 48
  end
  object BasePanel: TPanel [6]
    Left = 0
    Top = 528
    Width = 670
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 628
    object DtHCompilePanel: TPanel
      Left = 11
      Top = 2
      Width = 206
      Height = 36
      Caption = ' '
      TabOrder = 0
    end
    object StatusPanel: TPanel
      Left = 223
      Top = 2
      Width = 326
      Height = 36
      Caption = ' '
      TabOrder = 1
    end
  end
end

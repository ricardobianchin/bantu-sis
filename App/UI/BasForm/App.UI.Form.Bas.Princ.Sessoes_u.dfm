inherited SessoesPrincBasForm: TSessoesPrincBasForm
  Caption = 'SessoesPrincBasForm'
  ClientHeight = 583
  ExplicitHeight = 583
  DesignSize = (
    628
    583)
  TextHeight = 15
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
    Width = 628
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
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
  object ScrollBox1: TScrollBox [7]
    Left = 0
    Top = 240
    Width = 628
    Height = 284
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 3
    StyleElements = []
  end
  object TopoPanel: TPanel [8]
    Left = 0
    Top = 141
    Width = 628
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 4
    object SessaoToolBar: TToolBar
      Left = 0
      Top = 0
      Width = 628
      Height = 29
      ButtonHeight = 21
      ButtonWidth = 76
      Caption = 'SessaoToolBar'
      List = True
      ShowCaptions = True
      TabOrder = 0
      StyleElements = []
    end
  end
end

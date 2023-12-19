inherited ModulosPrincBasForm: TModulosPrincBasForm
  Caption = 'ModulosPrincBasForm'
  ClientHeight = 583
  ExplicitHeight = 583
  TextHeight = 15
  inherited StatusLabel: TLabel
    Left = 8
    Top = 147
    Width = 364
    Height = 28
    Font.Height = -13
    ExplicitLeft = 8
    ExplicitTop = 147
    ExplicitWidth = 364
    ExplicitHeight = 28
  end
  inherited DtHCompileLabel: TLabel
    Left = 8
    Top = 382
    ExplicitLeft = 8
    ExplicitTop = 382
  end
  inherited StatusMemo: TMemo
    Left = 8
    Top = 488
    Width = 612
    Height = 48
    Anchors = [akLeft, akBottom]
    ExplicitLeft = 8
    ExplicitTop = 382
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
end

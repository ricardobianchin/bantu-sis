inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 495
  ExplicitWidth = 511
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 495
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited BasePanel: TPanel
    Width = 495
    ExplicitWidth = 495
    DesignSize = (
      495
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 152
      ExplicitLeft = 160
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 265
      ExplicitLeft = 273
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 345
      ExplicitLeft = 353
    end
  end
end

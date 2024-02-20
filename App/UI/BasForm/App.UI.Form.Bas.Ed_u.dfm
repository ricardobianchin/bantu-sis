inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 495
  ExplicitWidth = 507
  ExplicitHeight = 335
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
    ExplicitTop = 259
    ExplicitWidth = 491
    DesignSize = (
      495
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 148
      ExplicitLeft = 144
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 261
      ExplicitLeft = 257
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 341
      ExplicitLeft = 337
    end
  end
end

inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientWidth = 431
  ExplicitHeight = 305
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 431
    ExplicitTop = 195
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 431
    Height = 17
    Align = alTop
    Font.Height = -13
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 16
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 431
    ExplicitTop = 215
  end
  inherited BasePanel: TPanel
    Width = 431
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 121
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 222
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 160
  end
  inherited ActionList1_Diag: TActionList
    Left = 152
    Top = 160
  end
end

inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 460
  ClientWidth = 980
  ExplicitWidth = 996
  ExplicitHeight = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 403
    Width = 980
    ExplicitTop = 404
  end
  inherited BasePanel: TPanel
    Top = 423
    Width = 980
    ExplicitTop = 423
    ExplicitWidth = 980
    DesignSize = (
      980
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 569
      ExplicitLeft = 569
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 682
      ExplicitLeft = 682
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 762
      ExplicitLeft = 762
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 111
    Top = 96
  end
  inherited ActionList1_Diag: TActionList
    Left = 272
    Top = 104
  end
end

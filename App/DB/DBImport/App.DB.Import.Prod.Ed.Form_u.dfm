inherited DBImportProdEdForm: TDBImportProdEdForm
  Caption = 'Alterando item a importar...'
  ClientHeight = 367
  ClientWidth = 590
  ExplicitWidth = 602
  ExplicitHeight = 405
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 295
    Width = 590
    ExplicitTop = 295
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 352
    Width = 590
    ExplicitTop = 352
  end
  inherited BasePanel: TPanel
    Top = 315
    Width = 590
    ExplicitTop = 314
    ExplicitWidth = 586
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 247
      ExplicitLeft = 243
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 360
      ExplicitLeft = 356
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 440
      ExplicitLeft = 436
    end
  end
  object SelCheckBox: TCheckBox [3]
    Left = 8
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Ser'#225' importado'
    TabOrder = 1
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 88
    Top = 144
  end
  inherited ActionList1_Diag: TActionList
    Left = 232
    Top = 144
  end
end

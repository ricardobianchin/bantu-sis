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
    ExplicitTop = 211
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 352
    Width = 590
    ExplicitTop = 268
  end
  inherited BasePanel: TPanel
    Top = 315
    Width = 590
    ExplicitTop = 230
    ExplicitWidth = 443
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 251
      ExplicitLeft = 104
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 364
      ExplicitLeft = 217
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 444
      ExplicitLeft = 297
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

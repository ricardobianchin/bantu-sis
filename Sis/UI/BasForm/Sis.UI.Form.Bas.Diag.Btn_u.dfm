inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 293
  ClientWidth = 487
  ExplicitWidth = 503
  ExplicitHeight = 332
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 221
    Width = 487
    Font.Color = 166
    ExplicitTop = 222
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 278
    Width = 487
    ExplicitTop = 279
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 241
    Width = 487
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 242
    ExplicitWidth = 491
    DesignSize = (
      487
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 164
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 0
      ExplicitLeft = 168
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 277
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 1
      ExplicitLeft = 281
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 357
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitLeft = 361
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Interval = 50
  end
  inherited ActionList1_Diag: TActionList
    inherited CancelAct_Diag: TAction
      Caption = 'Cancelar'
    end
    object MensCopyAct_Diag: TAction
      Caption = 'Copiar Mensagem'
      OnExecute = MensCopyAct_DiagExecute
    end
  end
end

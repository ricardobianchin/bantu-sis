inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 290
  ClientWidth = 475
  ExplicitWidth = 491
  ExplicitHeight = 329
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 218
    Width = 475
    Font.Color = 166
    ExplicitTop = 219
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 275
    Width = 475
    ExplicitTop = 276
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 238
    Width = 475
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 479
    DesignSize = (
      475
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 144
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
      Left = 257
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
      Left = 337
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

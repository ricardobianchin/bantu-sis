inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 294
  ClientWidth = 491
  ExplicitWidth = 507
  ExplicitHeight = 333
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 222
    Width = 491
    Font.Color = 166
    ExplicitTop = 223
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 279
    Width = 491
    ExplicitTop = 280
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 242
    Width = 491
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      491
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 168
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 0
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 281
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 1
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 361
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
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

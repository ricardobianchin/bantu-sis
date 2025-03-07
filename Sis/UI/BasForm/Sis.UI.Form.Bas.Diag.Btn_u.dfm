inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 281
  ClientWidth = 439
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 455
  ExplicitHeight = 320
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 209
    Width = 439
    Font.Color = 166
    ExplicitTop = 209
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 266
    Width = 439
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 266
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 229
    Width = 439
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      439
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 100
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 2
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 229
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 0
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 325
      Top = 5
      Width = 87
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 1
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

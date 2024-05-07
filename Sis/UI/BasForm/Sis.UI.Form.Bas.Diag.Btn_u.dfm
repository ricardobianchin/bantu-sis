inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 283
  ClientWidth = 447
  OnCreate = FormCreate
  ExplicitWidth = 463
  ExplicitHeight = 322
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 211
    Width = 447
    Font.Color = 166
    ExplicitTop = 212
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 268
    Width = 447
    ExplicitTop = 269
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 231
    Width = 447
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 232
    ExplicitWidth = 451
    DesignSize = (
      447
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 116
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
      Left = 309
      Top = 5
      Width = 75
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

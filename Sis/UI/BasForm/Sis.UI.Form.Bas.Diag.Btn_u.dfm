inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 284
  ClientWidth = 451
  OnCreate = FormCreate
  ExplicitWidth = 463
  ExplicitHeight = 322
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 212
    Width = 451
    Font.Color = 166
    ExplicitTop = 212
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 269
    Width = 451
    ExplicitTop = 269
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 232
    Width = 451
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 231
    ExplicitWidth = 447
    DesignSize = (
      451
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 120
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 0
      ExplicitLeft = 116
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 233
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 1
      ExplicitLeft = 229
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 313
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitLeft = 309
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

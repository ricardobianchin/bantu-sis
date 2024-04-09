inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 285
  ClientWidth = 455
  ExplicitWidth = 471
  ExplicitHeight = 324
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 213
    Width = 455
    Font.Color = 166
    ExplicitTop = 214
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 270
    Width = 455
    ExplicitTop = 271
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 233
    Width = 455
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 234
    ExplicitWidth = 459
    DesignSize = (
      455
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 124
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
      Left = 237
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
      Left = 317
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

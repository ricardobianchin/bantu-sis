inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 287
  ClientWidth = 463
  ExplicitWidth = 479
  ExplicitHeight = 326
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 215
    Width = 463
    Font.Color = 166
    ExplicitTop = 216
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 272
    Width = 463
    ExplicitTop = 273
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 235
    Width = 463
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      463
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 132
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
      Left = 245
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
      Left = 325
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

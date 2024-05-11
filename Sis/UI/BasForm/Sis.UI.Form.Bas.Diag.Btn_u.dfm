inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 282
  ClientWidth = 443
  OnCreate = FormCreate
  ExplicitWidth = 459
  ExplicitHeight = 321
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 443
    Font.Color = 166
    ExplicitTop = 211
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 267
    Width = 443
    ExplicitTop = 268
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 230
    Width = 443
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 231
    ExplicitWidth = 447
    DesignSize = (
      443
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 112
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 2
      ExplicitLeft = 116
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 225
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 0
      ExplicitLeft = 229
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 305
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 1
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

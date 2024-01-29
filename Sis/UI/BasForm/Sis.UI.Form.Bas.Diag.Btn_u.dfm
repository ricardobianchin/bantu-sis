inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 298
  ClientWidth = 507
  ExplicitWidth = 519
  ExplicitHeight = 336
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
    Width = 507
    ExplicitTop = 241
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 261
    Width = 507
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 260
    ExplicitWidth = 503
    DesignSize = (
      507
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 188
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 0
      ExplicitLeft = 184
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 301
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 1
      ExplicitLeft = 297
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 381
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitLeft = 377
    end
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

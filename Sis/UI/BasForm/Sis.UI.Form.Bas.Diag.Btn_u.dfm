inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 297
  ClientWidth = 503
  ExplicitWidth = 519
  ExplicitHeight = 336
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 240
    Width = 503
    ExplicitTop = 240
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 260
    Width = 503
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      503
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 184
      Top = 5
      Width = 108
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Copiar Mensagem'
      TabOrder = 0
      ExplicitLeft = 180
    end
    object OkBitBtn_DiagBtn: TBitBtn
      Left = 297
      Top = 5
      Width = 75
      Height = 25
      Action = OkAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      TabOrder = 1
      ExplicitLeft = 293
    end
    object CancelBitBtn_DiagBtn: TBitBtn
      Left = 377
      Top = 5
      Width = 75
      Height = 25
      Action = CancelAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitLeft = 373
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

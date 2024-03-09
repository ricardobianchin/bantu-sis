inherited DiagBtnBasForm: TDiagBtnBasForm
  Caption = 'DiagBtnBasForm'
  ClientHeight = 295
  ClientWidth = 495
  ExplicitWidth = 511
  ExplicitHeight = 334
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 223
    Width = 495
    Font.Color = 166
    ExplicitTop = 239
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 280
    Width = 495
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 243
    Width = 495
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 258
    DesignSize = (
      495
      37)
    object MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 172
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
      Left = 285
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
      Left = 365
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

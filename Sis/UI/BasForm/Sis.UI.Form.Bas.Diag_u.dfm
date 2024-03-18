inherited DiagBasForm: TDiagBasForm
  BorderIcons = []
  Caption = 'DiagBasForm'
  ClientHeight = 371
  ClientWidth = 515
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  ExplicitWidth = 531
  ExplicitHeight = 410
  TextHeight = 15
  object MensLabel: TLabel [0]
    Left = 0
    Top = 351
    Width = 515
    Height = 20
    Align = alBottom
    Caption = 'MensLabel'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9671679
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
    StyleElements = [seClient, seBorder]
    ExplicitTop = 352
    ExplicitWidth = 71
  end
  object AlteracaoTextoLabel: TLabel [1]
    Left = 0
    Top = 336
    Width = 515
    Height = 15
    Align = alBottom
    Caption = 'AlteracaoTextoLabel'
    ExplicitTop = 337
    ExplicitWidth = 106
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 48
    Top = 32
  end
  object ActionList1_Diag: TActionList
    Left = 192
    Top = 32
    object OkAct_Diag: TAction
      Caption = 'Ok'
      OnExecute = OkAct_DiagExecute
    end
    object CancelAct_Diag: TAction
      Caption = 'CancelAct_Diag'
      OnExecute = CancelAct_DiagExecute
    end
  end
end

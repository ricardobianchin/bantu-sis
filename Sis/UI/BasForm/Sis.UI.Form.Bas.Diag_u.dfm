inherited DiagBasForm: TDiagBasForm
  BorderIcons = []
  Caption = 'DiagBasForm'
  ClientHeight = 358
  ClientWidth = 463
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  ExplicitWidth = 475
  ExplicitHeight = 396
  TextHeight = 15
  object MensLabel: TLabel [0]
    Left = 0
    Top = 338
    Width = 463
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
    ExplicitWidth = 71
  end
  object AlteracaoTextoLabel: TLabel [1]
    Left = 0
    Top = 323
    Width = 463
    Height = 15
    Align = alBottom
    Caption = 'AlteracaoTextoLabel'
    ExplicitWidth = 106
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 48
    Top = 32
  end
  object ActionList1_Diag: TActionList
    Images = SisImgDataModule.ImageList24Flat
    Left = 192
    Top = 32
    object OkAct_Diag: TAction
      Caption = 'Ok'
      ImageIndex = 0
      OnExecute = OkAct_DiagExecute
    end
    object CancelAct_Diag: TAction
      Caption = 'CancelAct_Diag'
      ImageIndex = 1
      OnExecute = CancelAct_DiagExecute
    end
  end
end

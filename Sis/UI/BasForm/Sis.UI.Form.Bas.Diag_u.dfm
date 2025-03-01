inherited DiagBasForm: TDiagBasForm
  BorderIcons = []
  Caption = 'DiagBasForm'
  ClientHeight = 354
  ClientWidth = 447
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  ExplicitWidth = 463
  ExplicitHeight = 393
  TextHeight = 15
  object MensLabel: TLabel [0]
    Left = 0
    Top = 334
    Width = 447
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
    ExplicitTop = 335
    ExplicitWidth = 71
  end
  object AlteracaoTextoLabel: TLabel [1]
    Left = 0
    Top = 319
    Width = 447
    Height = 15
    Align = alBottom
    Caption = 'AlteracaoTextoLabel'
    ExplicitTop = 320
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

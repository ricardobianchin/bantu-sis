inherited GerAppForm: TGerAppForm
  Caption = 'GerAppForm'
  ClientHeight = 224
  ClientWidth = 344
  Position = poDesktopCenter
  OnCreate = FormCreate
  ExplicitWidth = 360
  ExplicitHeight = 263
  TextHeight = 15
  object TitleBarPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 344
    Height = 41
    Cursor = crSizeAll
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    OnMouseDown = TitleBarPanelMouseDown
    ExplicitWidth = 356
    object TitleToolBar: TToolBar
      Left = 252
      Top = 12
      Width = 100
      Height = 29
      Align = alNone
      Caption = 'TitleToolBar'
      Images = SisImgDataModule.ImageList_13_8
      TabOrder = 0
    end
  end
  object Button1: TButton [1]
    Left = 16
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 192
    Top = 32
  end
  object TitActionList: TActionList
    Images = SisImgDataModule.ImageList_13_8
    Left = 104
    Top = 72
    object FecharAction_GerAppForm: TAction
      Caption = 'Fechar'
      OnExecute = FecharAction_GerAppFormExecute
    end
  end
end

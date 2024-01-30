inherited ModuloBasForm: TModuloBasForm
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ModuloBasForm'
  ClientHeight = 476
  ClientWidth = 620
  KeyPreview = True
  WindowState = wsMaximized
  OnKeyPress = FormKeyPress
  ExplicitWidth = 620
  ExplicitHeight = 476
  TextHeight = 15
  object TitleBarPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 620
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = '   '
    Color = 3813420
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    DesignSize = (
      620
      30)
    object TitleBarTextCaptionLabel: TLabel
      Left = 32
      Top = 8
      Width = 130
      Height = 15
      Caption = 'TitleBarTextCaptionLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14597805
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object ToolBar1: TToolBar
      Left = 562
      Top = 0
      Width = 51
      Height = 29
      Align = alNone
      Anchors = [akTop, akRight]
      ButtonWidth = 47
      Caption = 'ToolBar1'
      Flat = False
      Images = SisImgDataModule.ImageList_40_24
      TabOrder = 0
      StyleElements = []
      object FecharToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FecharAction_ModuloBasForm
      end
    end
  end
  object TitleBarActionList_ModuloBasForm: TActionList
    Images = SisImgDataModule.ImageList_40_24
    Left = 368
    Top = 88
    object FecharAction_ModuloBasForm: TAction
      Caption = 'FecharAction_ModuloBasForm'
      ImageIndex = 0
      OnExecute = FecharAction_ModuloBasFormExecute
    end
  end
end

inherited TabSheetBasForm: TTabSheetBasForm
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'TabSheetBasForm'
  ClientHeight = 477
  ClientWidth = 632
  OnClose = FormClose
  TextHeight = 15
  object TitPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 632
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    Color = 3813420
    ParentBackground = False
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 632
      Height = 30
      ButtonHeight = 30
      ButtonWidth = 70
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList24Flat
      List = True
      ShowCaptions = True
      TabOrder = 0
      object FecharToolButton_BasTabSheet: TToolButton
        Left = 0
        Top = 0
        Action = FecharAction_ActBasForm
      end
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    Images = SisImgDataModule.ImageList24Flat
    inherited FecharAction_ActBasForm: TAction
      ImageIndex = 1
    end
  end
end

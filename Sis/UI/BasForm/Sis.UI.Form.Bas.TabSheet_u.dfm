inherited TabSheetBasForm: TTabSheetBasForm
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'TabSheetBasForm'
  ClientHeight = 477
  ClientWidth = 632
  OnClose = FormClose
  ExplicitHeight = 477
  TextHeight = 15
  object TitPanel_BasTabSheet: TPanel [0]
    Left = 0
    Top = 0
    Width = 632
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    ParentColor = True
    TabOrder = 0
    object TitToolBar1_BasTabSheet: TToolBar
      Left = 0
      Top = 0
      Width = 632
      Height = 30
      ButtonHeight = 21
      ButtonWidth = 47
      Caption = 'TitToolBar1_BasTabSheet'
      List = True
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    Images = nil
    inherited FecharAction_ActBasForm: TAction
      ImageIndex = 1
    end
  end
end

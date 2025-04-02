inherited TabSheetBasForm: TTabSheetBasForm
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'TabSheetBasForm'
  ClientHeight = 477
  ClientWidth = 632
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  ExplicitWidth = 632
  ExplicitHeight = 477
  TextHeight = 15
  object TitPanel_BasTabSheet: TPanel [0]
    Left = 0
    Top = 0
    Width = 632
    Height = 30
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Caption = ' '
    ParentColor = True
    TabOrder = 0
    object TitAuxPanel_BasTabSheet: TPanel
      Left = 492
      Top = 0
      Width = 140
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      Caption = '   '
      TabOrder = 0
      ExplicitLeft = 560
      ExplicitHeight = 49
    end
    object TitToolPanel_BasTabSheet: TPanel
      Left = 0
      Top = 0
      Width = 492
      Height = 30
      Align = alClient
      AutoSize = True
      BevelOuter = bvNone
      Caption = '   '
      TabOrder = 1
      ExplicitLeft = 8
      object TitToolBar1_BasTabSheet: TToolBar
        Left = 0
        Top = 0
        Width = 492
        Height = 30
        AutoSize = True
        ButtonHeight = 21
        ButtonWidth = 47
        Caption = 'TitToolBar1_BasTabSheet'
        List = True
        ShowCaptions = True
        TabOrder = 0
        Transparent = True
      end
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    Images = nil
    inherited FecharAction_ActBasForm: TAction
      ImageIndex = 1
    end
  end
end

inherited GerAppForm: TGerAppForm
  Caption = 'GerAppForm'
  ClientHeight = 241
  ClientWidth = 344
  ExplicitWidth = 356
  ExplicitHeight = 279
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
    ExplicitWidth = 340
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
  object BasePanel: TPanel [1]
    Left = 0
    Top = 216
    Width = 344
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 215
    ExplicitWidth = 340
    object SempreVisivelCheckBox: TCheckBox
      Left = -1
      Top = 1
      Width = 102
      Height = 17
      Caption = 'Sempre Vis'#237'vel'
      TabOrder = 0
      OnClick = SempreVisivelCheckBoxClick
    end
    object AutoOpenCheckBox: TCheckBox
      Left = 106
      Top = 1
      Width = 149
      Height = 17
      Caption = 'Abrir automaticamente'
      TabOrder = 1
      OnClick = AutoOpenCheckBoxClick
    end
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

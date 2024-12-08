inherited GerAppForm: TGerAppForm
  BorderStyle = bsNone
  BorderWidth = 2
  Caption = 'GerAppForm'
  ClientHeight = 496
  ClientWidth = 386
  ExplicitWidth = 390
  ExplicitHeight = 500
  TextHeight = 15
  object TitleBarPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 386
    Height = 41
    Cursor = crSizeAll
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    OnMouseDown = TitleBarPanelMouseDown
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
    Top = 471
    Width = 386
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
  object StatusFrameScrollBox: TScrollBox [2]
    Left = 0
    Top = 41
    Width = 386
    Height = 415
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    TabOrder = 2
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 96
    Top = 8
  end
  object TitActionList: TActionList
    Images = SisImgDataModule.ImageList_13_8
    Left = 24
    Top = 8
    object FecharAction_GerAppForm: TAction
      Caption = 'Fechar'
      OnExecute = FecharAction_GerAppFormExecute
    end
  end
  object ExecuteTimer: TTimer
    Enabled = False
    OnTimer = ExecuteTimerTimer
    Left = 208
    Top = 8
  end
end

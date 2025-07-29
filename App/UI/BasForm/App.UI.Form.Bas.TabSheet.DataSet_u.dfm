inherited TabSheetDataSetBasForm: TTabSheetDataSetBasForm
  Caption = 'TabSheetDataSetBasForm'
  ClientHeight = 443
  ClientWidth = 700
  WindowState = wsMaximized
  StyleElements = [seFont, seClient, seBorder]
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  ExplicitWidth = 700
  ExplicitHeight = 443
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 407
    Width = 700
    Height = 36
    Align = alBottom
    AutoSize = False
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 407
    ExplicitWidth = 700
    ExplicitHeight = 36
    inherited TitAuxPanel_BasTabSheet: TPanel
      Left = 560
      Height = 36
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 560
      ExplicitHeight = 36
      DesignSize = (
        140
        36)
      object QtdRegsLabel_TabSheetDataSetBasForm: TLabel
        Left = 45
        Top = 18
        Width = 90
        Height = 13
        Alignment = taRightJustify
        Anchors = [akRight, akBottom]
        Caption = 'Nenhum Registro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Visible = False
        StyleElements = [seClient, seBorder]
        ExplicitTop = 12
      end
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Width = 560
      Height = 36
      AutoSize = False
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 560
      ExplicitHeight = 36
      inherited TitToolBar1_BasTabSheet: TToolBar
        Width = 560
        ExplicitWidth = 560
      end
    end
  end
  object DBGrid1: TDBGrid [1]
    Left = 0
    Top = 0
    Width = 700
    Height = 407
    Align = alClient
    BorderStyle = bsNone
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
  end
  object SelectPanel: TPanel [2]
    Left = 264
    Top = 256
    Width = 76
    Height = 36
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    Visible = False
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 76
      Height = 36
      Align = alClient
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList24FlatSelect
      TabOrder = 0
      object OkToolButton_DataSetForm: TToolButton
        Left = 0
        Top = 0
        Action = OkAction
      end
      object CancelToolButton_DataSetForm: TToolButton
        Left = 31
        Top = 0
        Action = CancelAction
      end
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    object AtuAction_DatasetTabSheet: TAction
      Caption = 'Atualizar'
      OnExecute = AtuAction_DatasetTabSheetExecute
    end
    object InsAction_DatasetTabSheet: TAction
      Caption = 'Inserir'
      OnExecute = InsAction_DatasetTabSheetExecute
    end
    object AltAction_DatasetTabSheet: TAction
      Caption = 'Alterar'
      OnExecute = AltAction_DatasetTabSheetExecute
    end
    object ExclAction_DatasetTabSheet: TAction
      Caption = 'Excluir'
    end
  end
  object DataSource1: TDataSource
    Left = 176
    Top = 104
  end
  object FiltroAtualizarTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = FiltroAtualizarTimerTimer
    Left = 56
    Top = 112
  end
  object SelectActionList_DataSetForm: TActionList
    Images = SisImgDataModule.ImageList24FlatSelect
    Left = 424
    Top = 136
    object OkAction: TAction
      Caption = 'OkAction'
      Hint = 'Escolher o Registro Selecionado'
      ImageIndex = 1
      OnExecute = OkActionExecute
    end
    object CancelAction: TAction
      Caption = 'Cancelar'
      Hint = 'Cancelar'
      ImageIndex = 0
      OnExecute = CancelActionExecute
    end
  end
end

object ChildForm: TChildForm
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'ChildForm'
  ClientHeight = 441
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object GeralPanel: TPanel
    Left = 0
    Top = 0
    Width = 598
    Height = 441
    Align = alClient
    Caption = ' '
    ParentColor = True
    TabOrder = 0
    StyleElements = []
    object DBGrid1: TDBGrid
      Left = 1
      Top = 34
      Width = 596
      Height = 406
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = DataSource1
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 596
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      DesignSize = (
        596
        33)
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 121
        Height = 29
        Align = alNone
        ButtonHeight = 21
        ButtonWidth = 47
        Caption = 'ToolBar1'
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = InsAction
        end
        object ToolButton2: TToolButton
          Left = 47
          Top = 0
          Action = AlterarAction
        end
      end
      object ToolBar2: TToolBar
        Left = 534
        Top = 3
        Width = 150
        Height = 29
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 21
        ButtonWidth = 47
        Caption = 'ToolBar2'
        List = True
        ShowCaptions = True
        TabOrder = 1
        object ToolButton3: TToolButton
          Left = 0
          Top = 0
          Action = FecharAction
        end
      end
      object FiltroLabeledEdit: TLabeledEdit
        Left = 176
        Top = 4
        Width = 121
        Height = 23
        EditLabel.Width = 27
        EditLabel.Height = 23
        EditLabel.Caption = 'Filtro'
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 2
        Text = ''
        OnChange = FiltroLabeledEditChange
        OnKeyPress = FiltroLabeledEditKeyPress
      end
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Pr\app\bantu\bantu-sis\retag\dados.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 128
  end
  object ActionList1: TActionList
    Left = 40
    Top = 64
    object InsAction: TAction
      Caption = 'Inserir'
    end
    object AlterarAction: TAction
      Caption = 'Alterar'
    end
    object FecharAction: TAction
      Caption = 'Fechar'
      OnExecute = FecharActionExecute
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 136
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 224
    Top = 128
  end
  object CarregarTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = CarregarTimerTimer
    Left = 304
    Top = 64
  end
end

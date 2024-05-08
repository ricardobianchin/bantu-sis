inherited ImportProdBarrasListEdForm: TImportProdBarrasListEdForm
  Caption = 'Novo C'#243'digo de Barras'
  ClientHeight = 362
  ClientWidth = 419
  OnClose = FormClose
  ExplicitWidth = 431
  ExplicitHeight = 400
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 290
    Width = 419
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 347
    Width = 419
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 56
    Width = 127
    Height = 15
    Caption = 'Novos C'#243'digos de Barra'
  end
  inherited BasePanel: TPanel
    Top = 310
    Width = 419
    ExplicitTop = 230
    ExplicitWidth = 443
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 80
      ExplicitLeft = 104
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 193
      ExplicitLeft = 217
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 273
      ExplicitLeft = 297
    end
  end
  object BarrasLabeledEdit: TLabeledEdit [4]
    Left = 8
    Top = 24
    Width = 321
    Height = 23
    EditLabel.Width = 140
    EditLabel.Height = 15
    EditLabel.Caption = 'C'#243'digos de Barra Originais'
    ReadOnly = True
    TabOrder = 1
    Text = ''
  end
  object DBGrid1: TDBGrid [5]
    Left = 8
    Top = 72
    Width = 185
    Height = 162
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object ToolBar1: TToolBar [6]
    Left = 8
    Top = 240
    Width = 217
    Height = 29
    Align = alNone
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = SisImgDataModule.ImageList24FlatSelect
    TabOrder = 3
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = InserirAction
    end
    object ToolButton2: TToolButton
      Left = 31
      Top = 0
      Action = ExcluirAction
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 192
    Top = 24
  end
  inherited ActionList1_Diag: TActionList
    Left = 312
  end
  object ActionList1: TActionList
    Images = SisImgDataModule.ImageList24FlatSelect
    Left = 144
    Top = 208
    object InserirAction: TAction
      Caption = 'Inserir'
      Hint = 'Inserir'
      ImageIndex = 2
    end
    object ExcluirAction: TAction
      Caption = 'Excluir'
      Hint = 'Excluir'
      ImageIndex = 3
    end
  end
  object FDMemTable1: TFDMemTable
    Active = True
    BeforeInsert = FDMemTable1BeforeInsert
    FieldDefs = <
      item
        Name = 'CodBarras'
        DataType = ftString
        Size = 14
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 32
    Top = 120
    object FDMemTable1CodBarras: TStringField
      DisplayLabel = 'C'#243'digo de Barras'
      FieldName = 'CodBarras'
      Size = 14
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 128
    Top = 104
  end
end

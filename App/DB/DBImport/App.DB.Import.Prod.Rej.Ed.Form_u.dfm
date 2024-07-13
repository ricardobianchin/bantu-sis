inherited ProdRejEdForm: TProdRejEdForm
  Caption = 'Resolver Rejei'#231#227'o'
  ClientHeight = 282
  ClientWidth = 988
  ExplicitWidth = 1000
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 988
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 267
    Width = 988
  end
  inherited BasePanel: TPanel
    Top = 230
    Width = 988
    ExplicitWidth = 984
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 708
      ExplicitLeft = 704
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 821
      ExplicitLeft = 817
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 901
      ExplicitLeft = 897
    end
    object InclusaoBitBtn_DiagBtn: TBitBtn
      Left = 5
      Top = 5
      Width = 93
      Height = 25
      Action = InclusaoAction
      Caption = 'Alterar Inclus'#227'o'
      TabOrder = 3
    end
    object BarrasListEdBitBtn: TBitBtn
      Left = 102
      Top = 5
      Width = 110
      Height = 25
      Action = BarrasListEdAction
      Caption = 'C'#243'digo de Barras'
      TabOrder = 4
    end
    object DescrTrazerBitBtn: TBitBtn
      Left = 216
      Top = 5
      Width = 97
      Height = 25
      Action = DescrTrazerAction
      Caption = 'Trazer Descri'#231#227'o'
      TabOrder = 5
    end
    object DescrRedTrazerBitBtn: TBitBtn
      Left = 317
      Top = 5
      Width = 146
      Height = 25
      Action = DescrRedTrazerAction
      Caption = 'Trazer Descri'#231#227'o Reduzida'
      TabOrder = 6
    end
    object DescrsTrazerBitBtn: TBitBtn
      Left = 467
      Top = 5
      Width = 100
      Height = 25
      Action = DescrsTrazerAction
      Caption = 'Trazer Descri'#231#245'es'
      TabOrder = 7
    end
    object UnificarBitBtn: TBitBtn
      Left = 571
      Top = 5
      Width = 109
      Height = 25
      Action = UnificarAction
      Caption = 'Unificar Produtos'
      TabOrder = 8
    end
  end
  object ProdDBGrid: TDBGrid [3]
    Left = 0
    Top = 0
    Width = 988
    Height = 210
    Align = alClient
    BorderStyle = bsNone
    DataSource = ProdDataSource
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnColEnter = ProdDBGridColEnter
    OnEditButtonClick = ProdDBGridEditButtonClick
  end
  object ProdDataSource: TDataSource
    Left = 456
    Top = 16
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 352
    Top = 16
    object FDMemTable1id: TIntegerField
      FieldName = 'id'
    end
    object FDMemTable1descr: TStringField
      FieldName = 'descr'
      OnSetText = FDMemTable1descrSetText
      OnValidate = FDMemTable1descrValidate
      Size = 120
    end
  end
  object Edicao_ActionList: TActionList
    Left = 200
    Top = 104
    object InclusaoAction: TAction
      Caption = 'Alterar Inclus'#227'o'
      Hint = 'Liga / Desliga se Registro Ser'#225' Importado'
      OnExecute = InclusaoActionExecute
    end
    object BarrasListEdAction: TAction
      Caption = 'C'#243'digo de Barras'
      Hint = 'Edita c'#243'digs de barra deste registro'
      OnExecute = BarrasListEdActionExecute
    end
    object CopiarCelulaAction: TAction
      Caption = 'Copia C'#233'lula'
      OnExecute = CopiarCelulaActionExecute
    end
    object DescrTrazerAction: TAction
      Caption = 'Trazer Descri'#231#227'o'
      Hint = 'Copia a descri'#231#227'o original para a nova descri'#231#227'o'
      OnExecute = DescrTrazerActionExecute
    end
    object DescrRedTrazerAction: TAction
      Caption = 'Trazer Descri'#231#227'o Reduzida'
      Hint = 
        'Copia a descri'#231#227'o reduzida original para a nova descri'#231#227'o reduzi' +
        'da'
      OnExecute = DescrRedTrazerActionExecute
    end
    object DescrsTrazerAction: TAction
      Caption = 'Trazer Descri'#231#245'es'
      Hint = 'Copia as duas descri'#231'oes'
      OnExecute = DescrsTrazerActionExecute
    end
    object UnificarAction: TAction
      Caption = 'Unificar Produtos'
      Hint = 
        'Desabilita os demais produtos. Traz os c'#243'digos de barra para o p' +
        'roduto selecionado'
      OnExecute = UnificarActionExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 128
    object UnificarProdutos1: TMenuItem
      Action = UnificarAction
    end
    object CopiaClula1: TMenuItem
      Action = CopiarCelulaAction
    end
    object razerDescrio1: TMenuItem
      Action = DescrTrazerAction
    end
    object razerDescrioReduzida1: TMenuItem
      Action = DescrRedTrazerAction
    end
    object razerDescries1: TMenuItem
      Action = DescrsTrazerAction
    end
    object Incluso1: TMenuItem
      Action = InclusaoAction
    end
    object CdigodeBarras1: TMenuItem
      Action = BarrasListEdAction
    end
  end
end

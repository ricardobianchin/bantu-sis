inherited CxOperValoresEdForm: TCxOperValoresEdForm
  Caption = 'CxOperValoresEdForm'
  ClientHeight = 329
  ClientWidth = 578
  ExplicitWidth = 590
  ExplicitHeight = 367
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 257
    Width = 578
  end
  inherited ObjetivoLabel: TLabel
    Width = 578
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 277
    Width = 578
  end
  inherited BasePanel: TPanel
    Top = 292
    Width = 578
    ExplicitWidth = 574
  end
  inherited MeioPanel: TPanel
    Width = 578
    Height = 240
    ExplicitWidth = 574
    inherited TrabPanel: TPanel
      Width = 578
      Height = 240
      ExplicitHeight = 240
      inherited ObsPanel: TPanel
        Top = 157
        Width = 578
        ExplicitWidth = 574
        inherited Label2: TLabel
          Width = 578
        end
        inherited ObsMemo: TMemo
          Width = 578
          ExplicitTop = 21
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 578
        Height = 157
        Align = alClient
        DataSource = DataSource1
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgCancelOnExit, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Id'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Descr'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Valor'
            Title.Alignment = taRightJustify
            Width = 81
            Visible = True
          end>
      end
    end
  end
  object FDMemTable1: TFDMemTable
    Active = True
    OnNewRecord = FDMemTable1NewRecord
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftInteger
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Valor'
        DataType = ftCurrency
        Precision = 19
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
    Left = 424
    Top = 32
    object FDMemTable1Id: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Visible = False
    end
    object FDMemTable1Descr: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'Descr'
      Size = 200
    end
    object FDMemTable1Valor: TCurrencyField
      FieldName = 'Valor'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 328
    Top = 40
  end
end

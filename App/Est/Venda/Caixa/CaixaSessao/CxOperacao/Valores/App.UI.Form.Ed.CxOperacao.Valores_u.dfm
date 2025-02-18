inherited CxOperValoresEdForm: TCxOperValoresEdForm
  Caption = 'CxOperValoresEdForm'
  ClientWidth = 578
  ExplicitWidth = 590
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 578
  end
  inherited ObjetivoLabel: TLabel
    Width = 578
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 578
  end
  inherited BasePanel: TPanel
    Width = 578
    ExplicitWidth = 574
  end
  inherited MeioPanel: TPanel
    Width = 578
    ExplicitWidth = 574
    inherited TrabPanel: TPanel
      Width = 578
      ExplicitWidth = 574
      inherited ObsPanel: TPanel
        Width = 578
        ExplicitWidth = 574
        inherited Label2: TLabel
          Width = 578
        end
        inherited ObsMemo: TMemo
          Width = 578
          ExplicitWidth = 574
        end
      end
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
    Left = 424
    Top = 32
    object FDMemTable1Id: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
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
end

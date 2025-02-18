inherited CxOperValoresEdForm: TCxOperValoresEdForm
  Caption = 'CxOperValoresEdForm'
  ClientWidth = 578
  ExplicitWidth = 590
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 578
    ExplicitTop = 194
  end
  inherited ObjetivoLabel: TLabel
    Width = 578
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 578
    ExplicitTop = 214
  end
  inherited BasePanel: TPanel
    Width = 578
    ExplicitTop = 228
    ExplicitWidth = 574
    inherited OkBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
  end
  inherited MeioPanel: TPanel
    Width = 578
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
    Left = 32
    Top = 16
  end
end

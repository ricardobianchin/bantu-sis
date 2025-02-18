inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientWidth = 582
  ExplicitWidth = 594
  ExplicitHeight = 305
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 582
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 582
    Height = 17
    Align = alTop
    Font.Height = -13
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 16
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 582
  end
  inherited BasePanel: TPanel
    Width = 582
    ExplicitTop = 229
    ExplicitWidth = 578
    DesignSize = (
      582
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 143
      ExplicitLeft = 139
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 256
      ExplicitLeft = 252
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 357
      ExplicitLeft = 353
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 582
    Height = 178
    Align = alClient
    BevelOuter = bvNone
    Caption = '  '
    TabOrder = 1
    ExplicitWidth = 578
    ExplicitHeight = 177
    object TrabPanel: TPanel
      Left = 0
      Top = 0
      Width = 582
      Height = 178
      Align = alClient
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 0
      ExplicitWidth = 578
      ExplicitHeight = 177
      object ObsPanel: TPanel
        Left = 0
        Top = 95
        Width = 582
        Height = 83
        Align = alBottom
        BevelOuter = bvNone
        Caption = '  '
        TabOrder = 0
        ExplicitTop = 94
        ExplicitWidth = 578
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 582
          Height = 15
          Align = alTop
          Caption = 'Observa'#231#245'es (200 caracteres)'
          ExplicitWidth = 152
        end
        object ObsMemo: TMemo
          Left = 0
          Top = 15
          Width = 582
          Height = 68
          Align = alClient
          BorderStyle = bsNone
          MaxLength = 200
          TabOrder = 0
          WantReturns = False
          ExplicitWidth = 578
        end
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 160
  end
  inherited ActionList1_Diag: TActionList
    Left = 152
    Top = 160
  end
end

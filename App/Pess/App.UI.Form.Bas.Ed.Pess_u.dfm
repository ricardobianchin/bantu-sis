inherited PessEdBasForm: TPessEdBasForm
  Caption = 'PessEdBasForm'
  ClientWidth = 988
  ExplicitWidth = 1000
  ExplicitHeight = 319
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 988
    ExplicitTop = 209
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 988
    ExplicitTop = 229
  end
  object NomePessLabel: TLabel [3]
    Left = 8
    Top = 32
    Width = 33
    Height = 15
    Caption = 'Nome'
    FocusControl = NomePessEdit
  end
  inherited BasePanel: TPanel
    Width = 988
    ExplicitTop = 243
    ExplicitWidth = 431
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 593
      ExplicitLeft = 36
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 706
      ExplicitLeft = 149
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 786
      ExplicitLeft = 229
    end
  end
  object NomePessEdit: TEdit [5]
    Left = 48
    Top = 29
    Width = 480
    Height = 23
    MaxLength = 60
    TabOrder = 1
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 64
    Top = 128
  end
  inherited ActionList1_Diag: TActionList
    Left = 160
    Top = 160
  end
end

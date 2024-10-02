inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'TerminalEdDiagForm'
  ExplicitWidth = 451
  ExplicitHeight = 319
  TextHeight = 15
  inherited MensLabel: TLabel
    ExplicitTop = 209
  end
  inherited AlteracaoTextoLabel: TLabel
    ExplicitTop = 266
  end
  object ObjetivoLabel: TLabel [2]
    Left = 2
    Top = 8
    Width = 27
    Height = 15
    Caption = '         '
  end
  object TerminalIdTitLabel: TLabel [3]
    Left = 2
    Top = 30
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object TerminalIdEdit: TEdit [5]
    Left = 48
    Top = 27
    Width = 41
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 1
    Text = '123'
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 56
    Top = 96
  end
  inherited ActionList1_Diag: TActionList
    Left = 176
    Top = 104
  end
end

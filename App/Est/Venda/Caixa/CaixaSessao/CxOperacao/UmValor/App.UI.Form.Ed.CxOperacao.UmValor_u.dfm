inherited CxOperUmValorEdForm: TCxOperUmValorEdForm
  Caption = 'CxOperUmValorEdForm'
  ClientHeight = 562
  ClientWidth = 788
  ExplicitTop = -288
  ExplicitWidth = 800
  ExplicitHeight = 600
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 490
    Width = 788
    ExplicitTop = 194
  end
  inherited ObjetivoLabel: TLabel
    Width = 788
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 510
    Width = 788
    ExplicitTop = 214
  end
  inherited BasePanel: TPanel
    Top = 525
    Width = 788
    ExplicitTop = 228
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 349
      ExplicitLeft = -12
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 462
      ExplicitLeft = 101
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 563
      ExplicitLeft = 202
    end
  end
  object ValorPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 788
    Height = 64
    Align = alTop
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 427
    object ValorEdit: TEdit
      Left = 171
      Top = 3
      Width = 81
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '12345.65'
      StyleElements = [seClient, seBorder]
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 81
    Width = 788
    Height = 403
    Align = alTop
    Caption = ' '
    TabOrder = 2
  end
  object ValorRadioButton: TRadioButton [6]
    Left = 7
    Top = 26
    Width = 158
    Height = 17
    Caption = 'F3 - Indicar o valor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object NumerarioRadioButton: TRadioButton [7]
    Left = 8
    Top = 87
    Width = 281
    Height = 17
    Caption = 'F3 - Indicar a quantidade de notas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end

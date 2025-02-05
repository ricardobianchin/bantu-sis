inherited BalancaVendaForm: TBalancaVendaForm
  BorderStyle = bsNone
  Caption = 'BalancaVendaForm'
  ClientHeight = 194
  ClientWidth = 506
  ExplicitWidth = 506
  ExplicitHeight = 194
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 174
    Width = 506
    ExplicitTop = 174
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 159
    Width = 506
    ExplicitTop = 159
  end
  object FundoPanel: TPanel [2]
    Left = 0
    Top = 0
    Width = 506
    Height = 159
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object TitLabel: TLabel
      Left = 24
      Top = 3
      Width = 433
      Height = 34
      Alignment = taCenter
      AutoSize = False
      Caption = 'Ler Peso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
    end
    object StatusLabel: TLabel
      Left = 24
      Top = 72
      Width = 433
      Height = 36
      Alignment = taCenter
      AutoSize = False
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
  end
  inherited ActionList1_Diag: TActionList
    Left = 64
    Top = 16
  end
end

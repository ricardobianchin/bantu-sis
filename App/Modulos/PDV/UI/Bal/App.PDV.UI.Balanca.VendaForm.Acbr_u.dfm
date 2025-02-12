inherited BalancaAcbrVendaForm: TBalancaAcbrVendaForm
  Caption = 'BalancaAcbrVendaForm'
  TextHeight = 15
  inherited FundoPanel: TPanel
    inherited TitLabel: TLabel
      Left = 1
      Top = 1
      Width = 504
      Align = alTop
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 504
    end
    inherited StatusLabel: TLabel
      Left = 1
      Top = 35
      Width = 504
      Align = alTop
      Caption = ''
      Font.Height = -24
      ExplicitLeft = 1
      ExplicitTop = 32
      ExplicitWidth = 504
    end
    object RespostaLabel: TLabel
      Left = 1
      Top = 71
      Width = 504
      Height = 50
      Align = alTop
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
  end
  object ACBrBAL1: TACBrBAL
    Porta = 'COM1'
    OnLePeso = ACBrBAL1LePeso
    Left = 288
    Top = 32
  end
end

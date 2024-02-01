object SessaoFrame: TSessaoFrame
  Left = 0
  Top = 0
  Width = 384
  Height = 42
  Align = alTop
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 42
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object ApelidoLabel: TLabel
      Left = 112
      Top = 4
      Width = 67
      Height = 15
      Caption = 'Joao da Silva'
    end
    object ModuloLabel: TLabel
      Left = 114
      Top = 20
      Width = 60
      Height = 15
      Caption = 'Retaguarda'
    end
    object ApelidoTitLabel: TLabel
      Left = 64
      Top = 4
      Width = 43
      Height = 15
      Caption = 'Usu'#225'rio:'
    end
    object ModuloTitLabel: TLabel
      Left = 64
      Top = 20
      Width = 45
      Height = 15
      Caption = 'Modulo:'
    end
    object AbrirButton: TButton
      Left = 8
      Top = 8
      Width = 46
      Height = 25
      Action = AbrirAction
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    Left = 216
    Top = 6
    object AbrirAction: TAction
      Caption = 'Abrir'
      OnExecute = AbrirActionExecute
    end
  end
end

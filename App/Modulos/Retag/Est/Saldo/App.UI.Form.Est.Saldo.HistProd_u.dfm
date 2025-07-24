inherited EstSaldoHistProdForm: TEstSaldoHistProdForm
  Caption = 'Hist'#243'rico de Saldo'
  ClientHeight = 561
  ClientWidth = 557
  Position = poDefaultPosOnly
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  ExplicitWidth = 573
  ExplicitHeight = 600
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 557
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 536
    object ProdIdTopoLabel: TLabel
      Left = 1
      Top = 3
      Width = 42
      Height = 15
      Caption = '0000000'
    end
    object DescrTopoLabel: TLabel
      Left = 56
      Top = 3
      Width = 83
      Height = 15
      Caption = 'DescrTopoLabel'
    end
    object SempreVisivelCheckBox: TCheckBox
      Left = 1
      Top = 23
      Width = 102
      Height = 17
      Caption = 'Sempre Vis'#237'vel'
      TabOrder = 0
      OnClick = SempreVisivelCheckBoxClick
    end
  end
  object MeioPanel: TPanel [1]
    Left = 0
    Top = 41
    Width = 557
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 8
    ExplicitWidth = 536
    ExplicitHeight = 41
  end
end

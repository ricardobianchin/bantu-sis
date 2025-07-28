inherited EstSaldoHistProdForm: TEstSaldoHistProdForm
  Caption = 'Hist'#243'rico de Saldo'
  ClientHeight = 264
  ClientWidth = 516
  Position = poDefaultPosOnly
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  ExplicitWidth = 532
  ExplicitHeight = 303
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 516
    Height = 15
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ProdIdTopoLabel: TLabel
      Left = 1
      Top = 0
      Width = 42
      Height = 15
      Caption = '0000000'
    end
    object DescrTopoLabel: TLabel
      Left = 50
      Top = 0
      Width = 83
      Height = 15
      Caption = 'DescrTopoLabel'
    end
  end
  object MeioPanel: TPanel [1]
    Left = 0
    Top = 15
    Width = 516
    Height = 224
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 45
    ExplicitHeight = 223
  end
  object BasePanel: TPanel [2]
    Left = 0
    Top = 239
    Width = 516
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 240
    object SempreVisivelCheckBox: TCheckBox
      Left = 8
      Top = 2
      Width = 102
      Height = 17
      Caption = 'Sempre Vis'#237'vel'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = SempreVisivelCheckBoxClick
    end
    object ToolBar1: TToolBar
      Left = 117
      Top = 0
      Width = 225
      Height = 29
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 58
      Caption = 'ToolBar1'
      List = True
      ShowCaptions = True
      TabOrder = 1
      object AtuToolButton: TToolButton
        Left = 0
        Top = 0
        Action = AtuAction
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 184
    Top = 64
  end
  object ActionList1: TActionList
    Left = 40
    Top = 65
    object AtuAction: TAction
      Caption = 'Atualizar'
      OnExecute = AtuActionExecute
    end
  end
end

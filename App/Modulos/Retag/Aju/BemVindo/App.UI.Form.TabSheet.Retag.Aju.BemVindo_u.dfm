inherited RetagAjuBemVindoForm: TRetagAjuBemVindoForm
  Caption = 'Bem-vindo!'
  Color = 16444627
  StyleElements = []
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object SaudacaoLabel: TLabel [0]
    Left = 0
    Top = 0
    Width = 632
    Height = 15
    Align = alTop
    Caption = '                  '
    ExplicitWidth = 54
  end
  inherited TitPanel_BasTabSheet: TPanel
    Top = 456
    Align = alBottom
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 456
  end
  object DireitaPanel: TPanel [2]
    Left = 447
    Top = 15
    Width = 185
    Height = 441
    Align = alRight
    BevelOuter = bvNone
    Caption = ' '
    ParentBackground = False
    TabOrder = 1
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 185
      Height = 15
      Align = alTop
      Alignment = taCenter
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 35
    end
    object ProdutosGroupBox: TGroupBox
      Left = 0
      Top = 15
      Width = 185
      Height = 39
      Align = alTop
      Caption = 'Produtos'
      ParentBackground = False
      TabOrder = 0
      object ProdQtdTitLabel: TLabel
        Left = 8
        Top = 16
        Width = 68
        Height = 15
        Caption = 'Quantidade: '
      end
      object ProdQtdLabel: TLabel
        Left = 79
        Top = 16
        Width = 73
        Height = 15
        Caption = 'ProdQtdLabel'
      end
    end
    object DireitaBasePanel: TPanel
      Left = 0
      Top = 392
      Width = 185
      Height = 49
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object ToolBar1: TToolBar
        Left = 3
        Top = 0
        Width = 53
        Height = 23
        Align = alNone
        AutoSize = True
        ButtonHeight = 23
        ButtonWidth = 53
        Caption = 'ToolBar1'
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Hint = 'Atualizar (F5)'
          Action = AtualizarAction
        end
      end
    end
  end
  object TerminaisGroupBox: TGroupBox [3]
    Left = 8
    Top = 21
    Width = 377
    Height = 164
    Caption = 'Terminais'
    TabOrder = 2
    Visible = False
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 384
    Top = 96
  end
  inherited ActionList1_ActBasForm: TActionList
    Left = 176
    Top = 152
    object AtualizarAction: TAction
      Caption = 'Atualizar'
      OnExecute = AtualizarActionExecute
    end
  end
end

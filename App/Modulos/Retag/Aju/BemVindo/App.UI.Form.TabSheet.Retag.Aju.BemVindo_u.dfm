inherited RetagAjuBemVindoForm: TRetagAjuBemVindoForm
  Caption = 'Bem-vindo!'
  Color = 16444627
  StyleElements = []
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object SaudacaoLabel: TLabel [0]
    Left = 0
    Top = 21
    Width = 632
    Height = 15
    Align = alTop
    Caption = '                  '
    ExplicitWidth = 54
  end
  object DireitaPanel: TPanel [2]
    Left = 447
    Top = 36
    Width = 185
    Height = 441
    Align = alRight
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object ProdutosGroupBox: TGroupBox
      Left = 0
      Top = 0
      Width = 185
      Height = 49
      Align = alTop
      Caption = 'Produtos'
      TabOrder = 0
      object ProdQtdTitLabel: TLabel
        Left = 8
        Top = 19
        Width = 68
        Height = 15
        Caption = 'Quantidade: '
      end
      object ProdQtdLabel: TLabel
        Left = 81
        Top = 19
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
        Left = 0
        Top = 0
        Width = 185
        Height = 23
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
  object ProdQtdZeroNotifyItemPanel: TPanel [3]
    Left = 48
    Top = 42
    Width = 361
    Height = 63
    Caption = ' '
    TabOrder = 2
    Visible = False
    object Label1: TLabel
      Left = 2
      Top = 1
      Width = 354
      Height = 30
      AutoSize = False
      Caption = 
        'Foi detectado que n'#227'o h'#225' produtos cadastrados. Deseja importar o' +
        's dados?'
      WordWrap = True
    end
    object DadosImportarButton: TButton
      Left = 112
      Top = 34
      Width = 116
      Height = 25
      Caption = 'Importar dados...'
      TabOrder = 0
      OnClick = DadosImportarButtonClick
    end
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

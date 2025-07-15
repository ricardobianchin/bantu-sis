inherited SessFormFiltroFrame: TSessFormFiltroFrame
  Width = 1036
  Height = 91
  ExplicitWidth = 1036
  ExplicitHeight = 91
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 1036
    Height = 91
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ErroLabel: TLabel
      Left = 6
      Top = 76
      Width = 3
      Height = 13
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object SessTitLabel: TLabel
      Left = 8
      Top = 26
      Width = 51
      Height = 15
      Caption = 'Aberturas'
    end
    object TitPanel: TPanel
      Left = 0
      Top = 0
      Width = 1036
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = '  '
      Color = 13023391
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      DesignSize = (
        1036
        18)
      object TitLabel: TLabel
        Left = 8
        Top = -1
        Width = 29
        Height = 17
        Caption = 'Filtro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object TitToolBar: TToolBar
        Left = 965
        Top = 2
        Width = 42
        Height = 14
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 14
        ButtonWidth = 20
        Caption = 'TitToolBar'
        Images = SisImgDataModule.ImageList_13_8_Preto
        TabOrder = 0
        Transparent = True
        Visible = False
        StyleElements = []
        object TitFecharToolButton: TToolButton
          Left = 0
          Top = 0
          Hint = 'Ocultar'
          Caption = 'TitFecharToolButton'
          ImageIndex = 0
        end
      end
    end
    object VendaCheckBox: TCheckBox
      Left = 120
      Top = 53
      Width = 61
      Height = 17
      Caption = 'Vendas'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = VendaCheckBoxClick
    end
    object CxOperCheckBox: TCheckBox
      Left = 7
      Top = 53
      Width = 109
      Height = 17
      Caption = 'Rotinas de caixa'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CxOperCheckBoxClick
    end
    object VendasPanel: TPanel
      Left = 185
      Top = 51
      Width = 920
      Height = 23
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 3
      object PagFormaLabel: TLabel
        Left = 5
        Top = 3
        Width = 114
        Height = 15
        Caption = 'Forma de Pagamento'
      end
      object PagFormaComboBox: TComboBox
        Left = 123
        Top = 0
        Width = 155
        Height = 23
        Style = csDropDownList
        TabOrder = 0
        OnChange = PagFormaComboBoxChange
      end
      object ProdLabeledEdit: TLabeledEdit
        Left = 339
        Top = 0
        Width = 350
        Height = 23
        EditLabel.Width = 43
        EditLabel.Height = 23
        EditLabel.Caption = 'Produto'
        LabelPosition = lpLeft
        LabelSpacing = 4
        TabOrder = 1
        Text = ''
        StyleElements = []
        OnClick = ProdLabeledEditClick
      end
      object ProdToolBar: TToolBar
        Left = 693
        Top = 0
        Width = 49
        Height = 25
        Align = alNone
        Caption = 'ToolBar2'
        Images = SisImgDataModule.ImageList16Flat
        TabOrder = 2
        object ProdSelectToolButton: TToolButton
          Left = 0
          Top = 0
          Action = ProdSelectAction
        end
        object ProdLimparToolButton: TToolButton
          Left = 23
          Top = 0
          CustomHint = SisImgDataModule.BalloonHint1
          Action = ProdLimparAction
        end
      end
    end
    object FiltroToolBar: TToolBar
      Left = 930
      Top = 49
      Width = 150
      Height = 29
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 79
      Caption = 'FiltroToolBar'
      List = True
      ShowCaptions = True
      TabOrder = 4
      object LimparFiltroToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FiltroLimparAction
      end
    end
    object SessComboBox: TComboBox
      Left = 65
      Top = 23
      Width = 384
      Height = 23
      Style = csDropDownList
      TabOrder = 5
      OnChange = SessComboBoxChange
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 130
    Top = 28
  end
  object ActionList1: TActionList
    Images = SisImgDataModule.ImageList16Flat
    Left = 603
    object ProdSelectAction: TAction
      Caption = 'ProdSelectAction'
      Hint = 'Selecione o Produto'
      ImageIndex = 1
      OnExecute = ProdSelectActionExecute
    end
    object ProdLimparAction: TAction
      Caption = 'ProdLimparAction'
      Hint = 'Limpar Produto'
      ImageIndex = 7
      OnExecute = ProdLimparActionExecute
    end
    object FiltroLimparAction: TAction
      Caption = 'Limpar Filtro'
      OnExecute = FiltroLimparActionExecute
    end
  end
end

inherited SessFormFiltroFrame: TSessFormFiltroFrame
  Width = 1000
  Height = 48
  ExplicitWidth = 1000
  ExplicitHeight = 48
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 1000
    Height = 48
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ErroLabel: TLabel
      Left = 6
      Top = 46
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
    object TitPanel: TPanel
      Left = 0
      Top = 0
      Width = 1000
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
        1000
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
      object ToolBar1: TToolBar
        Left = 929
        Top = 2
        Width = 42
        Height = 14
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 14
        ButtonWidth = 20
        Caption = 'ToolBar1'
        Images = SisImgDataModule.ImageList_13_8_Preto
        TabOrder = 0
        Transparent = True
        Visible = False
        StyleElements = []
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Hint = 'Ocultar'
          Caption = 'ToolButton1'
          ImageIndex = 0
        end
      end
    end
    object VendaCheckBox: TCheckBox
      Left = 120
      Top = 23
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
      Top = 23
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
      Top = 21
      Width = 920
      Height = 23
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 3
      object PagFormaLabel: TLabel
        Left = 1
        Top = 3
        Width = 114
        Height = 15
        Caption = 'Forma de Pagamento'
      end
      object PagFormaComboBox: TComboBox
        Left = 119
        Top = 0
        Width = 155
        Height = 23
        TabOrder = 0
        Text = 'CRE CREDICARD'
        OnChange = PagFormaComboBoxChange
      end
      object ProdLabeledEdit: TLabeledEdit
        Left = 328
        Top = 0
        Width = 321
        Height = 23
        EditLabel.Width = 43
        EditLabel.Height = 23
        EditLabel.Caption = 'Produto'
        LabelPosition = lpLeft
        LabelSpacing = 4
        TabOrder = 1
        Text = '1234567 - UUUUUUUUUXUUUUUUUUUXUUUUUUUUUX'
      end
      object ProdToolBar: TToolBar
        Left = 652
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
        object ToolButton2: TToolButton
          Left = 23
          Top = 0
          CustomHint = SisImgDataModule.BalloonHint1
          Action = ProdLimparAction
        end
      end
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 210
    Top = 4
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
  end
end

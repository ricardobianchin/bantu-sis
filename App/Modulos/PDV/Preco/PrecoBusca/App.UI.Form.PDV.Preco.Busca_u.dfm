inherited PrecoBuscaForm: TPrecoBuscaForm
  Caption = 'PrecoBuscaForm'
  ClientHeight = 272
  ClientWidth = 688
  ExplicitWidth = 700
  ExplicitHeight = 310
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 252
    Width = 688
    ExplicitTop = 252
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 237
    Width = 688
    ExplicitTop = 237
  end
  object FundoPanel: TPanel [2]
    Left = 8
    Top = 16
    Width = 672
    Height = 193
    Caption = ' '
    TabOrder = 0
    object BasePanel: TPanel
      Left = 1
      Top = 120
      Width = 670
      Height = 46
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 407
    end
    object TitleBarPanel: TPanel
      Left = 1
      Top = 1
      Width = 670
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = '   '
      Color = 3813420
      ParentBackground = False
      TabOrder = 1
      StyleElements = []
      ExplicitWidth = 407
      DesignSize = (
        670
        41)
      object TitleBarCaptionLabel: TLabel
        Left = 25
        Top = 9
        Width = 91
        Height = 21
        Caption = 'Busca Pre'#231'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        StyleElements = []
      end
      object ToolBar1: TToolBar
        Left = 625
        Top = 9
        Width = 101
        Height = 29
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonWidth = 47
        Caption = 'ToolBar1'
        Color = 3813420
        Flat = False
        Images = SisImgDataModule.ImageList_40_24
        ParentColor = False
        TabOrder = 0
        Transparent = True
        StyleElements = []
        ExplicitLeft = 362
        object MinimizeToolButton: TToolButton
          Left = 0
          Top = 0
        end
        object FecharToolButton: TToolButton
          Left = 47
          Top = 0
        end
      end
    end
    object Edit1: TEdit
      Left = 144
      Top = 56
      Width = 121
      Height = 23
      TabOrder = 2
      Text = 'Edit1'
    end
    object StatusPanel: TPanel
      Left = 1
      Top = 166
      Width = 670
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Caption = '   '
      TabOrder = 3
      DesignSize = (
        670
        26)
      object TempoPanel: TPanel
        Left = 404
        Top = 2
        Width = 263
        Height = 20
        Anchors = [akTop, akRight]
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 1
        object TempoLabel_PrecoBuscaForm: TLabel
          Left = 3
          Top = 2
          Width = 79
          Height = 15
          Caption = 'Consultado em:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
      end
      object AjudaPanel: TPanel
        Left = 1
        Top = 3
        Width = 338
        Height = 19
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 0
        object AjudaLabel_PrecoBuscaForm: TLabel
          Left = 3
          Top = 2
          Width = 336
          Height = 15
          Caption = 
            '[Esc]-Sair   [Enter]-Busca Novamente   ['#8593']['#8595'][PgUp][PgDn]-Navega' +
            'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
end
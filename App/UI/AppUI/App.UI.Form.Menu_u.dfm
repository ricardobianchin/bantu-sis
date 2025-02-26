inherited AppMenuForm: TAppMenuForm
  Caption = 'AppMenuForm'
  ClientHeight = 500
  ClientWidth = 800
  ExplicitLeft = -162
  ExplicitWidth = 800
  ExplicitHeight = 500
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 480
    Width = 800
    ExplicitTop = 480
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 465
    Width = 800
    ExplicitTop = 465
  end
  inherited FundoPanel_AppMenuForm: TPanel
    Width = 800
    Height = 465
    ExplicitWidth = 800
    ExplicitHeight = 465
    object StatusPanel: TPanel [0]
      Left = 1
      Top = 438
      Width = 798
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Caption = '   '
      TabOrder = 0
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
          Width = 60
          Height = 15
          Caption = '[Esc]-Fechar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object TitleBarPanel: TPanel [1]
      Left = 1
      Top = 1
      Width = 798
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = '   '
      Color = 3813420
      ParentBackground = False
      TabOrder = 1
      StyleElements = []
      DesignSize = (
        798
        41)
      object TitleBarCaptionLabel: TLabel
        Left = 25
        Top = 9
        Width = 75
        Height = 21
        Caption = 'F2 - Menu'
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
        Left = 755
        Top = 9
        Width = 54
        Height = 29
        Hint = 'Esc - Fechar'
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 24
        ButtonWidth = 47
        Caption = 'ToolBar1'
        Color = 3813420
        Flat = False
        Images = SisImgDataModule.ImageList_40_24
        ParentColor = False
        TabOrder = 0
        Transparent = True
        StyleElements = []
        object FecharToolButton: TToolButton
          Left = 0
          Top = 0
          Hint = 'Esc - Fechar'
          Caption = 'CancelAct_Diag'
          ImageIndex = 0
          OnClick = FecharToolButtonClick
        end
      end
    end
    inherited BotoesPanel: TPanel
      Left = 1
      Top = 42
      Width = 798
      Height = 396
      Align = alClient
      TabOrder = 2
      ExplicitLeft = 1
      ExplicitTop = 42
      ExplicitWidth = 798
      ExplicitHeight = 396
    end
  end
end

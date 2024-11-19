inherited AppMenuForm: TAppMenuForm
  BorderStyle = bsNone
  Caption = 'AppMenuForm'
  ClientHeight = 395
  ClientWidth = 475
  ExplicitHeight = 395
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 375
    Width = 475
    ExplicitTop = 375
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 360
    Width = 475
    ExplicitTop = 360
  end
  object FundoPanel_AppMenuForm: TPanel [2]
    Left = 0
    Top = 0
    Width = 475
    Height = 360
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object FecharModuloButton_AppMenuForm: TButton
      Left = 255
      Top = 48
      Width = 108
      Height = 25
      Caption = 'F4 - Fechar PDV'
      TabOrder = 2
      OnClick = FecharModuloButton_AppMenuFormClick
    end
    object OcultarModuloButton_AppMenuForm: TButton
      Left = 143
      Top = 48
      Width = 106
      Height = 25
      Caption = 'F3 - Ocultar PDV'
      TabOrder = 1
      OnClick = OcultarModuloButton_AppMenuFormClick
    end
    object OcultarMenuButton_AppMenuForm: TButton
      Left = 7
      Top = 48
      Width = 130
      Height = 25
      Caption = 'Esc - Fechar este Menu'
      TabOrder = 0
      OnClick = OcultarMenuButton_AppMenuFormClick
    end
    object StatusPanel: TPanel
      Left = 1
      Top = 333
      Width = 473
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Caption = '   '
      TabOrder = 3
      ExplicitTop = 166
      ExplicitWidth = 670
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
    object TitleBarPanel: TPanel
      Left = 1
      Top = 1
      Width = 473
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = '   '
      Color = 3813420
      ParentBackground = False
      TabOrder = 4
      StyleElements = []
      ExplicitWidth = 670
      DesignSize = (
        473
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
        Left = 428
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
        end
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 24
    Top = 104
  end
  inherited ActionList1_Diag: TActionList
    Left = 144
    Top = 128
  end
end

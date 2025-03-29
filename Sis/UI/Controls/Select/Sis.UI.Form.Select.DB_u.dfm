inherited DBSelectForm: TDBSelectForm
  Caption = 'DBSelectForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited FundoPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited BasePanel: TPanel
      Top = 296
      Height = 15
      AutoSize = True
      StyleElements = [seClient, seBorder]
      ExplicitTop = 296
      ExplicitHeight = 15
      inherited QtdRegsLabel: TLabel
        Left = 616
        Top = 0
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 616
        ExplicitTop = 0
      end
    end
    object TitleBarPanel: TPanel
      Left = 1
      Top = 1
      Width = 631
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = '   '
      Color = 3813420
      ParentBackground = False
      TabOrder = 1
      StyleElements = []
      DesignSize = (
        631
        41)
      object TitleBarCaptionLabel: TLabel
        Left = 25
        Top = 9
        Width = 86
        Height = 21
        Caption = 'Selecione...'
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
        Left = 595
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
end

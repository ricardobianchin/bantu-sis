object RetagPrincForm: TRetagPrincForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Retagaurda'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object TopoPanel: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    Color = 10116628
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    StyleElements = [seBorder]
    DesignSize = (
      640
      37)
    object UsuLabel: TLabel
      Left = 394
      Top = 10
      Width = 48
      Height = 15
      Alignment = taRightJustify
      Caption = 'UsuLabel'
      StyleElements = [seClient, seBorder]
    end
    object Label1: TLabel
      Left = 49
      Top = 5
      Width = 98
      Height = 25
      Caption = 'Retaguarda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Image2: TImage
      Left = 7
      Top = 2
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF400000006624B474400FF00FF00FFA0BDA793000001
        614944415478DAED94CF4AC34010C6E70B16357F482AF6D093D09327CF222882
        4F21A8687BF60D7AF5312A22083E81473D78F1EE45849E04157A6863CD82881D
        87868206B5691AB729E43B4D766632BFD9D95DD084851C2007C80C007702D65A
        D8B3904D8081E33731F30C05C1226CFB3949E1689DD101DA4155B22A1257D70E
        20DD17C8577762CE926B2E01F8D00BE0BFEE12E334FCEA6DC1732EB5017CE9BE
        122EE00C4573471FC0A07BD02331956549D1BB2AA354EAA60EF0E79564DE2783
        6A02B32E203514AD637EE07972D48D7857A2E1D186C60568CAE15BA68EDA93CC
        0681AFE1DA1B12DF105FF5A784440043B7B1D572A8603E8969CA2E1CC95FEAFD
        91F478150BF6EDD8238839CBEF5D03DB70CDF318792901B4BB9B04E32A2C4E27
        70AD8398E029013043AEE5BD982F722ED6E4517AD30AD0CFF1D521B171016FAE
        193B274D80241A0AA04BD90348A234C6363D00A38E282ED4F400FC9772808903
        7C02C526FA21D9544B060000000049454E44AE426082}
    end
    object TopoToolBar: TToolBar
      Left = 440
      Top = 0
      Width = 220
      Height = 35
      Align = alNone
      Anchors = [akTop, akRight]
      ButtonHeight = 38
      ButtonWidth = 47
      Caption = 'TopoToolBar'
      Images = SisImgDataModule.ImageList_40_24
      TabOrder = 0
      StyleElements = [seFont, seBorder]
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = LoginAction
      end
      object ToolButton2: TToolButton
        Left = 47
        Top = 0
        Action = LogoffAction
      end
      object ToolButton3: TToolButton
        Left = 94
        Top = 0
        Action = MinimizarAction
      end
      object ToolButton4: TToolButton
        Left = 141
        Top = 0
        Action = FecharAction
      end
    end
  end
  object basePanel: TPanel
    Left = 0
    Top = 451
    Width = 640
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
  end
  object ToolsLeftPanel: TPanel
    Left = 0
    Top = 37
    Width = 172
    Height = 414
    Align = alLeft
    BevelOuter = bvNone
    Caption = ' '
    Color = 10116628
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    StyleElements = []
    ExplicitTop = 35
    ExplicitHeight = 416
    object EstoqueMenuPanel: TPanel
      Left = 0
      Top = 0
      Width = 172
      Height = 23
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      ParentColor = True
      TabOrder = 0
      StyleElements = []
      object EstoqueTitMenuLabel: TLabel
        Left = 0
        Top = 0
        Width = 172
        Height = 23
        Align = alTop
        AutoSize = False
        Caption = 'Estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        StyleElements = []
        OnClick = EstoqueTitMenuLabelClick
      end
    end
    object SistemaMenuPanel: TPanel
      Left = 0
      Top = 23
      Width = 172
      Height = 15
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      ParentColor = True
      TabOrder = 1
      StyleElements = []
      object SistemaTitMenuLabel: TLabel
        Left = 0
        Top = 0
        Width = 172
        Height = 15
        Align = alTop
        Caption = 'Sistema'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        StyleElements = []
        OnClick = SistemaTitMenuLabelClick
        ExplicitWidth = 44
      end
    end
  end
  object PageControl1: TPageControl
    Left = 172
    Top = 37
    Width = 468
    Height = 414
    Align = alClient
    TabOrder = 3
    StyleElements = []
    ExplicitTop = 35
    ExplicitHeight = 416
  end
  object TopoActionList: TActionList
    Images = SisImgDataModule.ImageList_40_24
    Left = 376
    Top = 168
    object FecharAction: TAction
      Caption = 'FecharAction'
      Hint = 'Sair do sistema'
      ImageIndex = 0
      OnExecute = FecharActionExecute
    end
    object LoginAction: TAction
      Caption = 'Entrar'
      Hint = 'Iniciar o uso do sistema'
      ImageIndex = 3
      OnExecute = LoginActionExecute
    end
    object LogoffAction: TAction
      Caption = 'Sair'
      Hint = 'Fechar o uso do sistema'
      ImageIndex = 2
      OnExecute = LogoffActionExecute
    end
    object MinimizarAction: TAction
      Caption = 'Minimizar'
      ImageIndex = 1
      OnExecute = MinimizarActionExecute
    end
  end
  object MenuActionList: TActionList
    Left = 376
    Top = 252
    object CategoriasAction: TAction
      Caption = 'Categorias de produtos'
      OnExecute = CategoriasActionExecute
    end
    object UsuCategAction: TAction
      Caption = 'Categorias de usu'#225'rios'
      OnExecute = UsuCategActionExecute
    end
  end
  object ShowTimer: TTimer
    Enabled = False
    OnTimer = ShowTimerTimer
    Left = 376
    Top = 320
  end
  object BalloonHint1: TBalloonHint
    Left = 216
    Top = 104
  end
  object BalloonCloseTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = BalloonCloseTimerTimer
    Left = 224
    Top = 232
  end
end

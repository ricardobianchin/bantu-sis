inherited PrincBasForm: TPrincBasForm
  BorderStyle = bsNone
  Caption = 'PrincBasForm'
  ClientHeight = 477
  ClientWidth = 628
  ExplicitWidth = 628
  ExplicitHeight = 477
  DesignSize = (
    628
    477)
  TextHeight = 15
  object Logo1Image: TImage [0]
    Left = 0
    Top = 41
    Width = 628
    Height = 100
    Align = alTop
    Center = True
  end
  object DtHCompileLabel: TLabel [1]
    Left = 24
    Top = 454
    Width = 94
    Height = 15
    Cursor = crHandPoint
    Caption = 'DtHCompileLabel'
    StyleElements = []
    OnClick = DtHCompileLabelClick
  end
  object TitleBarPanel: TPanel [2]
    Left = 0
    Top = 0
    Width = 628
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = '   '
    Color = 3813420
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    OnMouseDown = TitleBarPanelMouseDown
    DesignSize = (
      628
      41)
    object TitleBarCaptionLabel: TLabel
      Left = 25
      Top = 16
      Width = 109
      Height = 15
      Caption = 'TitleBarCaptionLabel'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      StyleElements = []
    end
    object ToolBar1: TToolBar
      Left = 527
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
      object MinimizeToolButton: TToolButton
        Left = 0
        Top = 0
        Action = MinimizeAction_PrincBasForm
      end
      object FecharToolButton: TToolButton
        Left = 47
        Top = 0
        Action = FecharAction_ActBasForm
      end
    end
  end
  object GerenciadorDeTarefasGroupBox_PrincBasForm: TGroupBox [3]
    Left = 59
    Top = 202
    Width = 172
    Height = 50
    Anchors = [akTop, akRight]
    Caption = 'Tarefas do Sistema'
    TabOrder = 1
    object AbrirButton_PrincBasForm: TButton
      Left = 8
      Top = 18
      Width = 75
      Height = 25
      Action = GerFormAbrirAction_PrincBasForm
      TabOrder = 0
    end
    object CentrButton_PrincBasForm: TButton
      Left = 88
      Top = 18
      Width = 75
      Height = 25
      Action = GerFormCentralizarAction_PrincBasForm
      TabOrder = 1
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    inherited FecharAction_ActBasForm: TAction
      Caption = 'Fechar o Sistema'
      Hint = 'Fechar o Sistema'
    end
    object MinimizeAction_PrincBasForm: TAction
      Caption = 'MinimizeAction_PrincBasForm'
      Hint = 'Minimize'
      ImageIndex = 1
      OnExecute = MinimizeAction_PrincBasFormExecute
    end
    object GerFormAbrirAction_PrincBasForm: TAction
      Caption = 'Abrir'
      OnExecute = GerFormAbrirAction_PrincBasFormExecute
    end
    object GerFormCentralizarAction_PrincBasForm: TAction
      Caption = 'Centralizar'
      OnExecute = GerFormCentralizarAction_PrincBasFormExecute
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 320
    Top = 176
  end
end

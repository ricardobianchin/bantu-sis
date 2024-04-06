object ProdBarrasListForm: TProdBarrasListForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Lista de C'#243'digos de Barra'
  ClientHeight = 272
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object BasePanel: TPanel
    Left = 0
    Top = 242
    Width = 300
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 308
      Height = 29
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList24FlatSelect
      TabOrder = 0
      ExplicitWidth = 300
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = NovoAction
      end
      object ToolButton2: TToolButton
        Left = 31
        Top = 0
        Action = ExclAction
      end
      object ToolButton6: TToolButton
        Left = 62
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 70
        Top = 0
        Action = ConsultarWebAction
      end
      object ToolButton7: TToolButton
        Left = 101
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 109
        Top = 0
        Action = CancAction
      end
      object ToolButton3: TToolButton
        Left = 140
        Top = 0
        Action = OkAction
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 300
    Height = 242
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object ActionList1: TActionList
    Images = SisImgDataModule.ImageList24FlatSelect
    Left = 32
    Top = 24
    object NovoAction: TAction
      Caption = 'Inserir'
      Hint = 'Novo c'#243'digo de barras'
      ImageIndex = 2
      OnExecute = NovoActionExecute
    end
    object ExclAction: TAction
      Caption = 'ExclAction'
      Hint = 'Excluir o c'#243'digo de barras'
      ImageIndex = 3
      OnExecute = ExclActionExecute
    end
    object OkAction: TAction
      Caption = 'Ok'
      Hint = 'Ok'
      ImageIndex = 1
      OnExecute = OkActionExecute
    end
    object CancAction: TAction
      Caption = 'Cancelar'
      Hint = 'Cancelar'
      ImageIndex = 0
      OnExecute = CancActionExecute
    end
    object ConsultarWebAction: TAction
      Caption = 'Consultar na Web'
      Hint = 'Consultar na Web'
      ImageIndex = 4
      OnExecute = ConsultarWebActionExecute
    end
  end
  object DataSource1: TDataSource
    Left = 120
    Top = 24
  end
end

inherited PDVModuloBasForm: TPDVModuloBasForm
  Caption = 'PDVModuloBasForm'
  ClientHeight = 280
  ExplicitHeight = 280
  TextHeight = 15
  inherited BasePanel: TPanel
    Top = 251
    ExplicitTop = 251
    object ToolBar1_PDVModuloBasForm: TToolBar
      Left = 0
      Top = 0
      Width = 257
      Height = 29
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 66
      Caption = 'PDVToolBar1'
      Flat = False
      List = True
      ShowCaptions = True
      TabOrder = 1
      object MenuToolButton_PDVModuloBasForm: TToolButton
        Left = 0
        Top = 0
        Caption = 'F2 - Menu'
        ImageIndex = 0
        OnClick = MenuToolButton_PDVModuloBasFormClick
      end
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultaPreo1: TMenuItem
      Caption = 'Consulta &Pre'#231'o'
    end
  end
  object PDVActionList: TActionList
    Left = 280
    Top = 56
    object PrecoBuscaAction_PDVModuloBasForm: TAction
      Caption = 'Consulta &Pre'#231'o'
    end
  end
end

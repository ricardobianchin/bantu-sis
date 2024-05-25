inherited ConfigModuloBasForm: TConfigModuloBasForm
  Caption = 'ConfigModuloBasForm'
  ClientWidth = 604
  StyleElements = []
  ExplicitWidth = 604
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 604
    ExplicitWidth = 604
    DesignSize = (
      604
      30)
  end
  inherited BasePanel: TPanel
    Width = 604
    ExplicitWidth = 604
  end
  object TopoPanel: TPanel [2]
    Left = 0
    Top = 30
    Width = 604
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    object MenuPageControl: TPageControl
      Left = 0
      Top = 0
      Width = 604
      Height = 66
      ActivePage = ConfigAmbienteTabSheet
      Align = alTop
      TabOrder = 0
      object ConfigAmbienteTabSheet: TTabSheet
        Caption = 'Ambiente'
        ImageIndex = 1
        object ConfigAmbienteToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 596
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 104
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          List = True
          ShowCaptions = True
          TabOrder = 0
          object ConfigAmbienteLojasToolButton: TToolButton
            Left = 0
            Top = 0
            Action = ConfigAmbiLojasAction
          end
          object ConfigTerminaisToolButton: TToolButton
            Left = 104
            Top = 0
            Action = ConfigTerminaisAction
          end
        end
      end
      object ConfigImportTabSheet: TTabSheet
        Caption = 'Importar Dados'
        object ImportOrigemTitLabel: TLabel
          Left = 2
          Top = 11
          Width = 40
          Height = 15
          Caption = 'Origem'
        end
        object DBImportOrigemComboBox: TComboBox
          Left = 47
          Top = 8
          Width = 211
          Height = 23
          TabOrder = 0
          Text = 'DBImportOrigemComboBox'
        end
        object ConfigDBImportButton: TButton
          Left = 263
          Top = 7
          Width = 124
          Height = 25
          Action = ConfigDBImportAbrirAction
          TabOrder = 1
        end
      end
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 105
    Width = 604
    Height = 346
    Align = alClient
    TabOrder = 3
    ExplicitTop = 95
    ExplicitWidth = 592
    ExplicitHeight = 338
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 160
    Top = 104
  end
  inherited TitleBarActionList_ModuloBasForm: TActionList
    Left = 336
    Top = 104
  end
  inherited PopupMenu1: TPopupMenu
    Left = 40
    Top = 104
  end
  object ConfigActionList: TActionList
    Left = 336
    Top = 192
    object ConfigDBImportAbrirAction: TAction
      Caption = 'Abrir Importa'#231#227'o...'
      Hint = 'Abre a importa'#231#227'o da oridem selecionada'
      OnExecute = ConfigDBImportAbrirActionExecute
    end
    object ConfigAmbiLojasAction: TAction
      Caption = 'Estabelecimentos'
      Hint = 'Cadastro dos estabelecimentos atual e rede'
      OnExecute = ConfigAmbiLojasActionExecute
    end
    object ConfigTerminaisAction: TAction
      Caption = 'Terminais'
      Hint = 'Castastro dos terminais da loja atual'
    end
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 160
    Top = 184
  end
end

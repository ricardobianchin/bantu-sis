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
    inherited Panel1: TPanel
      inherited OutputLabel: TLabel
        Width = 203
        Height = 23
      end
    end
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
      ActivePage = ImportTabSheet
      Align = alTop
      TabOrder = 0
      object ImportTabSheet: TTabSheet
        Caption = 'Importar Dados'
        object ImportOrigemTitLabel: TLabel
          Left = 2
          Top = 11
          Width = 40
          Height = 15
          Caption = 'Origem'
        end
        object DBImportOrigemComboBox: TComboBox
          Left = 48
          Top = 8
          Width = 211
          Height = 23
          TabOrder = 0
          Text = 'DBImportOrigemComboBox'
        end
        object DBImportButton: TButton
          Left = 265
          Top = 8
          Width = 112
          Height = 25
          Action = DBImportAction
          TabOrder = 1
        end
      end
    end
  end
  object ConfigActionList: TActionList
    Left = 400
    Top = 208
    object DBImportAction: TAction
      Caption = 'Importar Dados...'
      OnExecute = DBImportActionExecute
    end
  end
end

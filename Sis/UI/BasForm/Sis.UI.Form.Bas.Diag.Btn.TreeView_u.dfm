inherited TreeViewDiagBasForm: TTreeViewDiagBasForm
  Caption = 'TreeViewDiagBasForm'
  ClientWidth = 439
  ExplicitWidth = 451
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 439
    ExplicitTop = 209
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 439
    ExplicitTop = 266
  end
  object TituloLabel: TLabel [2]
    Left = 0
    Top = 0
    Width = 439
    Height = 15
    Align = alTop
    Caption = 'TituloLabel'
    WordWrap = True
    ExplicitWidth = 58
  end
  object CaminhoLabel: TLabel [3]
    Left = 0
    Top = 15
    Width = 439
    Height = 15
    Align = alTop
    Caption = 'CaminhoLabel'
    WordWrap = True
    ExplicitWidth = 77
  end
  inherited BasePanel: TPanel
    Width = 439
    DesignSize = (
      439
      37)
  end
  object TreeView1: TTreeView [5]
    Left = 168
    Top = 112
    Width = 121
    Height = 97
    Indent = 19
    TabOrder = 1
  end
end

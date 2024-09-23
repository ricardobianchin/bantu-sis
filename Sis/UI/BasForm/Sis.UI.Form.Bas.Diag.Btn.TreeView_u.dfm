inherited TreeViewDiagBasForm: TTreeViewDiagBasForm
  Caption = 'TreeViewDiagBasForm'
  ExplicitWidth = 455
  ExplicitHeight = 320
  TextHeight = 15
  object TituloLabel: TLabel [2]
    Left = 0
    Top = 0
    Width = 443
    Height = 15
    Align = alTop
    Caption = 'TituloLabel'
    WordWrap = True
    ExplicitWidth = 58
  end
  object CaminhoLabel: TLabel [3]
    Left = 0
    Top = 15
    Width = 443
    Height = 15
    Align = alTop
    Caption = 'CaminhoLabel'
    WordWrap = True
    ExplicitWidth = 77
  end
  inherited BasePanel: TPanel
    ExplicitTop = 229
    ExplicitWidth = 439
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

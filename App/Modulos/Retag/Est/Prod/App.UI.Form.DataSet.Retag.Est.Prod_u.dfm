inherited RetagEstProdDataSetForm: TRetagEstProdDataSetForm
  Caption = 'RetagEstProdDataSetForm'
  ClientHeight = 439
  ClientWidth = 688
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 688
  ExplicitHeight = 439
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 410
    Width = 688
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 410
    ExplicitWidth = 688
    inherited TitToolBar1_BasTabSheet: TToolBar
      Width = 688
      ExplicitWidth = 688
      inherited Panel1: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited DBGrid1: TDBGrid
    Width = 688
    Height = 410
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
end

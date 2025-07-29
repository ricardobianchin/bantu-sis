inherited RetagEstProdDataSetForm: TRetagEstProdDataSetForm
  Caption = 'RetagEstProdDataSetForm'
  ClientHeight = 439
  ClientWidth = 688
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 688
  ExplicitHeight = 439
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 403
    Width = 688
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 403
    ExplicitWidth = 688
    inherited TitAuxPanel_BasTabSheet: TPanel
      Left = 548
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 548
      ExplicitHeight = 36
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Width = 548
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 548
      ExplicitHeight = 36
      inherited TitToolBar1_BasTabSheet: TToolBar
        Width = 548
        Height = 38
        Align = alNone
        AutoSize = False
        ExplicitWidth = 548
        ExplicitHeight = 38
      end
    end
  end
  inherited DBGrid1: TDBGrid
    Width = 688
    Height = 403
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited ToolBar1: TToolBar
      Width = 62
      Height = 30
      Align = alNone
      AutoSize = False
      ExplicitWidth = 62
      ExplicitHeight = 30
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    object MudaLoteAction_ProdDatasetTabSheet: TAction
      Caption = 'Mudan'#231'a em Lote'
      OnExecute = MudaLoteAction_ProdDatasetTabSheetExecute
    end
  end
end

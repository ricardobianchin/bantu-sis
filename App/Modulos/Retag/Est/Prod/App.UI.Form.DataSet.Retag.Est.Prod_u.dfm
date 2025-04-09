inherited RetagEstProdDataSetForm: TRetagEstProdDataSetForm
  Caption = 'RetagEstProdDataSetForm'
  ClientHeight = 439
  ClientWidth = 688
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 688
  ExplicitHeight = 439
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 409
    Width = 688
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 409
    ExplicitWidth = 688
    inherited TitAuxPanel_BasTabSheet: TPanel
      Left = 548
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 548
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Width = 548
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 548
      inherited TitToolBar1_BasTabSheet: TToolBar
        Width = 548
        Align = alBottom
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 548
      end
    end
  end
  inherited DBGrid1: TDBGrid
    Width = 688
    Height = 409
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ActionList1_ActBasForm: TActionList
    object MudaLoteAction_ProdDatasetTabSheet: TAction
      Caption = 'Mudan'#231'a em Lote'
      OnExecute = MudaLoteAction_ProdDatasetTabSheetExecute
    end
  end
end

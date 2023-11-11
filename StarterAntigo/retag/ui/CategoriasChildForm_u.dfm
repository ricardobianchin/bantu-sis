inherited CategoriasChildForm: TCategoriasChildForm
  BorderStyle = bsNone
  Caption = 'Categorias de produtos'
  ClientHeight = 480
  ClientWidth = 441
  FormStyle = fsNormal
  Position = poDesigned
  ExplicitWidth = 441
  TextHeight = 15
  inherited DBGrid1: TDBGrid
    Width = 441
    Height = 447
  end
  inherited Panel1: TPanel
    Width = 441
    ExplicitWidth = 441
    inherited ToolBar2: TToolBar
      Left = 369
      ExplicitLeft = 369
    end
  end
  inherited ActionList1: TActionList
    inherited InsAction: TAction
      OnExecute = InsActionExecute
    end
    inherited AlterarAction: TAction
      OnExecute = AlterarActionExecute
    end
  end
  inherited FDMemTable1: TFDMemTable
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    StoreDefs = True
    object FDMemTable1ID: TLargeintField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
    end
    object FDMemTable1Descr: TStringField
      FieldName = 'Nome'
      Size = 32
    end
  end
end

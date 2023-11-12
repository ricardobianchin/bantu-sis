inherited UsuCategChildForm: TUsuCategChildForm
  BorderStyle = bsNone
  Caption = 'Categorias de usu'#225'rios'
  ClientHeight = 479
  ClientWidth = 610
  FormStyle = fsNormal
  Position = poDesigned
  ExplicitWidth = 610
  ExplicitHeight = 479
  TextHeight = 15
  inherited DBGrid1: TDBGrid
    Width = 610
    Height = 446
  end
  inherited Panel1: TPanel
    Width = 610
    ExplicitWidth = 610
    inherited ToolBar2: TToolBar
      Left = 560
      ExplicitLeft = 560
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
    object FDMemTable1Id: TLargeintField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
    end
    object FDMemTable1Descr: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'Descr'
      Size = 32
    end
  end
end

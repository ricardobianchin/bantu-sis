inherited DBGridFrame1: TDBGridFrame1
  inherited FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'SessaoIndex'
        DataType = ftLargeint
      end
      item
        Name = 'UsuarioApelido'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ModuloNome'
        DataType = ftString
        Size = 20
      end>
    StoreDefs = True
    object FDMemTable1SessaoIndex: TLargeintField
      FieldName = 'SessaoIndex'
      Visible = False
    end
    object FDMemTable1UsuarioApelido: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'UsuarioApelido'
      Size = 30
    end
    object FDMemTable1ModuloNome: TStringField
      DisplayLabel = 'M'#243'dulo'
      FieldName = 'ModuloNome'
    end
  end
end

inherited SessaoSelectDBGridFrame: TSessaoSelectDBGridFrame
  inherited FDMemTable1: TFDMemTable
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

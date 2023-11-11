unit btu.lib.lists.TextoItem;

interface

type
  ITextoItem = interface(IInterface)
    ['{06D11498-741A-49D8-B23A-E08902544E41}']
    procedure SetTitulo(Value: string);
    function GetTitulo: string;
    property Titulo: string read GetTitulo write SetTitulo;

    procedure SetTexto(Value: string);
    function GetTexto: string;
    property Texto: string read GetTexto write SetTexto;
  end;

implementation

end.

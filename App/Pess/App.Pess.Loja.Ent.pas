unit App.Pess.Loja.Ent;

interface

uses App.Pess.Ent;

type
  IPessLojaEnt = interface(IPessEnt)
    ['{9FF020CB-8EC5-495D-82BE-669B04AC1718}']
    function GetAtivo: boolean;
    procedure SetAtivo(const Value: boolean);
    property Ativo: boolean read GetAtivo write SetAtivo;

  end;


implementation

end.

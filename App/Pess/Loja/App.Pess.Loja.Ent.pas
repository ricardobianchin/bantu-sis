unit App.Pess.Loja.Ent;

interface

uses App.Pess.Ent;

type
  IPessLojaEnt = interface(IPessEnt)
    ['{9FF020CB-8EC5-495D-82BE-669B04AC1718}']
    function GetSelecionado: boolean;
    procedure SetSelecionado(const Value: boolean);
    property Selecionado: boolean read GetSelecionado write SetSelecionado;

    function GetLogLojaId: smallint;
    procedure SetLogLojaId(const Value: smallint);
    property LogLojaId: smallint read GetLogLojaId write SetLogLojaId;
  end;


implementation

end.

unit App.Retag.Est.Entrada.Ent;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.EntradaItem;

type
  IEntradaEnt = interface(IEstMovEnt<IRetagEntradaItem>)
    ['{776DBC55-EFE6-401A-8153-9606181D5EF7}']

    function GetEntradaId: TId;
    procedure SetEntradaId(Value: TId);
    property EntradaId: TId read GetEntradaId write SetEntradaId;

    function GetNDoc: integer;
    procedure SetNDoc(Value: integer);
    property NDoc: integer read GetNDoc write SetNDoc;

    function GetSerie: SmallInt;
    procedure SetSerie(Value: SmallInt);
    property Serie: SmallInt read GetSerie write SetSerie;

    function GetFornecedorId: TId;
    procedure SetFornecedorId(Value: TId);
    property FornecedorId: TId read GetFornecedorId write SetFornecedorId;

    function GetFornecedorApelido: string;
    procedure SetFornecedorApelido(Value: string);
    property FornecedorApelido: string read GetFornecedorApelido write SetFornecedorApelido;

    function GetCod(pSeparador: string = '-'): string;
  end;

implementation

end.

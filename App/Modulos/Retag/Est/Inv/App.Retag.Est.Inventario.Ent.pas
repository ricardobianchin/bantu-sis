unit App.Retag.Est.Inventario.Ent;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.InventarioItem;

type
  IInventarioEnt = interface(IEstMovEnt<IRetagInventarioItem>)
    ['{C8CA537E-8FBF-41DF-AEFC-2243D67749E0}']

    function GetInventarioId: TId;
    procedure SetInventarioId(Value: TId);
    property InventarioId: TId read GetInventarioId write SetInventarioId;

    function GetCod(pSeparador: string = '-'): string;
  end;

implementation

end.

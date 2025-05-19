unit App.Retag.Est.Inventario.Ent;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.DB.DBTypes, App.Retag.Est.InventarioItem;

type
  IInventarioEnt = interface(IEstMovEnt<IRetagInventarioItem>)
    ['{B52CFF07-AF28-4C57-9C85-93FD0CA1434D}']

    function GetInventarioId: TId;
    procedure SetInventarioId(Value: TId);
    property InventarioId: TId read GetInventarioId write SetInventarioId;

    function GetCod(pSeparador: string = '-'): string;
  end;

implementation

end.

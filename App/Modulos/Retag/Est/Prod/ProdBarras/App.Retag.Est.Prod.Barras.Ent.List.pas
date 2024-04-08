unit App.Retag.Est.Prod.Barras.Ent.List;

interface

uses System.Classes, App.Retag.Est.Prod.Barras.Ent, Sis.Lists.Types;

type
  IProdBarrasList = interface(IInterfaceList)
    ['{05B1D538-7507-491E-A8AB-B6CD2D2A8514}']

    function GetProdBarras(Index: integer): IProdBarras;
    property ProdBarras[Index: integer]: IProdBarras read GetProdBarras; default;

    procedure PegarBarras(pBarras: string; pOndeInserir: TPosicaoList);
    function IndexOfBarras(pBarras: string): integer;

    function GetAsString(pSeparador: string): string;
  end;

implementation

end.

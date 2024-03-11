unit App.Retag.Est.Prod.Barras.Ent.List;

interface

uses System.Classes, App.Retag.Est.Prod.Barras.Ent;

type
  IProdBarrasList = interface(IInterfaceList)
    ['{05B1D538-7507-491E-A8AB-B6CD2D2A8514}']

    function GetProdBarras(Index: integer): IProdBarras;
    property ProdBarras[Index: integer]: IProdBarras read GetProdBarras; default;

    procedure PegarBarras(pBarras: string);
    procedure InsertBarras(pIndex: integer; pBarras: string);
    function IndexOfBarras(pBarras: string): integer;

  end;

implementation

end.

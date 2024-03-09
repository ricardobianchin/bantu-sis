unit App.Retag.Est.Prod.Barras.Ent.List_u;

interface

uses App.Retag.Est.Prod.Barras.Ent.List, System.Classes,
  App.Retag.Est.Prod.Barras.Ent;

type
  TProdBarrasList = class(TInterfaceList, IProdBarrasList)
  private
    function GetProdBarras(Index: integer): IProdBarras;
  public
    property ProdBarras[Index: integer]: IProdBarras
      read GetProdBarras; default;
    procedure PegarBarCod(pBarCod: string);
  end;

implementation

{ TProdBarrasList }

uses App.Retag.Est.Factory;

function TProdBarrasList.GetProdBarras(Index: integer): IProdBarras;
begin
  Result := IProdBarras(Items[Index]);
end;

procedure TProdBarrasList.PegarBarCod(pBarCod: string);
var
  iOrdem: smallint;
  oProdBarras: IProdBarras;
begin
  iOrdem := Count + 1;
  oProdBarras := ProdBarrasCreate(iOrdem, pBarCod);
  Add(oProdBarras);
end;

end.

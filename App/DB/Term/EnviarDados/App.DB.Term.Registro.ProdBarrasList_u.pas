unit App.DB.Term.Registro.ProdBarrasList_u;

interface

uses System.Contnrs, App.DB.Term.Registro.ProdBarras_u;

type
  TProdBarrasList = class(TObjectList)
  private
    function GetProdBarras(Index: integer): TProdBarras;
  public
    property ProdBarras[Index: integer]: TProdBarras
      read GetProdBarras; default;
    procedure Adicionar(pCOD_BARRAS: string; pPROD_ID: integer);
    function IndexOfValores(pCOD_BARRAS: string; pPROD_ID: integer): integer;
  end;

implementation

{ TProdBarrasList }

procedure TProdBarrasList.Adicionar(pCOD_BARRAS: string; pPROD_ID: integer);
var
  up: TProdBarras;
begin
  up := TProdBarras.Create(pCOD_BARRAS, pPROD_ID);
  Add(up);
end;

function TProdBarrasList.GetProdBarras(Index: integer): TProdBarras;
begin
  Result := TProdBarras(Items[Index]);
end;

function TProdBarrasList.IndexOfValores(pCOD_BARRAS: string;
  pPROD_ID: integer): integer;
var
  i: integer;
  up: TProdBarras;
begin
  Result := -1;

  for i := 0 to Count - 1 do
  begin
    up := GetProdBarras(i);
    if up.EhIgualA(pCOD_BARRAS, pPROD_ID) then
    begin
      Result := i;
      break;
    end;
  end;
end;

end.

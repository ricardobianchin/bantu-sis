unit App.Retag.Est.Prod.Barras.Ent.List_u;

interface

uses App.Retag.Est.Prod.Barras.Ent.List, System.Classes, Sis.Lists.Types,
  App.Retag.Est.Prod.Barras.Ent;

type
  TProdBarrasList = class(TInterfaceList, IProdBarrasList)
  private
    function GetProdBarras(Index: integer): IProdBarras;
    procedure RenumereOrdem;
    function GetAsStringCSV: string;
  public
    property ProdBarras[Index: integer]: IProdBarras read GetProdBarras; default;
    procedure PegarBarras(pBarras: string; pOndeInserir: TPosicaoList);
    function IndexOfBarras(pBarras: string): integer;
    property AsStringCSV: string read GetAsStringCSV;

  end;

implementation

{ TProdBarrasList }

uses App.Retag.Est.Factory, System.SysUtils;

function TProdBarrasList.GetAsStringCSV: string;
var
  i: integer;
  oProdBarras: IProdBarras;
begin
  Result := '';

  for I := 0 to Count - 1 do
  begin
    oProdBarras := ProdBarras[I];

    if Result <> '' then
      Result := Result + ';';

    Result := Result + oProdBarras.Barras;
  end;
end;

function TProdBarrasList.GetProdBarras(Index: integer): IProdBarras;
begin
  Result := IProdBarras(Items[Index]);
end;

function TProdBarrasList.IndexOfBarras(pBarras: string): integer;
var
  i: integer;
  oProdBarras: IProdBarras;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    oProdBarras := ProdBarras[I];
    if oProdBarras.Barras = pBarras then
    begin
      Result := I;
      break;
    end;
  end;
end;

procedure TProdBarrasList.PegarBarras(pBarras: string;
  pOndeInserir: TPosicaoList);
var
  oProdBarras: IProdBarras;
  iIndex: integer;
begin
  pBarras := Trim(pBarras);
  if pBarras = '' then
    exit;

  iIndex := IndexOfBarras(pBarras);
  if iIndex > -1 then
    exit;

  oProdBarras := ProdBarrasCreate(0, pBarras);

  if pOndeInserir = plInicio then
    Insert(0, oProdBarras)
  else
    Add(oProdBarras);

  RenumereOrdem;
end;

procedure TProdBarrasList.RenumereOrdem;
var
  i: integer;
  oProdBarras: IProdBarras;
begin
  for I := 0 to Count - 1 do
  begin
    ProdBarras[I].Ordem := I + 1;
  end;
end;

end.

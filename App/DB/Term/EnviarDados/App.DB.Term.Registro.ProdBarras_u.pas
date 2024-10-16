unit App.DB.Term.Registro.ProdBarras_u;

interface

uses Sis.Entities.Types;

type
  TProdBarras = class
  public
    COD_BARRAS: string;
    PROD_ID: integer;
    constructor Create(pCOD_BARRAS: string; pPROD_ID: integer);
    function EhIgualA(pCOD_BARRAS: string; pPROD_ID: integer): boolean;
  end;

implementation

{ TProdBarras }

constructor TProdBarras.Create(pCOD_BARRAS: string; pPROD_ID: integer);
begin
  COD_BARRAS := pCOD_BARRAS;
  PROD_ID := pPROD_ID;
end;

function TProdBarras.EhIgualA(pCOD_BARRAS: string; pPROD_ID: integer): boolean;
begin
  Result := COD_BARRAS = pCOD_BARRAS;
  if not Result then
    exit;

  Result := pPROD_ID = pPROD_ID;
//  if not Result then
//    exit;
end;

end.

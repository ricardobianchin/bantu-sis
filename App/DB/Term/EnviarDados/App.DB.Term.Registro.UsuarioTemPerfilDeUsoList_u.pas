unit App.DB.Term.Registro.UsuarioTemPerfilDeUsoList_u;

interface

uses Sis.Entities.Types, System.Contnrs,
  App.DB.Term.Registro.UsuarioTemPerfilDeUso_u;

type
  TUsuarioTemPerfilDeUsoListList = class(TObjectList)
  private
    function GetUsuarioTemPerfilDeUso(Index: integer): TUsuarioTemPerfilDeUso;
  public
    property UsuarioTemPerfilDeUso[Index: integer]: TUsuarioTemPerfilDeUso
      read GetUsuarioTemPerfilDeUso; default;
    procedure Adicionar(pLOJA_ID: TLojaId; pPESSOA_ID, pPERFIL_DE_USO_ID: integer);
    function IndexOfValores(pLOJA_ID: TLojaId;
      pPESSOA_ID, pPERFIL_DE_USO_ID: integer): integer;
  end;

implementation

{ TUsuarioTemPerfilDeUsoListList }

procedure TUsuarioTemPerfilDeUsoListList.Adicionar(pLOJA_ID: TLojaId;
  pPESSOA_ID, pPERFIL_DE_USO_ID: integer);
var
  up: TUsuarioTemPerfilDeUso;
begin
  up := TUsuarioTemPerfilDeUso.Create(pLOJA_ID, pPESSOA_ID, pPERFIL_DE_USO_ID);
  Add(up);
end;

function TUsuarioTemPerfilDeUsoListList.GetUsuarioTemPerfilDeUso(Index: integer)
  : TUsuarioTemPerfilDeUso;
begin
  Result := TUsuarioTemPerfilDeUso(Items[Index]);
end;

function TUsuarioTemPerfilDeUsoListList.IndexOfValores(pLOJA_ID: TLojaId;
  pPESSOA_ID, pPERFIL_DE_USO_ID: integer): integer;
var
  i: integer;
  up: TUsuarioTemPerfilDeUso;
begin
  Result := -1;

  for i := 0 to Count - 1 do
  begin
    up := GetUsuarioTemPerfilDeUso(i);
    if up.EhIgualA(pLOJA_ID, pPESSOA_ID, pPERFIL_DE_USO_ID) then
    begin
      Result := i;
      break;
    end;
  end;
end;

end.

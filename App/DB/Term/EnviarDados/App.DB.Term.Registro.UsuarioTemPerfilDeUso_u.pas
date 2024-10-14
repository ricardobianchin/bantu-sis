unit App.DB.Term.Registro.UsuarioTemPerfilDeUso_u;

interface

uses Sis.Entities.Types;

type
  TUsuarioTemPerfilDeUso = class
  public
    LOJA_ID: TLojaId;
    PESSOA_ID: integer;
    PERFIL_DE_USO_ID: integer;
    constructor Create(pLOJA_ID: TLojaId;
      pPESSOA_ID, pPERFIL_DE_USO_ID: integer);
    function EhIgualA(pLOJA_ID: TLojaId;
      pPESSOA_ID, pPERFIL_DE_USO_ID: integer): boolean;
  end;

implementation

{ TUsuarioTemPerfilDeUso }

constructor TUsuarioTemPerfilDeUso.Create(pLOJA_ID: TLojaId; pPESSOA_ID,
  pPERFIL_DE_USO_ID: integer);
begin
  LOJA_ID := pLOJA_ID;
  PESSOA_ID := pPESSOA_ID;
  PERFIL_DE_USO_ID := pPERFIL_DE_USO_ID;
end;

function TUsuarioTemPerfilDeUso.EhIgualA(pLOJA_ID: TLojaId; pPESSOA_ID,
  pPERFIL_DE_USO_ID: integer): boolean;
begin
  Result := PESSOA_ID = pPESSOA_ID;
  if not Result then
    exit;

  Result := PERFIL_DE_USO_ID = pPERFIL_DE_USO_ID;
  if not Result then
    exit;

  Result := LOJA_ID = pLOJA_ID;
//  if not Result then
//    exit;
end;

end.

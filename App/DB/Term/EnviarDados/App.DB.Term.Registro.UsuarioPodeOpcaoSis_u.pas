unit App.DB.Term.Registro.UsuarioPodeOpcaoSis_u;

interface

uses Sis.Entities.Types;

type
  TUsuarioPodeOpcaoSis = class
  public
    LOJA_ID: TLojaId;
    PESSOA_ID: integer;
    OPCAO_SIS_ID: integer;
    constructor Create(pLOJA_ID: TLojaId;
      pPESSOA_ID, pOPCAO_SIS_ID: integer);
    function EhIgualA(pLOJA_ID: TLojaId;
      pPESSOA_ID, pOPCAO_SIS_ID: integer): boolean;
  end;

implementation

{ TUsuarioPodeOpcaoSis }

constructor TUsuarioPodeOpcaoSis.Create(pLOJA_ID: TLojaId;
  pPESSOA_ID, pOPCAO_SIS_ID: integer);
begin
  LOJA_ID := pLOJA_ID;
  PESSOA_ID := pPESSOA_ID;
  OPCAO_SIS_ID := pOPCAO_SIS_ID;
end;

function TUsuarioPodeOpcaoSis.EhIgualA(pLOJA_ID: TLojaId;
  pPESSOA_ID, pOPCAO_SIS_ID: integer): boolean;
begin
  Result := OPCAO_SIS_ID = pOPCAO_SIS_ID;
  if not Result then
    exit;

  Result := PESSOA_ID = pPESSOA_ID;
  if not Result then
    exit;

  Result := LOJA_ID = pLOJA_ID;
//  if not Result then
//    exit;
end;

end.

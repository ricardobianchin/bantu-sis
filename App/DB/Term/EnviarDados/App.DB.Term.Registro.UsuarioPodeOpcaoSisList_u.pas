unit App.DB.Term.Registro.UsuarioPodeOpcaoSisList_u;

interface

uses Sis.Entities.Types, System.Contnrs,
  App.DB.Term.Registro.UsuarioPodeOpcaoSis_u;

type
  TUsuarioPodeOpcaoSisListList = class(TObjectList)
  private
    function GetUsuarioPodeOpcaoSis(Index: integer): TUsuarioPodeOpcaoSis;
  public
    property UsuarioPodeOpcaoSis[Index: integer]: TUsuarioPodeOpcaoSis
      read GetUsuarioPodeOpcaoSis; default;
    procedure Adicionar(pLOJA_ID: TLojaId; pPESSOA_ID, pOPCAO_SIS_ID: integer);
    function IndexOfValores(pLOJA_ID: TLojaId;
      pPESSOA_ID, pOPCAO_SIS_ID: integer): integer;
  end;

implementation

{ TUsuarioPodeOpcaoSisListList }

procedure TUsuarioPodeOpcaoSisListList.Adicionar(pLOJA_ID: TLojaId;
  pPESSOA_ID, pOPCAO_SIS_ID: integer);
var
  up: TUsuarioPodeOpcaoSis;
begin
  up := TUsuarioPodeOpcaoSis.Create(pLOJA_ID, pPESSOA_ID, pOPCAO_SIS_ID);
  Add(up);
end;

function TUsuarioPodeOpcaoSisListList.GetUsuarioPodeOpcaoSis(Index: integer)
  : TUsuarioPodeOpcaoSis;
begin
  Result := TUsuarioPodeOpcaoSis(Items[Index]);
end;

function TUsuarioPodeOpcaoSisListList.IndexOfValores(pLOJA_ID: TLojaId;
  pPESSOA_ID, pOPCAO_SIS_ID: integer): integer;
var
  i: integer;
  up: TUsuarioPodeOpcaoSis;
begin
  Result := -1;

  for i := 0 to Count - 1 do
  begin
    up := GetUsuarioPodeOpcaoSis(i);
    if up.EhIgualA(pLOJA_ID, pPESSOA_ID, pOPCAO_SIS_ID) then
    begin
      Result := i;
      break;
    end;
  end;
end;

end.

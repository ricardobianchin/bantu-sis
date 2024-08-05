unit App.Pess.PerfilDeUso.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Pess.PerfilDeUso.Ent;

type
  TPerfilDeUsoDBI = class(TEntDBI)
  private
    function GetPerfilDeUsoEnt: IPerfilDeUsoEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegRetId: string; override;
    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Pess.PerfilDeUso.Ent.Factory_u,
  Sis.Types.Bool_u;

{ TPerfilDeUsoDBI }

function TPerfilDeUsoDBI.GetPackageName: string;
begin
  Result := 'PERFIL_DE_USO_PA';
end;

function TPerfilDeUsoDBI.GetPerfilDeUsoEnt: IPerfilDeUsoEnt;
begin
  Result := EntEdCastToPerfilDeUsoEnt(EntEd);
end;

function TPerfilDeUsoDBI.GetSqlGaranteRegRetId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO FROM PERFIL_DE_USO_PA.GARANTIR(%d,''%s'', %s);';
  Result := Format(sFormat, [GetPerfilDeUsoEnt.Id, GetPerfilDeUsoEnt.Descr,
    BooleanToStrSQL(GetPerfilDeUsoEnt.DeSistema)]);
end;

function TPerfilDeUsoDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT PERFIL_DE_USO_ID FROM PERFIL_DE_USO_PA.BYNOME_GET(''%s'');';
  sDescr := VarToString(pValues);
  Result := Format(sFormat, [sDescr]);
end;

function TPerfilDeUsoDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select PERFIL_DE_USO_ID, NOME, DE_SISTEMA from PERFIL_DE_USO_PA.LISTA_GET();';
  sBusca := VarToString(pValues);
  Result := Format(sFormat, [sBusca]);
end;

procedure TPerfilDeUsoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;
  GetPerfilDeUsoEnt.Id := VarToInteger(pNovaId[0]);
end;

end.

unit App.Pess.PerfilUso.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Pess.PerfilUso.Ent;

type
  TPerfilUsoDBI = class(TEntDBI)
  private
    function GetPerfilUsoEnt: IPerfilUsoEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegRetId: string; override;
    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Pess.PerfilUso.Ent.Factory_u,
  Sis.Types.Bool_u;

{ TPerfilUsoDBI }

function TPerfilUsoDBI.GetPackageName: string;
begin
  Result := 'PERFIL_USO_PA';
end;

function TPerfilUsoDBI.GetPerfilUsoEnt: IPerfilUsoEnt;
begin
  Result := EntEdCastToPerfilUsoEnt(EntEd);
end;

function TPerfilUsoDBI.GetSqlGaranteRegRetId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO FROM PERFIL_USO_PA.GARANTIR(%d,''%s'', %s);';
  Result := Format(sFormat, [GetPerfilUsoEnt.Id, GetPerfilUsoEnt.Descr,
    BooleanToStrSQL(GetPerfilUsoEnt.DeSistema)]);
end;

function TPerfilUsoDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat := 'SELECT PERFIL_USO_ID FROM PERFIL_USO_PA.BYNOME_GET(''%s'');';
  sDescr := VarToString(pValues);
  Result := Format(sFormat, [sDescr]);
end;

function TPerfilUsoDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat := 'select PERFIL_USO_ID, NOME, DE_SISTEMA from PERFIL_USO_PA.LISTA_GET();';
  sBusca := VarToString(pValues);
  Result := Format(sFormat, [sBusca]);
end;

procedure TPerfilUsoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;
  GetPerfilUsoEnt.Id := VarToInteger(pNovaId[0]);
end;

end.

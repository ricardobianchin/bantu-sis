unit App.Acesso.PerfilDeUso.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Acesso.PerfilDeUso.Ent,
  App.Acesso.PerfilDeUso.DBI;

type
  TPerfilDeUsoDBI = class(TEntDBI, IPerfilDeUsoDBI)
  private
    function GetPerfilDeUsoEnt: IPerfilDeUsoEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegERetornaId: string; override;
    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetPackageName: string; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Acesso.PerfilDeUso.Ent.Factory_u,
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

function TPerfilDeUsoDBI.GetSqlGaranteRegERetornaId: string;
var
  sFormat: string;

  iId: integer;
  sDescr: string;
  sSis: string;
begin
  iId := GetPerfilDeUsoEnt.Id;
  sDescr := GetPerfilDeUsoEnt.Descr;
  sSis := BooleanToStrSQL(GetPerfilDeUsoEnt.DeSistema);

  sFormat := 'SELECT ID_GRAVADO FROM PERFIL_DE_USO_PA.GARANTIR(%d,''%s'', %s);';
  Result := Format(sFormat, [iId, sDescr, sSis]);
end;

function TPerfilDeUsoDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
begin
  sFormat :=
    'SELECT PERFIL_DE_USO_ID FROM PERFIL_DE_USO_PA.BYNOME_GET(''%s'');';
  sDescr := VarToString(pValues);
  Result := Format(sFormat, [sDescr]);
end;

function TPerfilDeUsoDBI.GetSqlForEach(pValues: variant): string;
var
  sFormat: string;
  sBusca: string;
begin
  sFormat :=
    'select PERFIL_DE_USO_ID, NOME, DE_SISTEMA, USUARIOS_APELIDOS'#13#10
    +'from PERFIL_DE_USO_PA.LISTA_GET'#13#10
    +'where PERFIL_DE_USO_ID > 0'#13#10
    +';'#13#10;

  sBusca := VarToString(pValues);
  Result := Format(sFormat, [sBusca]);
end;

procedure TPerfilDeUsoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;
  GetPerfilDeUsoEnt.Id := VarToInteger(pNovaId[0]);
end;

end.

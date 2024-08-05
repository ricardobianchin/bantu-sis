unit App.Pess.PerfilDeUso.Ent.Factory_u;

interface

uses App.PessEnder.List, App.Pess.Loja.Ent, App.Pess.Loja.DBI, Sis.DB.DBTypes,
  App.Ent.DBI, App.Ent.Ed, App.Pess.Ent, App.Pess.DBI, App.PessEnder, Data.DB,
  App.Pess.PerfilDeUso.Ent;

function EntEdCastToPerfilDeUsoEnt(pEntEd: IEntEd): IPerfilDeUsoEnt;

function EntDBICastToPerfilDeUsoDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstPerfilDeUsoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IPerfilDeUsoEnt;

function RetagEstPerfilDeUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilDeUsoEnt: IEntEd): IEntDBI;

implementation

uses App.Pess.PerfilDeUso.DBI_u, App.Pess.PerfilDeUso.Ent_u;

function EntEdCastToPerfilDeUsoEnt(pEntEd: IEntEd): IPerfilDeUsoEnt;
begin
  Result := TPerfilDeUsoEnt(pEntEd);
end;

function EntDBICastToPerfilDeUsoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TPerfilDeUsoDBI(pEntDBI);
end;

function RetagEstPerfilDeUsoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IPerfilDeUsoEnt;
begin
  Result := TPerfilDeUsoEnt.Create(pState, pId, pDescr);
end;

function RetagEstPerfilDeUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilDeUsoEnt: IEntEd): IEntDBI;
begin
  Result := TPerfilDeUsoDBI.Create(pDBConnection, TPerfilDeUsoEnt(pPerfilDeUsoEnt));
end;

end.

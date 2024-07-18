unit App.Pess.PerfilUso.Ent.Factory_u;

interface

uses App.PessEnder.List, App.Pess.Loja.Ent, App.Pess.Loja.DBI, Sis.DB.DBTypes,
  App.Ent.DBI, App.Ent.Ed, App.Pess.Ent, App.Pess.DBI, App.PessEnder, Data.DB,
  App.Pess.PerfilUso.Ent;

function EntEdCastToPerfilUsoEnt(pEntEd: IEntEd): IPerfilUsoEnt;

function EntDBICastToPerfilUsoDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstPerfilUsoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IPerfilUsoEnt;

function RetagEstPerfilUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilUsoEnt: IEntEd): IEntDBI;

implementation

uses App.Pess.PerfilUso.DBI_u, App.Pess.PerfilUso.Ent_u;

function EntEdCastToPerfilUsoEnt(pEntEd: IEntEd): IPerfilUsoEnt;
begin
  Result := TPerfilUsoEnt(pEntEd);
end;

function EntDBICastToPerfilUsoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TPerfilUsoDBI(pEntDBI);
end;

function RetagEstPerfilUsoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IPerfilUsoEnt;
begin
  Result := TPerfilUsoEnt.Create(pState, pId, pDescr);
end;

function RetagEstPerfilUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilUsoEnt: IEntEd): IEntDBI;
begin
  Result := TPerfilUsoDBI.Create(pDBConnection, TPerfilUsoEnt(pPerfilUsoEnt));
end;

end.

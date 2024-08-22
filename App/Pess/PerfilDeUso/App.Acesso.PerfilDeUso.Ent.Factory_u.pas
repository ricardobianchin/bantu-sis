unit App.Acesso.PerfilDeUso.Ent.Factory_u;

interface

uses App.PessEnder.List, App.Pess.Loja.Ent, App.Pess.Loja.DBI, Sis.DB.DBTypes,
  App.Ent.DBI, App.Ent.Ed, App.Pess.Ent, App.Pess.DBI, App.PessEnder, Data.DB,
  App.Acesso.PerfilDeUso.Ent, App.Acesso.PerfilDeUso.DBI;

function EntEdCastToPerfilDeUsoEnt(pEntEd: IEntEd): IPerfilDeUsoEnt;

function EntDBICastToPerfilDeUsoDBI(pEntDBI: IEntDBI): IPerfilDeUsoDBI;

function PerfilDeUsoEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IPerfilDeUsoEnt;

function PerfilDeUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilDeUsoEnt: IEntEd): IPerfilDeUsoDBI;

implementation

uses App.Acesso.PerfilDeUso.DBI_u, App.Acesso.PerfilDeUso.Ent_u;

function EntEdCastToPerfilDeUsoEnt(pEntEd: IEntEd): IPerfilDeUsoEnt;
begin
  Result := TPerfilDeUsoEnt(pEntEd);
end;

function EntDBICastToPerfilDeUsoDBI(pEntDBI: IEntDBI): IPerfilDeUsoDBI;
begin
  Result := TPerfilDeUsoDBI(pEntDBI);
end;

function PerfilDeUsoEntCreate(pState: TDataSetState;
  pId: integer; pDescr: string): IPerfilDeUsoEnt;
begin
  Result := TPerfilDeUsoEnt.Create(pState, pId, pDescr);
end;

function PerfilDeUsoDBICreate(pDBConnection: IDBConnection;
  pPerfilDeUsoEnt: IEntEd): IPerfilDeUsoDBI;
begin
  Result := TPerfilDeUsoDBI.Create(pDBConnection, TPerfilDeUsoEnt(pPerfilDeUsoEnt));
end;

end.

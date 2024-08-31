unit App.Pess.Cliente.Ent.Factory;

interface

uses App.Pess.Ent.Factory_u, App.Pess.Cliente.Ent, App.Pess.Cliente.DBI,
  Sis.DB.DBTypes, App.Ent.DBI, App.Ent.Ed;

//Cliente
//Cliente ent
function PessClienteEntCreate: IPessClienteEnt;
//Cliente dbi
function PessClienteDBICreate(pDBConnection: IDBConnection;
  pPessClienteEnt: IPessClienteEnt): IPessClienteDBI;//IEntDBI;

function EntEdCastToPessClienteEnt(pEntEd: IEntEd): IPessClienteEnt;
function EntDBICastToPessClienteDBI(pEntDBI: IEntDBI): IPessClienteDBI;

implementation

uses App.PessEnder.List, App.Pess.Cliente.Ent_u, App.Pess.Cliente.DBI_u;

//Cliente
function PessClienteEntCreate: IPessClienteEnt;
var
  oPessEnderList: IPessEnderList;
begin
  oPessEnderList := PessEnderListCreate;

  Result := TPessClienteEnt.Create(oPessEnderList);
end;

function PessClienteDBICreate(pDBConnection: IDBConnection;
  pPessClienteEnt: IPessClienteEnt): IPessClienteDBI;//IEntDBI;
begin
  Result := TPessClienteDBI.Create(pDBConnection, pPessClienteEnt);
end;

function EntEdCastToPessClienteEnt(pEntEd: IEntEd): IPessClienteEnt;
begin
  Result := TPessClienteEnt(pEntEd);
end;

function EntDBICastToPessClienteDBI(pEntDBI: IEntDBI): IPessClienteDBI;
begin
  Result := TPessClienteDBI(pEntDBI);
end;

end.

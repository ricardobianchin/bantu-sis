unit App.Config.Amb.Loja.Ent.Factory_u;

interface

uses App.Ent.Ed, App.Pess.Loja.Ent, Sis.DB.DBTypes, App.PessEnder.List,
  App.Pess.Loja.DBI;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
function EntDBICastToPessLojaDBI(pPessLojaDBI: IPessLojaDBI): IPessLojaDBI;

function PessLojaEntCreate: IPessLojaEnt;

function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;

implementation

uses App.Pess.Loja.Ent_u, App.Pess.Loja.DBI_u, App.Pess.Factory_u;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
begin
  Result := TPessLojaEnt(pEntEd);
end;

function EntDBICastToPessLojaDBI(pPessLojaDBI: IPessLojaDBI): IPessLojaDBI;
begin
  Result := TPessLojaDBI(pPessLojaDBI);
end;

function PessLojaEntCreate: IPessLojaEnt;
var
  oPessEnderList: IPessEnderList;
begin
  oPessEnderList := PessEnderListCreate;

  Result := TPessLojaEnt.Create(oPessEnderList);
end;

function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;
begin
//  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
  Result := TPessLojaDBI.Create(pDBConnection, pPessLojaEnt);
end;

end.

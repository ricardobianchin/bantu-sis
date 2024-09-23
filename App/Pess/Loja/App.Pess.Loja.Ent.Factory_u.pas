unit App.Pess.Loja.Ent.Factory_u;

interface

uses App.Pess.Ent.Factory_u, App.Pess.Loja.Ent, App.Pess.Loja.DBI,
  Sis.DB.DBTypes, App.Ent.DBI, App.Ent.Ed;

//loja
//loja ent
function PessLojaEntCreate(
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessLojaEnt;//

//loja dbi
function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IPessLojaDBI;

implementation

uses App.PessEnder.List, App.Pess.Loja.Ent_u, App.Pess.Loja.DBI_u;

//loja
function PessLojaEntCreate(
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessLojaEnt;//
var
  oPessEnderList: IPessEnderList;
begin
  oPessEnderList := PessEnderListCreate;

  Result := TPessLojaEnt.Create(pLojaId, pUsuarioId, pMachineIdentId,
    oPessEnderList);
end;

function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;
begin
////  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
  Result := TPessLojaDBI.Create(pDBConnection, pPessLojaEnt);
end;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
begin
  Result := TPessLojaEnt(pEntEd);
end;

function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IPessLojaDBI;
begin
  Result := TPessLojaDBI(pEntDBI);
end;

end.

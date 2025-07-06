unit App.Pess.Fornecedor.Ent.Factory_u;

interface

uses App.Pess.Ent.Factory_u, App.Pess.Fornecedor.Ent, App.Pess.Fornecedor.DBI,
  Sis.DB.DBTypes, App.Ent.DBI, App.Ent.Ed;

//Fornecedor
//Fornecedor ent
function PessFornecedorEntCreate(
  pLojaId: smallint;//
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessFornecedorEnt;//

//Fornecedor dbi
function PessFornecedorDBICreate(pDBConnection: IDBConnection;
  pPessFornecedorEnt: IPessFornecedorEnt): IPessFornecedorDBI;//IEntDBI;

function EntEdCastToPessFornecedorEnt(pEntEd: IEntEd): IPessFornecedorEnt;
function EntDBICastToPessFornecedorDBI(pEntDBI: IEntDBI): IPessFornecedorDBI;

implementation

uses App.PessEnder.List, App.Pess.Fornecedor.Ent_u, App.Pess.Fornecedor.DBI_u;

//Fornecedor
function PessFornecedorEntCreate(
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessFornecedorEnt; //
var
  oPessEnderList: IPessEnderList;
begin
  oPessEnderList := PessEnderListCreate;

  Result := TPessFornecedorEnt.Create(pLojaId, pUsuarioId, pMachineIdentId,
    oPessEnderList);
end;

function PessFornecedorDBICreate(pDBConnection: IDBConnection;
  pPessFornecedorEnt: IPessFornecedorEnt): IPessFornecedorDBI;//IEntDBI;
begin
  Result := TPessFornecedorDBI.Create(pDBConnection, pPessFornecedorEnt);
end;

function EntEdCastToPessFornecedorEnt(pEntEd: IEntEd): IPessFornecedorEnt;
begin
  Result := TPessFornecedorEnt(pEntEd);
end;

function EntDBICastToPessFornecedorDBI(pEntDBI: IEntDBI): IPessFornecedorDBI;
begin
  Result := TPessFornecedorDBI(pEntDBI);
end;

end.

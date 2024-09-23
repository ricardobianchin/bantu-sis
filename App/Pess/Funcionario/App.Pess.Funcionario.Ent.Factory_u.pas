unit App.Pess.Funcionario.Ent.Factory_u;

interface

uses App.Pess.Ent.Factory_u, App.Pess.Funcionario.Ent, App.Pess.Funcionario.DBI,
  Sis.DB.DBTypes, App.Ent.DBI, App.Ent.Ed;

//Funcionario
//Funcionario ent
function PessFuncionarioEntCreate(
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessFuncionarioEnt;

//Funcionario dbi
function PessFuncionarioDBICreate(pDBConnection: IDBConnection;
  pPessFuncionarioEnt: IPessFuncionarioEnt): IPessFuncionarioDBI;//IEntDBI;

function EntEdCastToPessFuncionarioEnt(pEntEd: IEntEd): IPessFuncionarioEnt;
function EntDBICastToPessFuncionarioDBI(pEntDBI: IEntDBI): IPessFuncionarioDBI;

implementation

uses App.PessEnder.List, App.Pess.Funcionario.Ent_u, App.Pess.Funcionario.DBI_u;

//Funcionario
function PessFuncionarioEntCreate(
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint //
  ): IPessFuncionarioEnt;
var
  oPessEnderList: IPessEnderList;
begin
  oPessEnderList := PessEnderListCreate;

  Result := TPessFuncionarioEnt.Create(pLojaId, pUsuarioId, pMachineIdentId,
    oPessEnderList);
end;

function PessFuncionarioDBICreate(pDBConnection: IDBConnection;
  pPessFuncionarioEnt: IPessFuncionarioEnt): IPessFuncionarioDBI;//IEntDBI;
begin
  Result := TPessFuncionarioDBI.Create(pDBConnection, pPessFuncionarioEnt);
end;

function EntEdCastToPessFuncionarioEnt(pEntEd: IEntEd): IPessFuncionarioEnt;
begin
  Result := TPessFuncionarioEnt(pEntEd);
end;

function EntDBICastToPessFuncionarioDBI(pEntDBI: IEntDBI): IPessFuncionarioDBI;
begin
  Result := TPessFuncionarioDBI(pEntDBI);
end;

end.

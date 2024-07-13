unit App.Pess.Ent.Factory_u;

interface

uses App.PessEnder.List, App.Pess.Loja.Ent, App.Pess.Loja.DBI, Sis.DB.DBTypes,
  App.Ent.DBI, App.Ent.Ed, App.Pess.Ent, App.Pess.DBI, App.PessEnder;

//ender list
function PessEnderListCreate: IPessEnderList;//privativo desta unit
function PessEnderCreate: IPessEnder;//privativo desta unit
procedure PessEnderListGarantirUmItem(pPessEnderList: IPessEnderList);

//loja
//loja ent
function PessLojaEntCreate: IPessLojaEnt;
//loja dbi
function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;

function EntEdCastToPessEnt(pEntEd: IEntEd): IPessEnt;
function EntDBICastToPessDBI(pEntDBI: IEntDBI): IPessDBI;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IPessLojaDBI;

implementation

uses App.PessEnder.List_u, App.Pess.Loja.Ent_u, App.Pess.Loja.DBI_u,
  App.Pess.DBI_u, App.Pess.Ent_u, App.PessEnder_u;

//ender
function PessEnderListCreate: IPessEnderList;//privativo desta unit
begin
  Result := TPessEnderList.Create;
end;

function PessEnderCreate: IPessEnder;//privativo desta unit
begin
  Result := TPessEnder.Create;
end;

procedure PessEnderListGarantirUmItem(pPessEnderList: IPessEnderList);
var
  oPessEnder: IPessEnder;
begin
  if pPessEnderList.Count > 0 then
    exit;

  oPessEnder := PessEnderCreate;
  pPessEnderList.Add(oPessEnder);
end;

function EntEdCastToPessEnt(pEntEd: IEntEd): IPessEnt;
begin
  Result := TPessEnt(pEntEd);
end;

function EntDBICastToPessDBI(pEntDBI: IEntDBI): IPessDBI;
begin
  Result := TPessDBI(pEntDBI);
end;

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
begin
  Result := TPessLojaEnt(pEntEd);
end;

function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IPessLojaDBI;
begin
  Result := TPessLojaDBI(pEntDBI);
end;

//loja
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
////  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
  Result := TPessLojaDBI.Create(pDBConnection, pPessLojaEnt);
end;


(*


uses App.Ent.Ed, , , App.PessEnder.List,
  ;


implementation

uses App.Pess.Loja.Ent_u, App.Pess.Loja.DBI_u, App.Pess.Geral.Factory_u;





function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;
begin
////  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
  Result := TPessLojaDBI.Create(pDBConnection, pPessLojaEnt);
end;



*)

end.

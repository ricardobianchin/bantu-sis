unit App.Pess.Ent.Factory_u;

interface

uses App.PessEnder.List, Sis.DB.DBTypes, App.Ent.DBI, App.Ent.Ed, App.Pess.Ent,
  App.Pess.DBI, App.PessEnder;

//ender list
function PessEnderListCreate: IPessEnderList;
function PessEnderCreate: IPessEnder;
procedure PessEnderListGarantirUmItem(pPessEnderList: IPessEnderList);

function EntEdCastToPessEnt(pEntEd: IEntEd): IPessEnt;
function EntDBICastToPessDBI(pEntDBI: IEntDBI): IPessDBI;

implementation

uses App.PessEnder.List_u, App.Pess.DBI_u, App.Pess.Ent_u, App.PessEnder_u;

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

(*


uses App.Ent.Ed, , , App.PessEnder.List,
  ;


implementation

uses App.Pess.Loja.Ent_u, App.Pess.Loja.DBI_u, App.Pess.Geral.Factory_u;





function PessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt): IPessLojaDBI;//IEntDBI;
begin
//  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
  Result := TPessLojaDBI.Create(pDBConnection, pPessLojaEnt);
end;



*)

end.

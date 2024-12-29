unit Sis.Loja.Factory;

interface

uses Sis.Loja, Sis.ModuloSistema.Types, Sis.DB.DBTypes, Sis.Loja.DBI;

function SisLojaCreate(pDescr:string=''; pId:integer=0): ISisLoja;
function SisLojaDBICreate(pLoja: ISisLoja; pDBConnection: IDBConnection): ISisLojaDBI;
function SisLojaLeia(pLoja: ISisLoja; pDBConnection: IDBConnection): ISisLoja;

implementation

uses Sis.Usuario_u, Sis.Loja_u, Sis.Loja.DBI_u;

function SisLojaCreate(pDescr:string=''; pId:integer=0): ISisLoja;
begin
  Result := TSisLoja.Create(pDescr, pId);
end;

function SisLojaDBICreate(pLoja: ISisLoja; pDBConnection: IDBConnection): ISisLojaDBI;
begin
  Result := TSisLojaDBI.Create(pLoja, pDBConnection);
end;

function SisLojaLeia(pLoja: ISisLoja; pDBConnection: IDBConnection): ISisLoja;
var
  oLojaDBI: ISisLojaDBI;
  sMens: string;
begin
  oLojaDBI := SisLojaDBICreate(pLoja, pDBConnection);
  oLojaDBI.Ler(sMens);
end;

end.

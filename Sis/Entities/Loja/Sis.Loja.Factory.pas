unit Sis.Loja.Factory;

interface

uses Sis.Loja, Sis.ModuloSistema.Types, Sis.DB.DBTypes, Sis.Loja.DBI;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
function LojaDBICreate(pLoja: ILoja; pDBConnection: IDBConnection): ILojaDBI;
function LojaLeia(pLoja: ILoja; pDBConnection: IDBConnection): ILoja;

implementation

uses Sis.Usuario_u, Sis.Loja_u, Sis.Loja.DBI_u;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
begin
  Result := TLoja.Create(pDescr, pId);
end;

function LojaDBICreate(pLoja: ILoja; pDBConnection: IDBConnection): ILojaDBI;
begin
  Result := TLojaDBI.Create(pLoja, pDBConnection);
end;

function LojaLeia(pLoja: ILoja; pDBConnection: IDBConnection): ILoja;
var
  oLojaDBI: ILojaDBI;
  sMens: string;
begin
  oLojaDBI := LojaDBICreate(pLoja, pDBConnection);
  oLojaDBI.Ler(sMens);
end;


end.

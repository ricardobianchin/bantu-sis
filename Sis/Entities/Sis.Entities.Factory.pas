unit Sis.Entities.Factory;

interface

uses Sis.Loja, Sis.ModuloSistema.Types, Sis.ModuloSistema;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
function ModuloSistemaCreate(pTipoModuloSistema: TTipoModuloSistema): IModuloSistema;

implementation

uses Sis.Usuario_u, Sis.Loja_u, Sis.ModuloSistema_u;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
begin
  Result := TLoja.Create(pDescr, pId);
end;

function ModuloSistemaCreate(pTipoModuloSistema: TTipoModuloSistema): IModuloSistema;
begin
  Result := TModuloSistema.Create(pTipoModuloSistema);
end;

end.

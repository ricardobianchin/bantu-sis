unit Sis.Entities.Factory;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

function ModuloSistemaCreate(pTipoModuloSistema: TTipoModuloSistema): IModuloSistema;

implementation

uses Sis.ModuloSistema_u;

function ModuloSistemaCreate(pTipoModuloSistema: TTipoModuloSistema): IModuloSistema;
begin
  Result := TModuloSistema.Create(pTipoModuloSistema);
end;

end.

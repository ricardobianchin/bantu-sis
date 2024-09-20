unit Sis.Entities.Factory;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types;

function ModuloSistemaCreate(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo): IModuloSistema;

implementation

uses Sis.ModuloSistema_u;

function ModuloSistemaCreate(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo): IModuloSistema;
begin
  Result := TModuloSistema.Create(pTipoOpcaoSisModulo);
end;

end.

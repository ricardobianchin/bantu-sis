unit Sis.Entities.Factory;

interface

uses Sis.ModuloSistema, Sis.ModuloSistema.Types, Sis.Entities.Terminal,
  Sis.Entities.TerminalList;

function ModuloSistemaCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : IModuloSistema;

function TerminalCreate: ITerminal;
function TerminalListCreate: ITerminalList;

implementation

uses Sis.ModuloSistema_u, Sis.Entities.Terminal_u, Sis.Entities.TerminalList_u;

function ModuloSistemaCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : IModuloSistema;
begin
  Result := TModuloSistema.Create(pTipoOpcaoSisModulo);
end;

function TerminalCreate: ITerminal;
begin
  Result := TTerminal.Create;
end;

function TerminalListCreate: ITerminalList;
begin
  Result := TTerminalList.Create;
end;

end.

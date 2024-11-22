unit App.Est.Factory_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DB.DBTypes, System.Classes,
  Sis.Entities.Types, App.Est.Venda.CaixaSessao.DBI, Sis.Usuario;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;

implementation

uses App.Est.Prod.Barras.DBI_u, App.Est.Venda.CaixaSessao.DBI_u;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
begin
  Result := TBarrasDBI.Create(pDBConnection);
end;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;
begin
  Result := TCaixaSessaoDBI.Create(pDBConnection, pLogUsuario, pLojaId,
    pTerminalId, pMachineIdentId);
end;

end.

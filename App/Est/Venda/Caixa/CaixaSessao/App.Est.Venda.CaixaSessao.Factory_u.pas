unit App.Est.Venda.CaixaSessao.Factory_u;

interface

uses Sis.DB.DBTypes, System.Classes,
  Sis.Entities.Types, App.Est.Venda.CaixaSessao.DBI, Sis.Usuario;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;

implementation

uses App.Est.Venda.CaixaSessao.DBI_u;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;
begin
  Result := TCaixaSessaoDBI.Create(pDBConnection, pLogUsuario, pLojaId,
    pTerminalId, pMachineIdentId);
end;

end.

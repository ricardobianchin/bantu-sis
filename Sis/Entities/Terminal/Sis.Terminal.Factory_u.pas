unit Sis.Terminal.Factory_u;

interface

uses Sis.Terminal, Sis.TerminalList, Sis.Terminal.DBI, Sis.DB.DBTypes;

function TerminalCreate: ITerminal;
function TerminalListCreate: ITerminalList;
function TerminalDBICreate(pDBConnection: IDBConnection): ITerminalDBI;

implementation

uses Sis.Terminal_u, Sis.TerminalList_u, Sis.Terminal.DBI_u;

function TerminalCreate: ITerminal;
begin
  Result := TTerminal.Create;
end;

function TerminalListCreate: ITerminalList;
begin
  Result := TTerminalList.Create;
end;

function TerminalDBICreate(pDBConnection: IDBConnection): ITerminalDBI;
begin
  Result := TTerminalDBI.Create(pDBConnection);
end;

end.

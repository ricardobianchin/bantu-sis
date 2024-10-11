unit App.DB.Term.EnviarDados.Factory_u;

interface

uses App.DB.Term.EnviarDados, Sis.DB.DBTypes, App.DB.Term.EnviarTabela;

function TermEnviarDadosCreate(serv, term: IDBConnection): ITermEnviarDados;

function EnvTabTerminal(pServConn, pTermConn: IDBConnection): IEnviarTabela;

implementation

uses App.DB.Term.EnviarDados_u //
  , App.DB.Term.EnviarTabela.Terminal_u //
  ; //

function TermEnviarDadosCreate(serv, term: IDBConnection): ITermEnviarDados;
begin
  Result := TTermEnviarDados.Create(Serv, Term);
end;

function EnvTabTerminal(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnviarTabelaTerminal.Create(pServConn, pTermConn);
end;

end.

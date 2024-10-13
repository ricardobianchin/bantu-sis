unit App.DB.Term.EnviarDados.Factory_u;

interface

uses App.DB.Term.EnviarDados, Sis.DB.DBTypes, App.DB.Term.EnviarTabela;

function TermEnviarDadosCreate(serv, term: IDBConnection): ITermEnviarDados;

function EnvTabTerminal(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPagamentoForma(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPagamentoFormaTipo(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabLoja(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPessoa(pServConn, pTermConn: IDBConnection): IEnviarTabela;

implementation

uses App.DB.Term.EnviarDados_u //
  , App.DB.Term.EnviarTabela.Terminal_u //
  , App.DB.Term.EnviarTabela.PagamentoFormaTipo_u //
  , App.DB.Term.EnviarTabela.PagamentoForma_u //
  , App.DB.Term.EnviarTabela.Loja_u //
  , App.DB.Term.EnviarTabela.Pessoa_u //
  ; //

function TermEnviarDadosCreate(serv, term: IDBConnection): ITermEnviarDados;
begin
  Result := TTermEnviarDados.Create(Serv, Term);
end;

function EnvTabTerminal(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabTerminal.Create(pServConn, pTermConn);
end;

function EnvTabPagamentoForma(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabPagamentoForma.Create(pServConn, pTermConn);
end;

function EnvTabPagamentoFormaTipo(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabPagamentoFormaTipo.Create(pServConn, pTermConn);
end;

function EnvTabLoja(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabLoja.Create(pServConn, pTermConn);
end;

function EnvTabPessoa(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabPessoa.Create(pServConn, pTermConn);
end;

end.

unit App.DB.Term.EnviarDados.Factory_u;

interface

uses App.DB.Term.EnviarDados, Sis.DB.DBTypes, App.DB.Term.EnviarTabela;

function TermEnviarDadosCreate(serv, term: IDBConnection): ITermEnviarDados;

function EnvTabTerminal(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPagamentoForma(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPagamentoFormaTipo(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabLoja(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabPessoa(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabEndereco(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabFUncionario(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabLojaEhPessoa(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabUsuario(pServConn, pTermConn: IDBConnection): IEnviarTabela;
function EnvTabUsuarioPodeOpcaoSis(pServConn, pTermConn: IDBConnection): IEnviarTabela;

implementation

uses App.DB.Term.EnviarDados_u //
  , App.DB.Term.EnviarTabela.Terminal_u //
  , App.DB.Term.EnviarTabela.PagamentoFormaTipo_u //
  , App.DB.Term.EnviarTabela.PagamentoForma_u //
  , App.DB.Term.EnviarTabela.Loja_u //
  , App.DB.Term.EnviarTabela.Pessoa_u //
  , App.DB.Term.EnviarTabela.Endereco_u //
  , App.DB.Term.EnviarTabela.Funcionario_u //
  , App.DB.Term.EnviarTabela.LojaEhPessoa_u //
  , App.DB.Term.EnviarTabela.Usuario_u //
  , App.DB.Term.EnviarTabela.UsuarioPodeOpcaoSis_u //
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

function EnvTabEndereco(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabEndereco.Create(pServConn, pTermConn);
end;

function EnvTabFUncionario(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabFuncionario.Create(pServConn, pTermConn);
end;

function EnvTabLojaEhPessoa(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabLojaEhPessoa.Create(pServConn, pTermConn);
end;

function EnvTabUsuario(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabUsuario.Create(pServConn, pTermConn);
end;

function EnvTabUsuarioPodeOpcaoSis(pServConn, pTermConn: IDBConnection): IEnviarTabela;
begin
  Result := TEnvTabUsuarioPodeOpcaoSis.Create(pServConn, pTermConn);
end;

end.

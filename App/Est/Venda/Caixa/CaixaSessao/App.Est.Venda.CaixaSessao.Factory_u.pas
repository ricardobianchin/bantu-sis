unit App.Est.Venda.CaixaSessao.Factory_u;

interface

// System.Classes,

uses
  // caixa dbi
  Sis.DB.DBTypes, Sis.Entities.Types, App.Est.Venda.CaixaSessao.DBI, Sis.Usuario

  // opertipo list
    , App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;

function ICxOperacaoTipoCreate(pId: string; pCaption: string;
  pHabilitado: Boolean): ICxOperacaoTipo;
function ICxOperacaoTipoListCreate: ICxOperacaoTipoList;
function ICxOperacaoTipoDBICreate(pDBConnection: IDBConnection)
  : ICxOperacaoTipoDBI;

implementation

uses App.Est.Venda.CaixaSessao.DBI_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List_u;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;
begin
  Result := TCaixaSessaoDBI.Create(pDBConnection, pLogUsuario, pLojaId,
    pTerminalId, pMachineIdentId);
end;

function ICxOperacaoTipoCreate(pId: string; pCaption: string;
  pHabilitado: Boolean): ICxOperacaoTipo;
begin
  Result := TCxOperacaoTipo.Create(pId, pCaption, pHabilitado);
end;

function ICxOperacaoTipoListCreate: ICxOperacaoTipoList;
begin
  Result := TCxOperacaoTipoList.Create;
end;

function ICxOperacaoTipoDBICreate(pDBConnection: IDBConnection)
  : ICxOperacaoTipoDBI;
begin
  Result := TCxOperacaoTipoDBI.Create(pDBConnection);
end;

end.

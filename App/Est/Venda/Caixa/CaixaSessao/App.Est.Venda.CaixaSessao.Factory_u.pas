unit App.Est.Venda.CaixaSessao.Factory_u;

interface

// System.Classes,

uses Sis.DB.DBTypes, Sis.Entities.Types, Sis.Usuario, Vcl.ActnList,
  System.Classes

  // uses caixa sessao
    , App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.CaixaSessao.DBI

  // uses opertipo
    , App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List;

// function caixa sessao
function CaixaSessaoCreate(pLogUsuario: IUsuario; pLojaId: TLojaId = 0;
  pTerminalId: TTerminalId = 0; pId: integer = 0): ICaixaSessao;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;

// function operacao tipo
function CxOperacaoTipoCreate(pIdChar: string; pName: string; pAbrev: string;
  pCaption: string; pHint: string; pSinalNumerico: smallint;
  pHabilitadoDuranteSessao: Boolean): ICxOperacaoTipo;
function ICxOperacaoTipoListCreate: ICxOperacaoTipoList;
function ICxOperacaoTipoDBICreate(pDBConnection: IDBConnection)
  : ICxOperacaoTipoDBI;

// function operacao
function CxOperacaoActionCreate(AOwner: TComponent;
  pCxOperacaoTipo: ICxOperacaoTipo;
  pCxOperacaoTipoDBI: ICxOperacaoTipoDBI): TAction;

implementation

uses
  // uses impl caixa sessao
  App.Est.Venda.CaixaSessao.DBI_u,
  App.Est.Venda.Caixa.CaixaSessao_u,

  // uses impl oper tipo
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List_u,

  // uses impl oper
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint): ICaixaSessaoDBI;
begin
  Result := TCaixaSessaoDBI.Create(pDBConnection, pLogUsuario, pLojaId,
    pTerminalId, pMachineIdentId);
end;

function CxOperacaoTipoCreate(pIdChar: string; pName: string; pAbrev: string;
  pCaption: string; pHint: string; pSinalNumerico: smallint;
  pHabilitadoDuranteSessao: Boolean): ICxOperacaoTipo;
begin
  Result := TCxOperacaoTipo.Create(pIdChar, pName, pAbrev, pCaption, pHint,
    pSinalNumerico, pHabilitadoDuranteSessao);
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

function CaixaSessaoCreate(pLogUsuario: IUsuario; pLojaId: TLojaId;
  pTerminalId: TTerminalId; pId: integer): ICaixaSessao;
begin
  Result := TCaixaSessao.Create(pLogUsuario, pLojaId, pTerminalId, pId);
end;

function CxOperacaoActionCreate(AOwner: TComponent;
  pCxOperacaoTipo: ICxOperacaoTipo;
  pCxOperacaoTipoDBI: ICxOperacaoTipoDBI): TAction;
begin
  Result := nil;
  case pCxOperacaoTipo.Id of
    cxopNaoIndicado:
      ;
    cxopAbertura //
      , cxopSangria //
      , cxopSuprimento //
      , cxopFechamento: //
      Result := TCxOperacaoAction.Create(AOwner, pCxOperacaoTipo,
        pCxOperacaoTipoDBI);
    cxopVale:
      ;
    cxopDespesa:
      ;
    cxopConvenio:
      ;
    cxopCrediario:
      ;
    cxopDevolucao:
      ;
    cxopVenda:
      ;
  end;
end;

end.

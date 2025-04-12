unit App.Est.Venda.CaixaSessao.Factory_u;

interface

// System.Classes,

uses Sis.DB.DBTypes, Sis.Entities.Types, Sis.Usuario, Vcl.ActnList,
  System.Classes, App.Ent.Ed, App.Ent.DBI, App.AppObj, Sis.Types, App.Types,
  App.PDV.Controlador, Sis.UI.Frame.Bas.Filtro_u

  // uses caixa sessao
    , App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.CaixaSessao.DBI

  // uses opertipo
    , App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI

  // uses caixa operacao valor
    , App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CxValor,
  App.Est.Venda.Caixa.CxValorList

  // uses caixa operacao valor numerario
    , App.Est.Venda.Caixa.CxNumerario, App.Est.Venda.Caixa.CxNumerarioList;

// function caixa sessao
function CaixaSessaoCreate(pLogUsuario: IUsuario; pMachineIdentId: SmallInt;
  pLojaId: TLojaId = 0; pTerminalId: TTerminalId = 0; pId: integer = 0)
  : ICaixaSessao;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: SmallInt): ICaixaSessaoDBI;

// function operacao tipo
function CxOperacaoTipoCreate(pIdChar: string; pName: string; pAbrev: string;
  pCaption: string; pHint: string; pSinalNumerico: SmallInt;
  pHabilitadoDuranteSessao: Boolean): ICxOperacaoTipo;
function ICxOperacaoTipoListCreate: ICxOperacaoTipoList;
function ICxOperacaoTipoDBICreate(pDBConnection: IDBConnection)
  : ICxOperacaoTipoDBI;

// function operacao
function CxOperacaoActionCreate(AOwner: TComponent; pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo; pCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
  pCxOperacaoEnt: ICxOperacaoEnt; pCxOperacaoDBI: ICxOperacaoDBI;
  pAppObj: IAppObj; pUsuarioId: integer; pUsuarioNomeExib: string;
  pCxValorDBI: ICxValorDBI; pPDVControlador: IPDVControlador;
  pCaixaSessaoDBI: ICaixaSessaoDBI): TAction;

function CxOperacaoEntCreate(pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo): ICxOperacaoEnt;
function CxOperacaoDBICreate(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt; pUsuarioId: integer): ICxOperacaoDBI;
// IEntDBI;

function EntEdCastToCxOperacaoEnt(pEntEd: IEntEd): ICxOperacaoEnt;
function EntDBICastToCxOperacaoDBI(pEntDBI: IEntDBI): ICxOperacaoDBI;

function CxValorCreate(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;
function CxValorDBICreate(pDBConnection: IDBConnection): ICxValorDBI;

function CxValorListCreate: ICxValorList;

function CxNumerarioCreate(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
function CxNumerarioListCreate: ICxNumerarioList;

function SessFormFiltroFrameCreate(AOwner: TComponent; pOnChange: TNotifyEvent;
  pCaixaSessaoDBI: ICaixaSessaoDBI): TFiltroFrame;

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
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI_u,
  // uses caixa operacao valor numerario
  App.Est.Venda.Caixa.CxValor.DBI_u, App.Est.Venda.Caixa.CxValor_u,
  App.Est.Venda.Caixa.CxValorList_u, App.Est.Venda.Caixa.CxNumerario_u,
  App.Est.Venda.Caixa.CxNumerarioList_u, App.PDV.PDVSessForm.FiltroFrame_u;

function CaixaSessaoDBICreate(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: SmallInt): ICaixaSessaoDBI;
begin
  Result := TCaixaSessaoDBI.Create(pDBConnection, pLogUsuario, pLojaId,
    pTerminalId, pMachineIdentId);
end;

function CxOperacaoTipoCreate(pIdChar: string; pName: string; pAbrev: string;
  pCaption: string; pHint: string; pSinalNumerico: SmallInt;
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

function CaixaSessaoCreate(pLogUsuario: IUsuario; pMachineIdentId: SmallInt;
  pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer): ICaixaSessao;
begin
  Result := TCaixaSessao.Create(pLogUsuario, pMachineIdentId, pLojaId,
    pTerminalId, pId);
end;

function CxOperacaoActionCreate(AOwner: TComponent; pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo; pCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
  pCxOperacaoEnt: ICxOperacaoEnt; pCxOperacaoDBI: ICxOperacaoDBI;
  pAppObj: IAppObj; pUsuarioId: integer; pUsuarioNomeExib: string;
  pCxValorDBI: ICxValorDBI; pPDVControlador: IPDVControlador;
  pCaixaSessaoDBI: ICaixaSessaoDBI): TAction;
begin
  Result := nil;
  case pCxOperacaoTipo.Id of
    cxopNaoIndicado:
      ;
    cxopAbertura //
      , cxopSangria //
      , cxopSuprimento //
      , cxopFechamento: //
      Result := TCxOperacaoAction.Create(AOwner, pCaixaSessao, pCxOperacaoTipo,
        pCxOperacaoTipoDBI, pCxOperacaoEnt, pCxOperacaoDBI, pAppObj, pUsuarioId,
        pUsuarioNomeExib, pCxValorDBI, pPDVControlador, pCaixaSessaoDBI);
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

function EntEdCastToCxOperacaoEnt(pEntEd: IEntEd): ICxOperacaoEnt;
begin
  Result := TCxOperacaoEnt(pEntEd);
end;

function EntDBICastToCxOperacaoDBI(pEntDBI: IEntDBI): ICxOperacaoDBI;
begin
  Result := TCxOperacaoDBI(pEntDBI);
end;

function CxOperacaoEntCreate(pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo): ICxOperacaoEnt;
begin
  Result := TCxOperacaoEnt.Create(pCaixaSessao, pCxOperacaoTipo);
end;

function CxOperacaoDBICreate(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt; pUsuarioId: integer): ICxOperacaoDBI;
// IEntDBI;
begin
  Result := TCxOperacaoDBI.Create(pDBConnection, pCxOperacaoEnt, pUsuarioId);
end;

function CxValorCreate(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;
begin
  Result := TCxValor.Create(pPagamentoFormaId, pValor);
end;

function CxValorDBICreate(pDBConnection: IDBConnection): ICxValorDBI;
begin
  Result := TCxValorDBI.Create(pDBConnection);
end;

function CxValorListCreate: ICxValorList;
begin
  Result := TCxValorList.Create;
end;

function CxNumerarioCreate(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
begin
  Result := TCxNumerario.Create(pValor, pQtd);
end;

function CxNumerarioListCreate: ICxNumerarioList;
begin
  Result := TCxNumerarioList.Create;
end;

function SessFormFiltroFrameCreate(AOwner: TComponent; pOnChange: TNotifyEvent;
  pCaixaSessaoDBI: ICaixaSessaoDBI): TFiltroFrame;
begin
  Result := TSessFormFiltroFrame.Create(AOwner, pOnChange, pCaixaSessaoDBI);
end;

end.

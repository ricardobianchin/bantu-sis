unit App.Est.Venda.CaixaSessaoDM_u;

interface

uses
  System.SysUtils, System.Classes, App.AppObj, Sis.Entities.Types, App.DB.Utils,
  System.Actions, Vcl.ActnList, Sis.DB.DBTypes, Vcl.ComCtrls, Data.DB,
  Sis.Terminal, Sis.Usuario, App.Est.Types_u, Vcl.DBActns,
  App.Est.Venda.Caixa.CaixaSessao,
  Sis.UI.Controls.TToolBar, App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  App.Est.Venda.CaixaSessaoRecord_u,
  App.Est.Venda.CaixaSessao.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u,
  App.Est.Venda.Caixa.CxValor.DBI, App.PDV.Controlador;

type
  /// <summary>
  /// AnaliseCaixa;
  /// deve analisar o ambiente
  /// detectar como estão a abertura de caixa, se tem venda interrompida...
  /// </summary>
  TCaixaSessaoDM = class(TDataModule)
    CaixaSessaoActionList: TActionList;
    CaixaSessaoFormAbrirAction_CaixaSessaoDM: TAction;
    CxOperacaoActionList: TActionList;
    AberturaAction: TAction;
    SuprimentoAction: TAction;
    SangriaAction: TAction;
    DespesaAction: TAction;
    ValeAction: TAction;
    FechamentoAction: TAction;
    procedure CxOperacaoActionListExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure AberturaActionExecute(Sender: TObject);
    procedure SuprimentoActionExecute(Sender: TObject);
    procedure SangriaActionExecute(Sender: TObject);
    procedure DespesaActionExecute(Sender: TObject);
    procedure FechamentoActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    {
      FTerminalId nao seria necessario, pois tem o FTerminal
      mas este objecto será usado tb na retaguarda, entao
      FTerminalId = 0 e FTerminal = nil
    }
    FTerminalId: TTerminalId;
    FTerminal: ITerminal;

    FCaixaSessao: ICaixaSessao;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FAlvoDBConnection: IDBConnection;
    FLogUsuario: IUsuario;

    FCaixaSessaoSituacao: TCaixaSessaoSituacao;
    FCxOperacaoTipoList: ICxOperacaoTipoList;
    FPDVControlador: IPDVControlador;

    procedure CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
  protected
  public
    { Public declarations }
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property LogUsuario: IUsuario read FLogUsuario;

    property CaixaSessao: ICaixaSessao read FCaixaSessao;
    property CaixaSessaoDBI: ICaixaSessaoDBI read FCaixaSessaoDBI;

    property CaixaSessaoSituacao: TCaixaSessaoSituacao
      read FCaixaSessaoSituacao;

    procedure AnaliseCaixa;
    function GetAction(pCxOpTipo: TCxOpTipo): TAction;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pTerminalId: TTerminalId; pLogUsuario: IUsuario;
      pPDVControlador: IPDVControlador); reintroduce;
  end;

var
  CaixaSessaoDM: TCaixaSessaoDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Sis.DB.Factory, App.Est.Venda.CaixaSessao.Factory_u,
  {App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent_u,}
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, Sis.Types.strings_u,
  App.UI.Form.Ed.CxOperacao.UmValor_u, App.UI.Form.Ed.CxOperacao.Valores_u,
  App.UI.FormEd.CxOperacao.Despesa_u;

{$R *.dfm}
{ TCaixaSessaoDM }

constructor TCaixaSessaoDM.Create(AOwner: TComponent; pAppObj: IAppObj;
  pTerminalId: TTerminalId; pLogUsuario: IUsuario;
  pPDVControlador: IPDVControlador);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FLogUsuario := pLogUsuario;
  FTerminalId := pTerminalId;
  FPDVControlador := pPDVControlador;
  if FTerminalId = 0 then
  begin
    FTerminal := nil;
    rDBConnectionParams := TerminalIdToDBConnectionParams(FTerminalId, FAppObj);
  end
  else
  begin
    FTerminal := FAppObj.TerminalList.TerminalIdToTerminal(FTerminalId);
    rDBConnectionParams.Server := FTerminal.IdentStr;
    rDBConnectionParams.Arq := FTerminal.LocalArqDados;
    rDBConnectionParams.Database := FTerminal.Database;
  end;

  FAlvoDBConnection := DBConnectionCreate('CaixaSessaoDM.Alvo.Conn',
    FAppObj.SisConfig, rDBConnectionParams, nil, nil);

  FCaixaSessao := CaixaSessaoCreate(FLogUsuario //
    , FAppObj.SisConfig.LocalMachineId.IdentId //
    , FAppObj.Loja.Id //
    , FTerminalId);

  FCaixaSessaoDBI := CaixaSessaoDBICreate(FAlvoDBConnection, pLogUsuario,
    FAppObj.Loja.Id, FTerminalId, FAppObj.SisConfig.LocalMachineId.IdentId);

  FCxOperacaoTipoDBI := ICxOperacaoTipoDBICreate(FAlvoDBConnection);

  FCxOperacaoTipoList := ICxOperacaoTipoListCreate;

  // FCxOperacaoTipoDBI.ForEach(vaNull, CxOperacaoTipoListLeReg);
end;

procedure TCaixaSessaoDM.CxOperacaoActionListExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action is TCxOperacaoAction then
  begin
    TCxOperacaoAction(Action).CxOperacaoEnt.LimparEnt;
    Handled := False;
  end;
end;

procedure TCaixaSessaoDM.CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
var
  o: ICxOperacaoTipo;
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoDBI: ICxOperacaoDBI;
  oCxValorDBI: ICxValorDBI;
begin
  if pRecNo = -1 then
    exit;

  o := CxOperacaoTipoCreate( //
    q.Fields[0 { pIdChar } ].AsString //
    , q.Fields[1 { pName } ].AsString //
    , q.Fields[2 { pAbrev } ].AsString //
    , CapitalizeWords(q.Fields[3 { pCaption } ].AsString) //
    , CapitalizeWords(q.Fields[4 { pHint } ].AsString) //
    , q.Fields[5 { pSinalNumerico } ].AsInteger //
    , q.Fields[6 { pHabilitadoDuranteSessao } ].AsBoolean //
    );
  FCxOperacaoTipoList.Add(o);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, o);
  oCxOperacaoDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);

  o.Action := CxOperacaoActionCreate(CxOperacaoActionList, FCaixaSessao, o,
    FCxOperacaoTipoDBI, oCxOperacaoEnt, oCxOperacaoDBI, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxValorDBI, FPDVControlador, FCaixaSessaoDBI);
end;

procedure TCaixaSessaoDM.DespesaActionExecute(Sender: TObject);
var
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoTipo: ICxOperacaoTipo;
  oDBI: ICxOperacaoDBI;
  oForm: TCxOperDespesaEdForm;
  oCxValorDBI: ICxValorDBI;
begin
  oCxOperacaoTipo := CxOperacaoTipoCreate('%', 'Despesa', 'DESP', 'Despesa',
    'Pagamento de Despesas', -1, True);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, oCxOperacaoTipo);
  oDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);
  oForm := TCxOperDespesaEdForm.Create(Self, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxOperacaoEnt, oDBI, oCxValorDBI);
  oForm.Perg;
  oForm.Free;

  {
    TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

  }
  {
    OPER_TIPO_ID;NAME;ABREV;CAPTION;HINT;SINAL_NUMERICO;HABILITADO_DURANTE_SESSAO;ORDEM_EXIB
    #032;NaoIndicado;NaoInd;N?o Indicado;N?o Indicado;0;FALSE;NULL
    #033;Abertura;Abe;Abrir o Caixa;Abrir o Caixa;1;FALSE;1
    #034;Sangria;Sang;Sangria;Sa#237da de Dinheiro da Gaveta;-1;TRUE;2
    #035;Suprimento;Sup;Suprimento;Entrada de Dinheiro na Gaveta;1;TRUE;3
    #036;Vale;Vale;Vale para Funcionario;Pagamento de Vale a Funcion?rio;-1;TRUE;NULL
    #037;Despesa;Desp;Despesa;Pagamento de Despesas;-1;TRUE;NULL
    #038;Convenio;Conv;Conv#234nio;Baixa de Conv?nio;1;TRUE;NULL
    #039;Crediario;Cre;Credi#225rio;Baixa de Credi?rio;1;TRUE;NULL
    #040;Fechamento;Fech;Fechar o caixa;Finaliza o caixa que estava aberto;-1;TRUE;9
    #041;Devolucao;Dev;Devolu#231#227o;Devolu#231#227o;0;TRUE;NULL
    #042;Venda;Ven;Venda;Venda;1;TRUE;NULL
  }
end;

procedure TCaixaSessaoDM.FechamentoActionExecute(Sender: TObject);
var
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoTipo: ICxOperacaoTipo;
  oDBI: ICxOperacaoDBI;
  oForm: TCxOperValoresEdForm;
  oCxValorDBI: ICxValorDBI;
begin
  oCxOperacaoTipo := CxOperacaoTipoCreate('(', 'Fechamento', 'FECH',
    'Fechamento', 'Terminar a Sessão de Caixa', 0, True);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, oCxOperacaoTipo);
  oDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);

  oForm := TCxOperValoresEdForm.Create(Self, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxOperacaoEnt, oDBI, oCxValorDBI);

  oForm.Perg;
  oForm.Free;

  {
    TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

  }
  {
    OPER_TIPO_ID;NAME;ABREV;CAPTION;HINT;SINAL_NUMERICO;HABILITADO_DURANTE_SESSAO;ORDEM_EXIB
    #032;NaoIndicado;NaoInd;N?o Indicado;N?o Indicado;0;FALSE;NULL
    #033;Abertura;Abe;Abrir o Caixa;Abrir o Caixa;1;FALSE;1
    #034;Sangria;Sang;Sangria;Sa#237da de Dinheiro da Gaveta;-1;TRUE;2
    #035;Suprimento;Sup;Suprimento;Entrada de Dinheiro na Gaveta;1;TRUE;3
    #036;Vale;Vale;Vale para Funcionario;Pagamento de Vale a Funcion?rio;-1;TRUE;NULL
    #037;Despesa;Desp;Despesa;Pagamento de Despesas;-1;TRUE;NULL
    #038;Convenio;Conv;Conv#234nio;Baixa de Conv?nio;1;TRUE;NULL
    #039;Crediario;Cre;Credi#225rio;Baixa de Credi?rio;1;TRUE;NULL
    #040;Fechamento;Fech;Fechar o caixa;Finaliza o caixa que estava aberto;-1;TRUE;9
    #041;Devolucao;Dev;Devolu#231#227o;Devolu#231#227o;0;TRUE;NULL
    #042;Venda;Ven;Venda;Venda;1;TRUE;NULL
  }
end;

function TCaixaSessaoDM.GetAction(pCxOpTipo: TCxOpTipo): TAction;
begin
  case pCxOpTipo of
    cxopNaoIndicado:
      ;
    cxopAbertura:
      Result := AberturaAction;
    cxopSangria:
      Result := SangriaAction;
    cxopSuprimento:
      Result := SuprimentoAction;
    cxopVale:
      Result := ValeAction;
    cxopDespesa:
      Result := DespesaAction;
    cxopConvenio:
      ;
    cxopCrediario:
      ;
    cxopFechamento:
      Result := FechamentoAction;
    cxopDevolucao:
      ;
    cxopVenda:
      ;
  end;

  // Result := FCxOperacaoTipoList.CxOpTipoToOperacaoTipo(pCxOpTipo).Action;
end;

procedure TCaixaSessaoDM.SangriaActionExecute(Sender: TObject);
var
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoTipo: ICxOperacaoTipo;
  oDBI: ICxOperacaoDBI;
  oForm: TCxOperUmValorEdForm;
  oCxValorDBI: ICxValorDBI;
begin
  oCxOperacaoTipo := CxOperacaoTipoCreate('"', 'Sangria', 'SANG', 'Sangria',
    'Retirar dinheiro na gaveta', -1, True);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, oCxOperacaoTipo);
  oDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);
  oForm := TCxOperUmValorEdForm.Create(Self, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxOperacaoEnt, oDBI, oCxValorDBI);
  oForm.Perg;
  oForm.Free;

  {
    TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

  }
  {
    OPER_TIPO_ID;NAME;ABREV;CAPTION;HINT;SINAL_NUMERICO;HABILITADO_DURANTE_SESSAO;ORDEM_EXIB
    #032;NaoIndicado;NaoInd;N?o Indicado;N?o Indicado;0;FALSE;NULL
    #033;Abertura;Abe;Abrir o Caixa;Abrir o Caixa;1;FALSE;1
    #034;Sangria;Sang;Sangria;Sa#237da de Dinheiro da Gaveta;-1;TRUE;2
    #035;Suprimento;Sup;Suprimento;Entrada de Dinheiro na Gaveta;1;TRUE;3
    #036;Vale;Vale;Vale para Funcionario;Pagamento de Vale a Funcion?rio;-1;TRUE;NULL
    #037;Despesa;Desp;Despesa;Pagamento de Despesas;-1;TRUE;NULL
    #038;Convenio;Conv;Conv#234nio;Baixa de Conv?nio;1;TRUE;NULL
    #039;Crediario;Cre;Credi#225rio;Baixa de Credi?rio;1;TRUE;NULL
    #040;Fechamento;Fech;Fechar o caixa;Finaliza o caixa que estava aberto;-1;TRUE;9
    #041;Devolucao;Dev;Devolu#231#227o;Devolu#231#227o;0;TRUE;NULL
    #042;Venda;Ven;Venda;Venda;1;TRUE;NULL
  }
end;

procedure TCaixaSessaoDM.SuprimentoActionExecute(Sender: TObject);
var
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoTipo: ICxOperacaoTipo;
  oDBI: ICxOperacaoDBI;
  oForm: TCxOperUmValorEdForm;
  oCxValorDBI: ICxValorDBI;
begin
  oCxOperacaoTipo := CxOperacaoTipoCreate('#', 'Suprimento', 'SUP',
    'Suprimento', 'Adicionar dinheiro na gaveta', 1, True);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, oCxOperacaoTipo);
  oDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);
  oForm := TCxOperUmValorEdForm.Create(Self, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxOperacaoEnt, oDBI, oCxValorDBI);
  oForm.Perg;
  oForm.Free;

  {
    TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

  }
  {
    OPER_TIPO_ID;NAME;ABREV;CAPTION;HINT;SINAL_NUMERICO;HABILITADO_DURANTE_SESSAO;ORDEM_EXIB
    #032;NaoIndicado;NaoInd;N?o Indicado;N?o Indicado;0;FALSE;NULL
    #033;Abertura;Abe;Abrir o Caixa;Abrir o Caixa;1;FALSE;1
    #034;Sangria;Sang;Sangria;Sa#237da de Dinheiro da Gaveta;-1;TRUE;2
    #035;Suprimento;Sup;Suprimento;Entrada de Dinheiro na Gaveta;1;TRUE;3
    #036;Vale;Vale;Vale para Funcionario;Pagamento de Vale a Funcion?rio;-1;TRUE;NULL
    #037;Despesa;Desp;Despesa;Pagamento de Despesas;-1;TRUE;NULL
    #038;Convenio;Conv;Conv#234nio;Baixa de Conv?nio;1;TRUE;NULL
    #039;Crediario;Cre;Credi#225rio;Baixa de Credi?rio;1;TRUE;NULL
    #040;Fechamento;Fech;Fechar o caixa;Finaliza o caixa que estava aberto;-1;TRUE;9
    #041;Devolucao;Dev;Devolu#231#227o;Devolu#231#227o;0;TRUE;NULL
    #042;Venda;Ven;Venda;Venda;1;TRUE;NULL
  }
end;

procedure TCaixaSessaoDM.AberturaActionExecute(Sender: TObject);
var
  oCxOperacaoEnt: ICxOperacaoEnt;
  oCxOperacaoTipo: ICxOperacaoTipo;
  oDBI: ICxOperacaoDBI;
  oForm: TCxOperUmValorEdForm;
  oCxValorDBI: ICxValorDBI;
begin
  oCxOperacaoTipo := CxOperacaoTipoCreate('!', 'Abertura', 'ABE',
    'Abrir o Caixa', 'Abrir o Caixa', 1, False);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, oCxOperacaoTipo);
  oDBI := CxOperacaoDBICreate(FAlvoDBConnection, oCxOperacaoEnt,
    FLogUsuario.Id);
  oCxValorDBI := CxValorDBICreate(FAlvoDBConnection);
  oForm := TCxOperUmValorEdForm.Create(Self, FAppObj, FLogUsuario.Id,
    FLogUsuario.NomeExib, oCxOperacaoEnt, oDBI, oCxValorDBI);
  oForm.Perg;
  oForm.Free;

  {
    TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

  }
  {
    OPER_TIPO_ID;NAME;ABREV;CAPTION;HINT;SINAL_NUMERICO;HABILITADO_DURANTE_SESSAO;ORDEM_EXIB
    #032;NaoIndicado;NaoInd;N?o Indicado;N?o Indicado;0;FALSE;NULL
    #033;Abertura;Abe;Abrir o Caixa;Abrir o Caixa;1;FALSE;1
    #034;Sangria;Sang;Sangria;Sa#237da de Dinheiro da Gaveta;-1;TRUE;2
    #035;Suprimento;Sup;Suprimento;Entrada de Dinheiro na Gaveta;1;TRUE;3
    #036;Vale;Vale;Vale para Funcionario;Pagamento de Vale a Funcion?rio;-1;TRUE;NULL
    #037;Despesa;Desp;Despesa;Pagamento de Despesas;-1;TRUE;NULL
    #038;Convenio;Conv;Conv#234nio;Baixa de Conv?nio;1;TRUE;NULL
    #039;Crediario;Cre;Credi#225rio;Baixa de Credi?rio;1;TRUE;NULL
    #040;Fechamento;Fech;Fechar o caixa;Finaliza o caixa que estava aberto;-1;TRUE;9
    #041;Devolucao;Dev;Devolu#231#227o;Devolu#231#227o;0;TRUE;NULL
    #042;Venda;Ven;Venda;Venda;1;TRUE;NULL
  }
end;

procedure TCaixaSessaoDM.AnaliseCaixa;
var
  Resultado: Boolean;
  rCaixaSessao: TCaixaSessaoRec;
begin
  FCaixaSessao.Zerar;

  Resultado := FCaixaSessaoDBI.CaixaSessaoAbertoGet(rCaixaSessao);
  if not Resultado then
  begin
    FCaixaSessaoSituacao := cxFechado;
    exit;
  end;

  if not rCaixaSessao.Aberto then
  begin
    FCaixaSessaoSituacao := cxFechado;
    exit;
  end;

  if FLogUsuario.Id = rCaixaSessao.PessoaId then
  begin
    FCaixaSessaoSituacao := cxAberto;
    FCaixaSessao.Id := rCaixaSessao.SessId;
    FCaixaSessao.Aberto := rCaixaSessao.Aberto;
    FCaixaSessao.AbertoEm := rCaixaSessao.AbertoEm;
    FCaixaSessao.LogUsuario.Id := rCaixaSessao.PessoaId;
    FCaixaSessao.LogUsuario.NomeExib := rCaixaSessao.apelido;
    exit;
  end;

  FCaixaSessaoSituacao := cxAbertoPorOutroUsuario;
end;

end.

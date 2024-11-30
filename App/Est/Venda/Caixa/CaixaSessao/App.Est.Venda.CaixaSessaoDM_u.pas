unit App.Est.Venda.CaixaSessaoDM_u;

interface

uses
  System.SysUtils, System.Classes, App.AppObj, Sis.Entities.Types, App.DB.Utils,
  System.Actions, Vcl.ActnList, Sis.DB.DBTypes, Vcl.ComCtrls, Data.DB,
  Sis.Entities.Terminal, Sis.Usuario, App.Est.Types_u, Vcl.DBActns,
  App.Est.Venda.Caixa.CaixaSessao,
  Sis.UI.Controls.TToolBar, App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  App.Est.Venda.CaixaSessaoRecord_u,
  App.Est.Venda.CaixaSessao.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent
  , App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u
    ;

type
  /// <summary>
  ///  AnaliseCaixa;
  ///  deve analisar o ambiente
  ///  detectar como estão a abertura de caixa, se tem venda interrompida...
  /// </summary>
  TCaixaSessaoDM = class(TDataModule)
    CaixaSessaoActionList: TActionList;
    CaixaSessaoFormAbrirAction_CaixaSessaoDM: TAction;
    CxOperacaoActionList: TActionList;
    procedure CxOperacaoActionListExecute(Action: TBasicAction;
      var Handled: Boolean);
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
    FToolBar: TToolBar;

    procedure CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
  protected
    property Terminal: ITerminal read FTerminal;
  public
    { Public declarations }
    property CaixaSessao: ICaixaSessao read FCaixaSessao;
    property CaixaSessaoSituacao: TCaixaSessaoSituacao
      read FCaixaSessaoSituacao;

    procedure AnaliseCaixa;
    function GetAction(pCxOpTipo: TCxOpTipo): TAction;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pTerminalId: TTerminalId; pLogUsuario: IUsuario; pToolBar: TToolBar);
      reintroduce;
  end;

var
  CaixaSessaoDM: TCaixaSessaoDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Sis.DB.Factory, App.Est.Venda.CaixaSessao.Factory_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent_u;

{$R *.dfm}
{ TCaixaSessaoDM }

constructor TCaixaSessaoDM.Create(AOwner: TComponent; pAppObj: IAppObj;
  pTerminalId: TTerminalId; pLogUsuario: IUsuario; pToolBar: TToolBar);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FLogUsuario := pLogUsuario;
  FTerminalId := pTerminalId;
  FToolBar := pToolBar;
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

  FCaixaSessao := CaixaSessaoCreate(FLogUsuario, FAppObj.Loja.Id, FTerminalId);

  FCaixaSessaoDBI := CaixaSessaoDBICreate(FAlvoDBConnection, pLogUsuario,
    FAppObj.Loja.Id, FTerminalId, FAppObj.SisConfig.LocalMachineId.IdentId);

  FCxOperacaoTipoDBI := ICxOperacaoTipoDBICreate(FAlvoDBConnection);

  FCxOperacaoTipoList := ICxOperacaoTipoListCreate;

  FCxOperacaoTipoDBI.ForEach(vaNull, CxOperacaoTipoListLeReg);
end;

procedure TCaixaSessaoDM.CxOperacaoActionListExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if action is TCxOperacaoAction then
  begin
    TCxOperacaoAction(Action).CxOperacaoEnt.LimparEnt;
    Handled:= False;
  end;
end;

procedure TCaixaSessaoDM.CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
var
  o: ICxOperacaoTipo;
  oCxOperacaoEnt: ICxOperacaoEnt;
begin
  if pRecNo = -1 then
    exit;

  o := CxOperacaoTipoCreate( //
    q.Fields[0 { pIdChar } ].AsString //
    , q.Fields[1 { pName } ].AsString //
    , q.Fields[2 { pAbrev } ].AsString //
    , q.Fields[3 { pCaption } ].AsString //
    , q.Fields[4 { pHint } ].AsString //
    , q.Fields[5 { pSinalNumerico } ].AsInteger //
    , q.Fields[6 { pHabilitadoDuranteSessao } ].AsBoolean //
    );
  FCxOperacaoTipoList.Add(o);

  oCxOperacaoEnt := CxOperacaoEntCreate(FCaixaSessao, o);

  o.Action := CxOperacaoActionCreate(CxOperacaoActionList, o,
    FCxOperacaoTipoDBI, oCxOperacaoEnt, FAppObj);
  if o.Id <> cxopAbertura then
    ToolBarAddButton(o.Action, FToolBar);
end;

function TCaixaSessaoDM.GetAction(pCxOpTipo: TCxOpTipo): TAction;
begin
  Result := FCxOperacaoTipoList.CxOpTipoToOperacaoTipo(pCxOpTipo).Action;
end;

procedure TCaixaSessaoDM.AnaliseCaixa;
var
  Resultado: Boolean;
  rCaixaSessao: TCaixaSessaoRec;
begin
  FCaixaSessao.Zerar;

  Resultado := FCaixaSessaoDBI.CaixaSessaoAbertoGet(rCaixaSessao);
  if not Resultado then
    exit;

  if not rCaixaSessao.Aberto then
  begin
    FCaixaSessaoSituacao := cxFechado;
    exit;
  end;

  if FLogUsuario.Id = rCaixaSessao.PessoaId then
  begin
    FCaixaSessaoSituacao := cxAberto;
    FCaixaSessao.Id := rCaixaSessao.SessId;
    exit;
  end;

  FCaixaSessaoSituacao := cxAbertoPorOutroUsuario;
end;

end.

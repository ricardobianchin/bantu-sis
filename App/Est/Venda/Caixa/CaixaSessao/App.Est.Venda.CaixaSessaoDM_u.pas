unit App.Est.Venda.CaixaSessaoDM_u;

interface

uses
  System.SysUtils, System.Classes, App.AppObj, Sis.Entities.Types, App.DB.Utils,
  System.Actions, Vcl.ActnList, Sis.DB.DBTypes, Vcl.ComCtrls, Data.DB,
  Sis.Entities.Terminal, Sis.Usuario, App.Est.Types_u, Vcl.DBActns,
  Sis.UI.Controls.TToolBar, App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  App.Est.Venda.CaixaSessaoRecord_u, //
  App.Est.Venda.CaixaSessao.DBI, //
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, //
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List, //
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI //
    ;

type
  TCaixaSessaoDM = class(TDataModule)
    CaixaSessaoActionList: TActionList;
    CaixaSessaoFormAbrirAction_CaixaSessaoDM: TAction;
    CxOperacaoActionList: TActionList;
  private
    { Private declarations }
    FAppObj: IAppObj;
    FTerminalId: TTerminalId;
    FTerminal: ITerminal;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FAlvoDBConnection: IDBConnection;
    FLogUsuario: IUsuario;

    FCaixaSessao: TCaixaSessaoRec;
    FCaixaSessaoSituacao: TCaixaSessaoSituacao;
    FCxOperacaoTipoList: ICxOperacaoTipoList;
    FToolBar: TToolBar;

    procedure CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
  protected
    property Terminal: ITerminal read FTerminal;
  public
    { Public declarations }
    property CaixaSessao: TCaixaSessaoRec read FCaixaSessao;
    property CaixaSessaoSituacao: TCaixaSessaoSituacao
      read FCaixaSessaoSituacao;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pTerminalId: TTerminalId; pLogUsuario: IUsuario; pToolBar: TToolBar);
      reintroduce;

    procedure Analisar;
    function GetAction(pCxOpTipo: TCxOpTipo): TAction;
  end;

var
  CaixaSessaoDM: TCaixaSessaoDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Sis.DB.Factory, App.Est.Venda.CaixaSessao.Factory_u;

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

  FCaixaSessaoDBI := CaixaSessaoDBICreate(FAlvoDBConnection, pLogUsuario,
    FAppObj.Loja.Id, FTerminalId, FAppObj.SisConfig.LocalMachineId.IdentId);

  FCxOperacaoTipoDBI := ICxOperacaoTipoDBICreate(FAlvoDBConnection);

  FCxOperacaoTipoList := ICxOperacaoTipoListCreate;

  FCxOperacaoTipoDBI.ForEach(vaNull, CxOperacaoTipoListLeReg);
end;

procedure TCaixaSessaoDM.CxOperacaoTipoListLeReg(q: TDataSet; pRecNo: integer);
var
  o: ICxOperacaoTipo;
begin
  if pRecNo = -1 then
    exit;

  o := CxOperacaoTipoCreate( //
    q.Fields[0 { pIdChar } ].AsString //
    , q.Fields[1 { pName } ].AsString //
    , q.Fields[2 { pCaption } ].AsString //
    , q.Fields[3 { pHint } ].AsString //
    , q.Fields[4 { pSinalNumerico } ].AsInteger //
    , q.Fields[5 { pHabilitadoDuranteSessao } ].AsBoolean //
    );
  FCxOperacaoTipoList.Add(o);

  o.Action := CxOperacaoActionCreate(CxOperacaoActionList, o,
    FCxOperacaoTipoDBI);

  ToolBarAddButton(o.Action, FToolBar);
end;

function TCaixaSessaoDM.GetAction(pCxOpTipo: TCxOpTipo): TAction;
begin
  Result := FCxOperacaoTipoList.CxOpTipoToOperacaoTipo(pCxOpTipo).Action;
end;

procedure TCaixaSessaoDM.Analisar;
var
  Resultado: Boolean;
begin
  Resultado := FCaixaSessaoDBI.CaixaSessaoAbertoGet(FCaixaSessao);
  if not Resultado then
    exit;

  if not FCaixaSessao.Aberto then
  begin
    FCaixaSessaoSituacao := cxFechado;
    exit;
  end;

  if FLogUsuario.Id = FCaixaSessao.PessoaId then
  begin
    FCaixaSessaoSituacao := cxAberto;
    exit;
  end;

  FCaixaSessaoSituacao := cxAbertoPorOutroUsuario;
end;

end.

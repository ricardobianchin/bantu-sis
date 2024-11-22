unit App.Est.Venda.CaixaSessaoDM_u;

interface

uses
  System.SysUtils, System.Classes, App.AppObj, Sis.Entities.Types, App.DB.Utils,
  App.Est.Venda.CaixaSessao.DBI, System.Actions, Vcl.ActnList, Sis.DB.DBTypes,
  Sis.Entities.Terminal, Sis.Usuario, App.Est.Types_u, App.Est.Venda.CaixaSessaoRecord_u;

type
  TCaixaSessaoDM = class(TDataModule)
    CaixaActionList: TActionList;
    AbrirAction_CaixaSessaoDM: TAction;
    SessoesAbrirAction_CaixaSessaoDM: TAction;
    procedure AbrirAction_CaixaSessaoDMExecute(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FTerminalId: TTerminalId;
    FTerminal: ITerminal;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FAlvoDBConnection: IDBConnection;
    FLogUsuario: IUsuario;

    FCaixaSessao: TCaixaSessaoRec;
    //  TCaixaSessaoSituacao = (cxFechado, cxAberto, cxAbertoPorOutroUsuario);
    FCaixaSessaoSituacao: TCaixaSessaoSituacao;
  protected
    property Terminal: ITerminal read FTerminal;
  public
    { Public declarations }
    property CaixaSessao: TCaixaSessaoRec read FCaixaSessao;
    property CaixaSessaoSituacao: TCaixaSessaoSituacao read FCaixaSessaoSituacao;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pTerminalId: TTerminalId; pLogUsuario: IUsuario); reintroduce;
    procedure Analisar;
  end;

var
  CaixaSessaoDM: TCaixaSessaoDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Sis.DB.Factory, App.Est.Factory_u;

{$R *.dfm}

{ TCaixaSessaoDM }

constructor TCaixaSessaoDM.Create(AOwner: TComponent; pAppObj: IAppObj;
      pTerminalId: TTerminalId; pLogUsuario: IUsuario);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FLogUsuario := pLogUsuario;
  FTerminalId := pTerminalId;

  if FTerminalId = 0 then
  begin
    FTerminal := nil;
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (FTerminalId, FAppObj);
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
end;

procedure TCaixaSessaoDM.AbrirAction_CaixaSessaoDMExecute(Sender: TObject);
begin
  //
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

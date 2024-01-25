unit App.UI.Sessoes.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Sis.DB.DBTypes,
  Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  Sis.UI.IO.Output, App.Sessao.Eventos, Sis.UI.Form.Login.Config,
  App.Sessao.Criador.List;

type
  TSessoesFrame = class(TFrame)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    SessoesScrollBox: TScrollBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    AbrirRetaguardaAction: TAction;
    procedure AbrirRetaguardaActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FSessaoEventos: ISessaoEventos;
    FLoginConfig: ILoginConfig;

    FSessaoCriadorList: ISessaoCriadorList;

    procedure PrepSessaoCriadorList;
  public
    { Public declarations }

    procedure ExecuteAutoLogin;

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      pSessaoEventos: ISessaoEventos; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pProcessLog: IProcessLog;
      pOutput: IOutput); reintroduce;
  end;

implementation

{$R *.dfm}

uses Sis.Usuario, Sis.DB.Factory, App.DB.Utils, Sis.Usuario.DBI,
  Sis.Usuario.Factory, Sis.UI.Form.Login_u, App.Sessao.Factory;

procedure TSessoesFrame.AbrirRetaguardaActionExecute(Sender: TObject);
var
  oUsuario: IUsuario;
  oUsuarioDBI: IUsuarioDBI;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
begin
  oUsuario := UsuarioCreate();

  DBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    FAppInfo, FSisConfig);
  oDBConnection := DBConnectionCreate('Abr.Retag.DBConn', FSisConfig, FDBMS,
    DBConnectionParams, FProcessLog, FOutput);

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario);
  Sis.UI.Form.Login_u.LoginPerg(FLoginConfig, oUsuario, oUsuarioDBI);
end;

constructor TSessoesFrame.Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
  pSessaoEventos: ISessaoEventos; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  Inherited Create(AOwner);
  FAppInfo := pAppInfo;
  FSessaoEventos := pSessaoEventos;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FLoginConfig := pLoginConfig;

  PrepSessaoCriadorList;
end;

procedure TSessoesFrame.ExecuteAutoLogin;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

end;

procedure TSessoesFrame.PrepSessaoCriadorList;
begin
  FSessaoCriadorList := SessaoCriadorListCreate;
end;

end.

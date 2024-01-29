unit App.UI.Sessoes.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Sis.DB.DBTypes,
  Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  Sis.UI.IO.Output, App.Sessao.Eventos, Sis.UI.Form.Login.Config,
  App.Sessao.Criador.List, App.UI.Sessao.Frame, Sis.Usuario,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u;

type
  TSessoesFrame = class(TFrame)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    SessoesScrollBox: TScrollBox;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
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
    FSessaoFrame: TSessaoFrame;

    procedure SessaoCriadorListPrep;
    procedure SessaoCriadorListPrepActionList;
    procedure SessaoCriadorListPrepToolBar;
  protected
    function ModuloBasFormCreate(pTipoModuloSistema: TTipoModuloSistema)
      : TModuloBasForm; virtual; abstract;
    function SessaoFrameCreate(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm): TSessaoFrame; virtual; abstract;
  public
    { Public declarations }

    procedure CriarActionExecute(Sender: TObject);
    procedure ExecuteAutoLogin;

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      pSessaoEventos: ISessaoEventos; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pProcessLog: IProcessLog;
      pOutput: IOutput); reintroduce;
  end;

implementation

{$R *.dfm}

uses Sis.DB.Factory, App.DB.Utils, Sis.Usuario.DBI,
  Sis.Usuario.Factory, Sis.UI.Form.Login_u, App.Sessao.Factory,
  App.Sessao.Criador, Sis.UI.Actions.Utils_u;

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

  SessaoCriadorListPrep;
  SessaoCriadorListPrepActionList;
  SessaoCriadorListPrepToolBar;
end;

procedure TSessoesFrame.CriarActionExecute(Sender: TObject);
var
  oUsuario: IUsuario;
  oUsuarioDBI: IUsuarioDBI;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  vTipoModuloSistema: TTipoModuloSistema;
  iActionIndex: integer;
  oAction: TAction;
  sNomeTipo: string;
  sNameTipo: string;
  sNameConex: string;
  bResultado: boolean;
  oModuloBasForm: TModuloBasForm;
  iQtdChilds: integer;
begin
  oAction := TAction(Sender);
  iActionIndex := oAction.Index;
  vTipoModuloSistema := TTipoModuloSistema(oAction.Tag);
  sNameTipo := TipoModuloSistemaToNameStr(vTipoModuloSistema);
  sNomeTipo := TipoModuloSistemaToStr(vTipoModuloSistema);

  sNameConex := Format('Abr.%s.DBConn', [sNameTipo]);
  oUsuario := UsuarioCreate();

  DBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    FAppInfo, FSisConfig);
  oDBConnection := DBConnectionCreate(sNameConex, FSisConfig, FDBMS,
    DBConnectionParams, FProcessLog, FOutput);

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario);
  bResultado := LoginPerg(FLoginConfig, vTipoModuloSistema, oUsuario,
    oUsuarioDBI);
  if not bResultado then
    exit;

  iQtdChilds := SessoesScrollBox.ControlCount;

  oModuloBasForm := ModuloBasFormCreate(vTipoModuloSistema);
  oModuloBasForm.Name := 'ModuloBasForm' + iQtdChilds.ToString;
  FSessaoFrame := SessaoFrameCreate(Self, vTipoModuloSistema, oUsuario,
    oModuloBasForm);

  FSessaoFrame.Parent := SessoesScrollBox;
  FSessaoFrame.Top := SessoesScrollBox.ControlCount * FSessaoFrame.Height + 5;
  FSessaoFrame.Name := 'SessaoFrame' + iQtdChilds.ToString;

end;

procedure TSessoesFrame.ExecuteAutoLogin;
var
  iTipoModuloSistema: integer;
  oAction: TAction;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

  iTipoModuloSistema := integer(FLoginConfig.TipoModuloSistema);
  oAction := ActionByTag(ActionList1, iTipoModuloSistema);
  if not Assigned(oAction) then
    exit;

  oAction.Execute;
end;

procedure TSessoesFrame.SessaoCriadorListPrep;
var
  oSessaoCriador: ISessaoCriador;
begin
  FSessaoCriadorList := SessaoCriadorListCreate;

  oSessaoCriador := SessaoCriadorCreate(modsisRetaguarda);
  FSessaoCriadorList.Add(oSessaoCriador);

  oSessaoCriador := SessaoCriadorCreate(modsisPDV);
  FSessaoCriadorList.Add(oSessaoCriador);

  oSessaoCriador := SessaoCriadorCreate(modsisConfiguracoes);
  FSessaoCriadorList.Add(oSessaoCriador);

end;

procedure TSessoesFrame.SessaoCriadorListPrepActionList;
var
  oSessaoCriador: ISessaoCriador;
  I: integer;
  oAction: TAction;
  sNameTipo: string;
begin
  for I := 0 to FSessaoCriadorList.Count - 1 do
  begin
    oSessaoCriador := FSessaoCriadorList[I];

    oAction := TAction.Create(ActionList1);

    sNameTipo := TipoModuloSistemaToNameStr(oSessaoCriador.TipoModuloSistema);

    oAction.Name := Format('Criar%sAction', [sNameTipo]);
    oAction.Caption := TipoModuloSistemaToStr(oSessaoCriador.TipoModuloSistema);
    oAction.Hint := Format('Abrir %s...', [oAction.Caption]);
    oAction.Tag := integer(oSessaoCriador.TipoModuloSistema);
    // oAction.Category := 'Minha Categoria';
    oAction.OnExecute := CriarActionExecute;
    oAction.ActionList := ActionList1;

  end;
end;

procedure TSessoesFrame.SessaoCriadorListPrepToolBar;
var
  NovoBotao: TToolButton;
  oSessaoCriador: ISessaoCriador;
  I: integer;
  lastbtnidx: integer;
  sNameTipo: string;
begin
  for I := 0 to FSessaoCriadorList.Count - 1 do
  begin
    oSessaoCriador := FSessaoCriadorList[I];
    NovoBotao := TToolButton.Create(Self);
    // Definir as propriedades do botão

    sNameTipo := TipoModuloSistemaToNameStr(oSessaoCriador.TipoModuloSistema);
    NovoBotao.Name := Format('Criar%sToolButton', [sNameTipo]);
    NovoBotao.Style := tbsButton; // Definir o estilo do botão
    NovoBotao.Action := ActionList1.Actions[I];

    lastbtnidx := ToolBar1.ButtonCount - 1;
    if lastbtnidx > -1 then
      NovoBotao.Left := ToolBar1.Buttons[lastbtnidx].Left + ToolBar1.Buttons
        [lastbtnidx].Width
    else
      NovoBotao.Left := 0;
    NovoBotao.Parent := ToolBar1;
  end;
end;

end.

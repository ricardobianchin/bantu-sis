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
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.ModuloSistema,
  Sis.Types.Contador, App.Sessao.List, App.Sessao;

type
  TSessoesFrame = class(TFrame, ISessaoList)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    SessoesScrollBox: TScrollBox;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
  private
    { Private declarations }
    FSortCutInicial: TShortCut;
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FSessaoEventos: ISessaoEventos;
    FLoginConfig: ILoginConfig;

    FSessaoCriadorList: ISessaoCriadorList;
    FSessaoFrame: TSessaoFrame;

    FSessaoIndexContador: IContador;

    procedure SessaoCriadorListPrep;
    procedure SessaoCriadorListPrepActionList;
    procedure SessaoCriadorListPrepToolBar;

    function GetSessao(Index: integer): ISessao;
    function GetCount: integer;
  protected
    property SessaoEventos: ISessaoEventos read FSessaoEventos;

    function ModuloBasFormCreate(pModuloSistema: IModuloSistema;
      pSessaoIndex: Cardinal): TModuloBasForm; virtual; abstract;
    function SessaoFrameCreate(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pSessaoIndex: Cardinal): TSessaoFrame;
      virtual; abstract;
  public
    { Public declarations }

    // cria sessao
    procedure CriarActionExecute(Sender: TObject);
    procedure ExecuteAutoLogin;

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      pSessaoEventos: ISessaoEventos; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pProcessLog: IProcessLog;
      pOutput: IOutput); reintroduce;

    function GetSessaoByIndex(pSessaoIndex: Cardinal): ISessao;
    procedure DeleteByIndex(pSessaoIndex: Cardinal);

    property Count: integer read GetCount;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    function ExecutouPeloShortCut(var Key: word; var Shift: TShiftState): boolean;
  end;

implementation

{$R *.dfm}

uses Sis.DB.Factory, App.DB.Utils, Sis.Usuario.DBI, Vcl.Menus,
  Sis.Usuario.Factory, Sis.UI.Form.Login_u, App.Sessao.Factory,
  App.Sessao.Criador, Sis.UI.Actions.Utils_u, Sis.Entities.Factory,
  Sis.Types.Factory;

constructor TSessoesFrame.Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
  pSessaoEventos: ISessaoEventos; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(AOwner);
  FAppInfo := pAppInfo;
  FSessaoEventos := pSessaoEventos;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FLoginConfig := pLoginConfig;
  FSessaoIndexContador := ContadorCreate;

  FSortCutInicial := VK_F3;

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
  iSessaoIndex: Cardinal;
  oModuloSistema: IModuloSistema;
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

  iSessaoIndex := FSessaoIndexContador.GetNext;
  oModuloSistema := Sis.Entities.Factory.ModuloSistemaCreate
    (vTipoModuloSistema);
  oModuloBasForm := ModuloBasFormCreate(oModuloSistema, iSessaoIndex);
  oModuloBasForm.Name := 'ModuloBasForm' + iSessaoIndex.ToString;
  FSessaoFrame := SessaoFrameCreate(Self, vTipoModuloSistema, oUsuario,
    oModuloBasForm, iSessaoIndex);

  FSessaoFrame.Parent := SessoesScrollBox;
  FSessaoFrame.Top := SessoesScrollBox.ControlCount * FSessaoFrame.Height + 5;
  FSessaoFrame.Name := 'SessaoFrame' + iSessaoIndex.ToString;
  oModuloBasForm.Show;
  FSessaoEventos.DoOk;
end;

procedure TSessoesFrame.DeleteByIndex(pSessaoIndex: Cardinal);
var
  oSessaoFrame: TSessaoFrame;
begin
  oSessaoFrame := TSessaoFrame(GetSessaoByIndex(pSessaoIndex));
  oSessaoFrame.Free;
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

function TSessoesFrame.ExecutouPeloShortCut(var Key: word; var Shift: TShiftState): boolean;
var
  MenorShortCut: TShortCut;
  MaiorShortCut: TShortCut;
  oAction: TAction;
  iIndex: integer;
  wShortCut: TShortCut;
begin
  Result := Shift = [];
  if not Result then
    exit;

  MenorShortCut := FSortCutInicial;
  MaiorShortCut := MenorShortCut + Count - 1;
  wShortCut := tshortcut(Key);

  Result := (wShortCut >= MenorShortCut) and (wShortCut >= MaiorShortCut);
  if not Result then
    exit;

  iIndex := wShortCut - MenorShortCut;
  oAction := TAction( ActionList1[iIndex]);
  Key := 0;
  oAction.Execute;
end;

function TSessoesFrame.GetCount: integer;
begin
  Result := SessoesScrollBox.ControlCount;
end;

function TSessoesFrame.GetSessao(Index: integer): ISessao;
begin
  SessoesScrollBox.Controls[Index];
end;

function TSessoesFrame.GetSessaoByIndex(pSessaoIndex: Cardinal): ISessao;
var
  oSessaoFrame: TSessaoFrame;
  oControl: TControl;
  I: integer;
begin
  Result := nil;
  for I := 0 to SessoesScrollBox.ControlCount - 1 do
  begin
    oControl := SessoesScrollBox.Controls[I];
    oSessaoFrame := TSessaoFrame(oControl);
    if oSessaoFrame.Index = pSessaoIndex then
    begin
      Result := oSessaoFrame;
      break;
    end;
  end;
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
  wShortCut: TShortCut;
  sDescr: string;
  sShortCut: string;
begin
  wShortCut := FSortCutInicial;
  for I := 0 to FSessaoCriadorList.Count - 1 do
  begin
    oSessaoCriador := FSessaoCriadorList[I];

    oAction := TAction.Create(ActionList1);

    sNameTipo := TipoModuloSistemaToNameStr(oSessaoCriador.TipoModuloSistema);
    sDescr := TipoModuloSistemaToStr(oSessaoCriador.TipoModuloSistema);;
    sShortCut := ShortCutToText(wShortCut);

    oAction.Name := Format('Criar%sAction', [sNameTipo]);
    oAction.Hint := Format('Abrir %s...', [sDescr]);
    oAction.Tag := integer(oSessaoCriador.TipoModuloSistema);
    oAction.Caption := Format('%s - %s', [sShortCut, sDescr]);

    inc(wShortCut);

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

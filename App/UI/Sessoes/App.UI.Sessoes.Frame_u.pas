unit App.UI.Sessoes.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Sis.DB.DBTypes, Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.UI.IO.Output, App.Sessao.EventosDeSessao, Sis.UI.Form.Login.Config,
  App.Sessao.Criador.List, App.UI.Sessao.Frame, Sis.Usuario,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.ModuloSistema,
  Sis.Types.Contador, App.Sessao.List, App.Sessao, App.Constants,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Data.DB, Vcl.StdCtrls,
  App.UI.Sessoes.BotModulo.Frame_u, Generics.Collections, Sis.Entities.Types,
  Sis.UI.Form.Login.Teste;

type
  TSessoesFrame = class(TFrame, ISessaoList)
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    SessoesScrollBox: TScrollBox;
    ActionList1: TActionList;
    Action1: TAction;
  private
    { Private declarations }
    FPrimeiroShortCut: TShortCut;
    FAppObj: IAppObj;
    FEventosDeSessao: IEventosDeSessao;
    FLoginConfig: ILoginConfig;
    FLoginTeste: ILoginTeste;

    FSessaoCriadorList: ISessaoCriadorList;
    FSessaoFrame: TSessaoFrame;

    FSessaoIndexContador: IContador;

    FBotList: TList<TBotaoModuloFrame>;
    FLogo1NomeArq: string;

    procedure PrepareListaDeCriadoresEBotoes(pTerminaisPreparadosSL: TStrings);
    procedure BotSessaoAlign;
    procedure PrepareListaDeCriadoresEBotoesToolBar;

    function GetSessao(Index: integer): ISessao;
    function GetCount: integer;

    function GetBotByTipoOpcao(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
      : TBotaoModuloFrame;

    function GetBotByTerminalId(pTerminalId: TTerminalId): TBotaoModuloFrame;

  protected
    property EventosDeSessao: IEventosDeSessao read FEventosDeSessao;

    function LoginTesteCreate(pAppObj: IAppObj): ILoginTeste; virtual;

    function ModuloBasFormCreate(pModuloSistema: IModuloSistema;
      pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
      pTerminalId: TTerminalId): TModuloBasForm; virtual; abstract;

    function SessaoFrameCreate(AOwner: TComponent;
      pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pSessaoIndex: TSessaoIndex; pDBMS: IDBMS;
      pOutput: IOutput; pProcessLog: IProcessLog): TSessaoFrame;
      virtual; abstract;
    function GetAppObj: IAppObj;
    property AppObj: IAppObj read GetAppObj;
  public
    { Public declarations }

    // cria sessao

    TerminaisPreparadosSL: TStringList;
    procedure BotSessaoClick(Sender: TObject);
    procedure ExecuteAutoLogin;

    function GetSessaoByIndex(pSessaoIndex: TSessaoIndex): ISessao;
    function GetSessaoVisivelIndex: TSessaoIndex;

    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
    procedure DeleteByIndex(pSessaoIndex: TSessaoIndex);

    property Count: integer read GetCount;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    function ExecutouPeloShortCut(var Key: word;
      var Shift: TShiftState): Boolean;

    procedure PegarEventoSessao(pEventosDeSessao: IEventosDeSessao);
    procedure ExecByName(pName: string);

    procedure ExecByTerminalId(pTerminalId: TTerminalId);

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      { pEventosDeSessao: IEventosDeSessao; } pAppObj: IAppObj); reintroduce;
    destructor Destroy; override;

  end;

implementation

{$R *.dfm}

uses Sis.DB.Factory, App.DB.Utils, Sis.Usuario.DBI, Vcl.Menus,
  Sis.Usuario.Factory, Sis.UI.Form.LoginPerg_u, App.Sessao.Factory,
  App.Sessao.Criador, Sis.UI.Actions.Utils_u, Sis.Entities.Factory,
  Sis.Types.Factory, Sis.UI.ImgDM, Sis.Win.Utils_u, Sis.Terminal,
  App.UI.Sessao.LoginTeste_u;

procedure TSessoesFrame.BotSessaoClick(Sender: TObject);
var
  {
    oBotaoModuloFrame:TBotaoModuloFrame
    vTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    iActionIndex: integer;
  }
  oControl: TControl;
  oBotaoModuloFrame: TBotaoModuloFrame;
  iOpcaoSisIdModulo: TOpcaoSisIdModulo;

  sNomeTipo: string;
  sNameTipo: string;
  sNameConex: string;

  oUsuario: IUsuario;
  oUsuarioDBI: IUsuarioDBI;

  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;

  bResultado: Boolean;
  iSessaoIndex: TSessaoIndex;
  oModuloSistema: IModuloSistema;

  oModuloBasForm: TModuloBasForm;
  iTerminalId: SmallInt;
  oTerminal: ITerminal;
begin
  oControl := TControl(Sender);
  while not(oControl is TBotaoModuloFrame) do
    oControl := oControl.Parent;
  oBotaoModuloFrame := TBotaoModuloFrame(oControl);

  iTerminalId := oBotaoModuloFrame.TerminalId;

  iOpcaoSisIdModulo := oBotaoModuloFrame.OpcaoSisIdModulo;
  sNameTipo := TipoOpcaoSisModuloToName(iOpcaoSisIdModulo);
  sNomeTipo := TipoOpcaoSisModuloToStr(iOpcaoSisIdModulo);
  sNameConex := Format('Abr.%s.DBConn', [sNameTipo]);

  if iTerminalId = 0 then
  begin
    DBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, FAppObj);
  end
  else
  begin
    oTerminal := AppObj.TerminalList.TerminalIdToTerminal(iTerminalId);
    DBConnectionParams.Server := oTerminal.IdentStr;
    DBConnectionParams.Arq := oTerminal.LocalArqDados;
    DBConnectionParams.Database := oTerminal.Database;
  end;

  oDBConnection := DBConnectionCreate(sNameConex, FAppObj.SisConfig,
    DBConnectionParams, FAppObj.ProcessLog, FAppObj.ProcessOutput);

  oUsuario := UsuarioCreate();

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario, FAppObj.SisConfig);

  bResultado := LoginPerg(FLoginConfig, iOpcaoSisIdModulo, oUsuario,
    oUsuarioDBI, true, FLogo1NomeArq, FLoginTeste, iTerminalId);

  if not bResultado then
    exit;

  iSessaoIndex := FSessaoIndexContador.GetNext;
  oModuloSistema := Sis.Entities.Factory.ModuloSistemaCreate(iOpcaoSisIdModulo);

  oModuloBasForm := ModuloBasFormCreate(oModuloSistema, iSessaoIndex, oUsuario,
    FAppObj, oBotaoModuloFrame.TerminalId);

  oModuloBasForm.Name := 'ModuloBasForm' + iSessaoIndex.ToString;
  FSessaoFrame := SessaoFrameCreate(nil { Self } , iOpcaoSisIdModulo, oUsuario,
    oModuloBasForm, iSessaoIndex, FAppObj.DBMS, FAppObj.ProcessOutput,
    FAppObj.ProcessLog);

  FSessaoFrame.Parent := SessoesScrollBox;
  FSessaoFrame.Top := SessoesScrollBox.ControlCount * FSessaoFrame.Height + 5;
  FSessaoFrame.Name := 'SessaoFrame' + iSessaoIndex.ToString;
  oModuloBasForm.Show;
  FEventosDeSessao.DoOk;
end;

procedure TSessoesFrame.BotSessaoAlign;
var
  iQtd: integer;
  iLargBot: integer;
  iLargBots: integer;
  iLargTot: integer;

  iLeft: integer;
  iTop: integer;
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  iQtd := FBotList.Count;

  if iQtd = 0 then
    exit;
  iLargBot := FBotList[0].Width;
  iLargBots := iLargBot * iQtd;
  iLargTot := TopoPanel.Width;
  iLeft := (iLargTot - iLargBots) div 2;
  iTop := 0;
  for oBotaoModuloFrame in FBotList do
  begin
    oBotaoModuloFrame.Top := iTop;
    oBotaoModuloFrame.Left := iLeft;
    inc(iLeft, iLargBot);
  end;

end;

constructor TSessoesFrame.Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
  { pEventosDeSessao: IEventosDeSessao; } pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  TerminaisPreparadosSL := TStringList.Create;
  FBotList := TList<TBotaoModuloFrame>.Create;
  FAppObj := pAppObj;
  FLoginTeste := LoginTesteCreate(FAppObj);

  // FEventosDeSessao := pEventosDeSessao;
  FLoginConfig := pLoginConfig;
  FSessaoIndexContador := ContadorCreate;

  FPrimeiroShortCut := VK_F3;

  // ToolBar1.Images := SisImgDataModule.PrincImageList89;
  ActionList1.Images := SisImgDataModule.PrincImageList89;
  FLogo1NomeArq := FAppObj.AppInfo.PastaImg + 'App\Logo Tela.jpg';
  PrepareListaDeCriadoresEBotoes(TerminaisPreparadosSL);
  BotSessaoAlign;
  // PrepareListaDeCriadoresEBotoesActionList;
  // PrepareListaDeCriadoresEBotoesToolBar;
end;

procedure TSessoesFrame.DeleteByIndex(pSessaoIndex: TSessaoIndex);
var
  oSessaoFrame: TSessaoFrame;
begin
  oSessaoFrame := TSessaoFrame(GetSessaoByIndex(pSessaoIndex));
  oSessaoFrame.Free;
end;

destructor TSessoesFrame.Destroy;
begin
  TerminaisPreparadosSL.Free;
  FBotList.Free;
  inherited;
end;

procedure TSessoesFrame.DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
var
  oSessaoFrame: TSessaoFrame;
  oControl: TControl;
  I: integer;
begin
  {
    diag
  }

  EventosDeSessao.DoAposModuloOcultar;
  {
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
  }
end;

procedure TSessoesFrame.ExecByName(pName: string);
var
  eOpcaoSisIdModulo: TOpcaoSisIdModulo;
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  pName := UpperCase(pName);
  eOpcaoSisIdModulo := NameToTipoOpcaoSisModulo(pName);
  oBotaoModuloFrame := GetBotByTipoOpcao(eOpcaoSisIdModulo);
  if oBotaoModuloFrame = nil then
    exit;

  oBotaoModuloFrame.BotaoClick;
end;

procedure TSessoesFrame.ExecByTerminalId(pTerminalId: TTerminalId);
var
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  oBotaoModuloFrame := GetBotByTerminalId(pTerminalId);
  if oBotaoModuloFrame = nil then
    exit;

  oBotaoModuloFrame.BotaoClick;
end;

procedure TSessoesFrame.ExecuteAutoLogin;
var
  oAction: TAction;
  oBot: TBotaoModuloFrame;
begin
  if not FLoginConfig.AbreModulo then
    exit;

  oBot := GetBotByTipoOpcao(FLoginConfig.TipoOpcaoSisModulo);
  if not Assigned(oBot) then
    exit;

  oBot.BotaoClick;
end;

function TSessoesFrame.ExecutouPeloShortCut(var Key: word;
  var Shift: TShiftState): Boolean;
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

  MenorShortCut := FPrimeiroShortCut;
  MaiorShortCut := MenorShortCut + Count - 1;
  wShortCut := TShortCut(Key);

  Result := (wShortCut >= MenorShortCut) and (wShortCut <= MaiorShortCut);
  if not Result then
    exit;

  iIndex := wShortCut - MenorShortCut;
  oAction := TAction(ActionList1[iIndex]);
  Key := 0;
  oAction.Execute;
end;

function TSessoesFrame.GetAppObj: IAppObj;
begin
  Result := FAppObj;
end;

function TSessoesFrame.GetBotByTerminalId(pTerminalId: TTerminalId)
  : TBotaoModuloFrame;
var
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  Result := nil;

  if pTerminalId < 1 then
    exit;

  for oBotaoModuloFrame in FBotList do
  begin
    if oBotaoModuloFrame.TerminalId = pTerminalId then
    begin
      Result := oBotaoModuloFrame;
      break;
    end;
  end;
end;

function TSessoesFrame.GetBotByTipoOpcao(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : TBotaoModuloFrame;
var
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  Result := nil;

  for oBotaoModuloFrame in FBotList do
  begin
    if oBotaoModuloFrame.OpcaoSisIdModulo = pTipoOpcaoSisModulo then
    begin
      Result := oBotaoModuloFrame;
      break;
    end;
  end;
end;

function TSessoesFrame.GetCount: integer;
begin
  Result := SessoesScrollBox.ControlCount;
end;

function TSessoesFrame.GetSessao(Index: integer): ISessao;
begin
  Result := TSessaoFrame(SessoesScrollBox.Controls[Index]);
end;

function TSessoesFrame.GetSessaoByIndex(pSessaoIndex: TSessaoIndex): ISessao;
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

function TSessoesFrame.GetSessaoVisivelIndex: TSessaoIndex;
var
  oSessaoFrame: TSessaoFrame;
  oControl: TControl;
  I: integer;
begin
  Result := SESSAO_INDEX_INVALIDO;
  for I := 0 to SessoesScrollBox.ControlCount - 1 do
  begin
    oControl := SessoesScrollBox.Controls[I];
    oSessaoFrame := TSessaoFrame(oControl);

    if oSessaoFrame.ModuloBasForm.Visible then
    begin
      Result := oSessaoFrame.Index;
      break;
    end;
  end;
end;

function TSessoesFrame.LoginTesteCreate(pAppObj: IAppObj): ILoginTeste;
begin
  Result := TLoginTeste.Create(pAppObj);
end;

procedure TSessoesFrame.PegarEventoSessao(pEventosDeSessao: IEventosDeSessao);
begin
  FEventosDeSessao := pEventosDeSessao;
end;

procedure TSessoesFrame.PrepareListaDeCriadoresEBotoes(pTerminaisPreparadosSL
  : TStrings);
var
  oSessaoCriador: ISessaoCriador;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  sSql, sN, sI, sTit2: string;
  vShortCut: TShortCut;
  oBotaoModuloFrame: TBotaoModuloFrame;
  oTerminal: ITerminal;
  I: integer;
begin
  pTerminaisPreparadosSL.Clear;
  vShortCut := TextToShortCut('F3');

  FSessaoCriadorList := SessaoCriadorListCreate;

  oSessaoCriador := SessaoCriadorCreate(opmoduRetaguarda);
  FSessaoCriadorList.Add(oSessaoCriador);
  oSessaoCriador.TerminalId := 0;
  oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' Administra��o';
  // ' Retaguarda';

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);

  oBotaoModuloFrame.ImageIndex := 0;
  oBotaoModuloFrame.ImageIndexMouseDown := oBotaoModuloFrame.ImageIndex + 3;

  oBotaoModuloFrame.TerminalId := 0;
  oBotaoModuloFrame.OpcaoSisIdModulo := TOpcaoSisIdModulo.opmoduRetaguarda;
  oBotaoModuloFrame.Tit := oSessaoCriador.Titulo;
  oBotaoModuloFrame.Tit2 := '';
  oBotaoModuloFrame.OnBotaoClick := BotSessaoClick;
  oBotaoModuloFrame.ShortCut := vShortCut;
  inc(vShortCut);

  oSessaoCriador := SessaoCriadorCreate(opmoduConfiguracoes);
  FSessaoCriadorList.Add(oSessaoCriador);
  oSessaoCriador.TerminalId := 0;
  oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' Configura��es';

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);

  oBotaoModuloFrame.ImageIndex := 1;
  oBotaoModuloFrame.ImageIndexMouseDown := oBotaoModuloFrame.ImageIndex + 3;

  oBotaoModuloFrame.TerminalId := 0;
  oBotaoModuloFrame.OpcaoSisIdModulo := TOpcaoSisIdModulo.opmoduConfiguracoes;
  oBotaoModuloFrame.Tit := oSessaoCriador.Titulo;
  oBotaoModuloFrame.Tit2 := '';
  oBotaoModuloFrame.OnBotaoClick := BotSessaoClick;
  oBotaoModuloFrame.ShortCut := vShortCut;
  inc(vShortCut);

  for I := 0 to FAppObj.TerminalList.Count - 1 do
  begin
    oTerminal := FAppObj.TerminalList[I];

    oSessaoCriador := SessaoCriadorCreate(opmoduPDV);
    FSessaoCriadorList.Add(oSessaoCriador);
    oSessaoCriador.TerminalId := oTerminal.TerminalId;
    oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' PDV ' +
      oSessaoCriador.TerminalId.ToString;
    oSessaoCriador.Apelido := oTerminal.Apelido;
    oSessaoCriador.NFSerie := oTerminal.NFSerie;
    oSessaoCriador.SempreOffline := oTerminal.SempreOffline;

    oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
    oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
    FBotList.Add(oBotaoModuloFrame);

    oBotaoModuloFrame.ImageIndex := 2;
    oBotaoModuloFrame.ImageIndexMouseDown := oBotaoModuloFrame.ImageIndex + 3;

    oBotaoModuloFrame.OpcaoSisIdModulo := TOpcaoSisIdModulo.opmoduPDV;
    oBotaoModuloFrame.Tit := oSessaoCriador.Titulo;

    sTit2 := Trim(oSessaoCriador.Apelido);
    if oSessaoCriador.NFSerie > 0 then
    begin
      if sTit2 <> '' then
        sTit2 := sTit2 + ' ';
      sTit2 := sTit2 + 'NFe:' + oSessaoCriador.NFSerie.ToString;
    end;

    if oSessaoCriador.SempreOffline then
    begin
      if sTit2 <> '' then
        sTit2 := sTit2 + ' ';
      sTit2 := sTit2 + 'Sem WEB';
    end;

    oBotaoModuloFrame.Tit2 := sTit2;
    oBotaoModuloFrame.OnBotaoClick := BotSessaoClick;
    oBotaoModuloFrame.TerminalId := oTerminal.TerminalId;
    pTerminaisPreparadosSL.Add('PDV ' + oTerminal.TerminalId.ToString);
    oBotaoModuloFrame.ShortCut := vShortCut;

    inc(vShortCut);
  end;
end;

procedure TSessoesFrame.PrepareListaDeCriadoresEBotoesToolBar;
var
  NovoBotao: TToolButton;
  oSessaoCriador: ISessaoCriador;
  I: integer;
  lastbtnidx: integer;
  sNameTipo: string;
begin
  // for I := 0 to FSessaoCriadorList.Count - 1 do
  // begin
  // oSessaoCriador := FSessaoCriadorList[I];
  // NovoBotao := TToolButton.Create(Self);
  // // Definir as propriedades do bot�o
  //
  // sNameTipo := TipoOpcaoSisModuloToName(oSessaoCriador.TipoOpcaoSisModulo);
  // NovoBotao.Name := Format('Criar%sToolButton', [sNameTipo]);
  // NovoBotao.Style := tbsButton; // Definir o estilo do bot�o
  // NovoBotao.Action := ActionList1.Actions[I];
  //
  // lastbtnidx := ToolBar1.ButtonCount - 1;
  // if lastbtnidx > -1 then
  // NovoBotao.Left := ToolBar1.Buttons[lastbtnidx].Left + ToolBar1.Buttons
  // [lastbtnidx].Width
  // else
  // NovoBotao.Left := 0;
  // NovoBotao.Parent := ToolBar1;
  // end;
  // ToolBar1.AutoSize := True;
  // ToolBar1.AutoSize := False;
  // ControlAlignToCenter(ToolBar1);
end;

end.

unit App.UI.Sessoes.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin,
  Sis.DB.DBTypes, Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.UI.IO.Output, App.Sessao.Eventos, Sis.UI.Form.Login.Config,
  App.Sessao.Criador.List, App.UI.Sessao.Frame, Sis.Usuario,
  Sis.ModuloSistema.Types, App.UI.Form.Bas.Modulo_u, Sis.ModuloSistema,
  Sis.Types.Contador, App.Sessao.List, App.Sessao, App.Constants,
  Sis.UI.Controls.Utils, Sis.Sis.Constants, Data.DB, Vcl.StdCtrls,
  App.UI.Sessoes.BotModulo.Frame_u, Generics.Collections;

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
    FSessaoEventos: ISessaoEventos;
    FLoginConfig: ILoginConfig;

    FSessaoCriadorList: ISessaoCriadorList;
    FSessaoFrame: TSessaoFrame;

    FSessaoIndexContador: IContador;

    FBotList: TList<TBotaoModuloFrame>;

    procedure SessaoCriadorListPrep;
    procedure BotSessaoAlign;
    procedure SessaoCriadorListPrepActionList;
    procedure SessaoCriadorListPrepToolBar;

    function GetSessao(Index: integer): ISessao;
    function GetCount: integer;

  protected
    property SessaoEventos: ISessaoEventos read FSessaoEventos;

    function ModuloBasFormCreate(pModuloSistema: IModuloSistema;
      pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj)
      : TModuloBasForm; virtual; abstract;

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
    procedure CriarActionExecute(Sender: TObject);
    procedure BotSessaoClick(Sender: TObject);
    procedure ExecuteAutoLogin;

    function GetSessaoByIndex(pSessaoIndex: TSessaoIndex): ISessao;
    function GetSessaoVisivelIndex: TSessaoIndex;

    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
    procedure DeleteByIndex(pSessaoIndex: TSessaoIndex);

    property Count: integer read GetCount;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    function ExecutouPeloShortCut(var Key: word;
      var Shift: TShiftState): boolean;

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      pSessaoEventos: ISessaoEventos; pAppObj: IAppObj); reintroduce;
    destructor Destroy; override;

  end;

implementation

{$R *.dfm}

uses Sis.DB.Factory, App.DB.Utils, Sis.Usuario.DBI, Vcl.Menus,
  Sis.Usuario.Factory, Sis.UI.Form.LoginPerg_u, App.Sessao.Factory,
  App.Sessao.Criador, Sis.UI.Actions.Utils_u, Sis.Entities.Factory,
  Sis.Types.Factory, Sis.UI.ImgDM, Sis.Win.Utils_u;

procedure TSessoesFrame.BotSessaoClick(Sender: TObject);
var
  oUsuario: IUsuario;
  oUsuarioDBI: IUsuarioDBI;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  vTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  iActionIndex: integer;
  oAction: TAction;
  sNomeTipo: string;
  sNameTipo: string;
  sNameConex: string;
  bResultado: boolean;
  oModuloBasForm: TModuloBasForm;
  iSessaoIndex: TSessaoIndex;
  oModuloSistema: IModuloSistema;
begin
  oAction := TAction(Sender);
  iActionIndex := oAction.Index;
  vTipoOpcaoSisModulo := TOpcaoSisIdModulo(oAction.Tag);
  sNameTipo := TipoOpcaoSisModuloToName(vTipoOpcaoSisModulo);
  sNomeTipo := TipoOpcaoSisModuloToStr(vTipoOpcaoSisModulo);

  sNameConex := Format('Abr.%s.DBConn', [sNameTipo]);
  oUsuario := UsuarioCreate();

  DBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppObj.AppInfo, FAppObj.SisConfig);
  oDBConnection := DBConnectionCreate(sNameConex, FAppObj.SisConfig,
    FAppObj.DBMS, DBConnectionParams, FAppObj.ProcessLog,
    FAppObj.ProcessOutput);

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario);
  bResultado := LoginPerg(FLoginConfig, vTipoOpcaoSisModulo, oUsuario,
    oUsuarioDBI, true);

  if not bResultado then
    exit;

  iSessaoIndex := FSessaoIndexContador.GetNext;
  oModuloSistema := Sis.Entities.Factory.ModuloSistemaCreate
    (vTipoOpcaoSisModulo);

  oModuloBasForm := ModuloBasFormCreate(oModuloSistema, iSessaoIndex,
    oUsuario, FAppObj);
  oModuloBasForm.Name := 'ModuloBasForm' + iSessaoIndex.ToString;
  FSessaoFrame := SessaoFrameCreate(Self, vTipoOpcaoSisModulo, oUsuario,
    oModuloBasForm, iSessaoIndex, FAppObj.DBMS, FAppObj.ProcessOutput,
    FAppObj.ProcessLog);

  FSessaoFrame.Parent := SessoesScrollBox;
  FSessaoFrame.Top := SessoesScrollBox.ControlCount * FSessaoFrame.Height + 5;
  FSessaoFrame.Name := 'SessaoFrame' + iSessaoIndex.ToString;
  oModuloBasForm.Show;
  FSessaoEventos.DoOk;
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
  iLargBots := iLargBot*iQtd;
  iLargTot := TopoPanel.Width;
  iLeft := (iLargTot - iLargBots) div 2;
  iTop := 0;
  for oBotaoModuloFrame in FBotList do
  begin
    oBotaoModuloFrame.Top := iTop;
    oBotaoModuloFrame.Left := iLeft;
    inc(iLeft,iLargBot);
  end;

end;

constructor TSessoesFrame.Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
  pSessaoEventos: ISessaoEventos; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FBotList := TList<TBotaoModuloFrame>.Create;
  FAppObj := pAppObj;
  FSessaoEventos := pSessaoEventos;
  FLoginConfig := pLoginConfig;
  FSessaoIndexContador := ContadorCreate;

  FPrimeiroShortCut := VK_F3;

  // ToolBar1.Images := SisImgDataModule.PrincImageList89;
  ActionList1.Images := SisImgDataModule.PrincImageList89;

  SessaoCriadorListPrep;
  BotSessaoAlign;
  // SessaoCriadorListPrepActionList;
  // SessaoCriadorListPrepToolBar;
end;

procedure TSessoesFrame.CriarActionExecute(Sender: TObject);
var
  oUsuario: IUsuario;
  oUsuarioDBI: IUsuarioDBI;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  vTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  iActionIndex: integer;
  oAction: TAction;
  sNomeTipo: string;
  sNameTipo: string;
  sNameConex: string;
  bResultado: boolean;
  oModuloBasForm: TModuloBasForm;
  iSessaoIndex: TSessaoIndex;
  oModuloSistema: IModuloSistema;
begin
  oAction := TAction(Sender);
  iActionIndex := oAction.Index;
  vTipoOpcaoSisModulo := TOpcaoSisIdModulo(oAction.Tag);
  sNameTipo := TipoOpcaoSisModuloToName(vTipoOpcaoSisModulo);
  sNomeTipo := TipoOpcaoSisModuloToStr(vTipoOpcaoSisModulo);

  sNameConex := Format('Abr.%s.DBConn', [sNameTipo]);
  oUsuario := UsuarioCreate();

  DBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppObj.AppInfo, FAppObj.SisConfig);
  oDBConnection := DBConnectionCreate(sNameConex, FAppObj.SisConfig,
    FAppObj.DBMS, DBConnectionParams, FAppObj.ProcessLog,
    FAppObj.ProcessOutput);

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario);
  bResultado := LoginPerg(FLoginConfig, vTipoOpcaoSisModulo, oUsuario,
    oUsuarioDBI, true);

  if not bResultado then
    exit;

  iSessaoIndex := FSessaoIndexContador.GetNext;
  oModuloSistema := Sis.Entities.Factory.ModuloSistemaCreate
    (vTipoOpcaoSisModulo);

  oModuloBasForm := ModuloBasFormCreate(oModuloSistema, iSessaoIndex,
    oUsuario, FAppObj);
  oModuloBasForm.Name := 'ModuloBasForm' + iSessaoIndex.ToString;
  FSessaoFrame := SessaoFrameCreate(Self, vTipoOpcaoSisModulo, oUsuario,
    oModuloBasForm, iSessaoIndex, FAppObj.DBMS, FAppObj.ProcessOutput,
    FAppObj.ProcessLog);

  FSessaoFrame.Parent := SessoesScrollBox;
  FSessaoFrame.Top := SessoesScrollBox.ControlCount * FSessaoFrame.Height + 5;
  FSessaoFrame.Name := 'SessaoFrame' + iSessaoIndex.ToString;
  oModuloBasForm.Show;
  FSessaoEventos.DoOk;
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

  SessaoEventos.DoAposModuloOcultar;
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

procedure TSessoesFrame.ExecuteAutoLogin;
var
  iTipoOpcaoSisModulo: integer;
  oAction: TAction;
begin
  if not FLoginConfig.PreencheLogin then
    exit;

  iTipoOpcaoSisModulo := integer(FLoginConfig.TipoOpcaoSisModulo);
  oAction := ActionByTag(ActionList1, iTipoOpcaoSisModulo);
  if not Assigned(oAction) then
    exit;

  oAction.Execute;
end;

function TSessoesFrame.ExecutouPeloShortCut(var Key: word;
  var Shift: TShiftState): boolean;
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

procedure TSessoesFrame.SessaoCriadorListPrep;
var
  oSessaoCriador: ISessaoCriador;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  sSql, sN, sI, sCom: string;
  Q: TDataSet;
  vShortCut: TShortCut;
  oBotaoModuloFrame: TBotaoModuloFrame;
begin
  vShortCut := TextToShortCut('F3');

  FSessaoCriadorList := SessaoCriadorListCreate;

  oSessaoCriador := SessaoCriadorCreate(opmoduRetaguarda);
  FSessaoCriadorList.Add(oSessaoCriador);
  oSessaoCriador.TerminalId := 0;
  oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' Retaguarda';
  inc(vShortCut);

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame'+FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);
  oBotaoModuloFrame.ImageIndex := 0;
  oBotaoModuloFrame.BotCaption := oSessaoCriador.Titulo;
  oBotaoModuloFrame.BotComments := '';

//  oBotaoModuloFrame.Color := AppObj.AppInfo.FundoCor;
//  oBotaoModuloFrame.Font.Color := AppObj.AppInfo.FonteCor;


  oSessaoCriador := SessaoCriadorCreate(opmoduConfiguracoes);
  FSessaoCriadorList.Add(oSessaoCriador);
  oSessaoCriador.TerminalId := 0;
  oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' Configurações';
  inc(vShortCut);

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame'+FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);
  oBotaoModuloFrame.ImageIndex := 1;
  oBotaoModuloFrame.BotCaption := oSessaoCriador.Titulo;
  oBotaoModuloFrame.BotComments := '';

  DBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppObj.AppInfo, FAppObj.SisConfig);
  oDBConnection := DBConnectionCreate('App.Sessoes.Conn', FAppObj.SisConfig,
    FAppObj.DBMS, DBConnectionParams, FAppObj.ProcessLog,
    FAppObj.ProcessOutput);

  sN := FAppObj.SisConfig.ServerMachineId.Name;
  sI := FAppObj.SisConfig.ServerMachineId.IP;

  sSql := 'SELECT TERMINAL_ID, APELIDO, NF_SERIE, SEMPRE_OFFLINE'#13#10 +
    'FROM TERMINAL'#13#10 + 'WHERE NOME_NA_REDE=' + sN.QuotedString +
    #13#10'OR ip=' + sI.QuotedString + #13#10'ORDER BY TERMINAL_ID'#13#10;
{$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
{$ENDIF}

  if not oDBConnection.Abrir then
    exit;
  try
    oDBConnection.QueryDataSet(sSql, Q);
    try
      while not Q.Eof do
      begin
        oSessaoCriador := SessaoCriadorCreate(opmoduPDV);
        FSessaoCriadorList.Add(oSessaoCriador);
        oSessaoCriador.TerminalId := Q.Fields[0].AsInteger;
        oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' PDV ' +
          Q.Fields[0].AsInteger.ToString;
        oSessaoCriador.Apelido := Trim(Q.Fields[1].AsString);
        oSessaoCriador.NFSerie := Q.Fields[2].AsInteger;
        oSessaoCriador.SempreOffline := Q.Fields[3].AsBoolean;
        Q.Next;
        inc(vShortCut);

        oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
        oBotaoModuloFrame.Name := 'BotaoModuloFrame'+FBotList.Count.ToString;
        FBotList.Add(oBotaoModuloFrame);
        oBotaoModuloFrame.ImageIndex := 2;
        oBotaoModuloFrame.BotCaption := oSessaoCriador.Titulo;
        sCom := Trim(oSessaoCriador.Apelido);
        if oSessaoCriador.NFSerie > 0 then
        begin
          if sCom <> '' then
            sCom := sCom + ' ';
          sCom := sCom + 'NF:'+oSessaoCriador.NFSerie.ToString;
        end;

        if oSessaoCriador.SempreOffline then
        begin
          if sCom <> '' then
            sCom := sCom + ' ';
          sCom := sCom + 'OffLine';
        end;

        oBotaoModuloFrame.BotComments := sCom;
      end;
    finally
      if Assigned(Q) then
        Q.Free;
    end;
  finally
    oDBConnection.Fechar;
  end;
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
  exit;
  wShortCut := FPrimeiroShortCut;
  for I := 0 to FSessaoCriadorList.Count - 1 do
  begin
    oSessaoCriador := FSessaoCriadorList[I];

    oAction := TAction.Create(ActionList1);

    sNameTipo := TipoOpcaoSisModuloToName(oSessaoCriador.TipoOpcaoSisModulo);
    sDescr := TipoOpcaoSisModuloToStr(oSessaoCriador.TipoOpcaoSisModulo);;
    sShortCut := ShortCutToText(wShortCut);

    oAction.Name := Format('Criar%sAction', [sNameTipo]);
    oAction.Hint := Format('Abrir %s...', [sDescr]);
    oAction.Tag := integer(oSessaoCriador.TipoOpcaoSisModulo);
    oAction.Caption := Format('%s - %s', [sShortCut, sDescr]);
    oAction.ImageIndex := I;
    oAction.ShortCut := wShortCut;

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
  // for I := 0 to FSessaoCriadorList.Count - 1 do
  // begin
  // oSessaoCriador := FSessaoCriadorList[I];
  // NovoBotao := TToolButton.Create(Self);
  // // Definir as propriedades do botão
  //
  // sNameTipo := TipoOpcaoSisModuloToName(oSessaoCriador.TipoOpcaoSisModulo);
  // NovoBotao.Name := Format('Criar%sToolButton', [sNameTipo]);
  // NovoBotao.Style := tbsButton; // Definir o estilo do botão
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

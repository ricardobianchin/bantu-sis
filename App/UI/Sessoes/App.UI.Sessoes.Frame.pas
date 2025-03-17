unit App.UI.Sessoes.Frame;

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
  App.UI.Sessoes.BotModulo.Frame_u, Generics.Collections, Sis.Entities.Types;

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

    FSessaoCriadorList: ISessaoCriadorList;
    FSessaoFrame: TSessaoFrame;

    FSessaoIndexContador: IContador;

    FBotList: TList<TBotaoModuloFrame>;
    FLogo1NomeArq: string;

    procedure SessaoCriadorListPrep;
    procedure BotSessaoAlign;
    procedure SessaoCriadorListPrepToolBar;

    function GetSessao(Index: integer): ISessao;
    function GetCount: integer;

    function GetBotByTipoOpcao(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
      : TBotaoModuloFrame;

  protected
    property EventosDeSessao: IEventosDeSessao read FEventosDeSessao;

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
    function PodeAbrirModulo(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
      pDBConnection: IDBConnection): Boolean; virtual;
  public
    { Public declarations }

    // cria sessao
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

    constructor Create(AOwner: TComponent; pLoginConfig: ILoginConfig;
      pEventosDeSessao: IEventosDeSessao; pAppObj: IAppObj); reintroduce;
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
begin
  oControl := TControl(Sender);
  while not(oControl is TBotaoModuloFrame) do
    oControl := oControl.Parent;
  oBotaoModuloFrame := TBotaoModuloFrame(oControl);

  iOpcaoSisIdModulo := oBotaoModuloFrame.OpcaoSisIdModulo;
  sNameTipo := TipoOpcaoSisModuloToName(iOpcaoSisIdModulo);
  sNomeTipo := TipoOpcaoSisModuloToStr(iOpcaoSisIdModulo);
  sNameConex := Format('Abr.%s.DBConn', [sNameTipo]);

  DBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);
  oDBConnection := DBConnectionCreate(sNameConex, FAppObj.SisConfig,
    DBConnectionParams, FAppObj.ProcessLog, FAppObj.ProcessOutput);

  if not PodeAbrirModulo(iOpcaoSisIdModulo, oDBConnection) then
    exit;

  oUsuario := UsuarioCreate();

  oUsuarioDBI := UsuarioDBICreate(oDBConnection, oUsuario, FAppObj.SisConfig);

  bResultado := LoginPerg(FLoginConfig, iOpcaoSisIdModulo, oUsuario,
    oUsuarioDBI, true, FLogo1NomeArq);

  if not bResultado then
    exit;

  iSessaoIndex := FSessaoIndexContador.GetNext;
  oModuloSistema := Sis.Entities.Factory.ModuloSistemaCreate(iOpcaoSisIdModulo);

  oModuloBasForm := ModuloBasFormCreate(oModuloSistema, iSessaoIndex, oUsuario,
    FAppObj, oBotaoModuloFrame.TerminalId);

  oModuloBasForm.Name := 'ModuloBasForm' + iSessaoIndex.ToString;
  FSessaoFrame := SessaoFrameCreate(nil{Self}, iOpcaoSisIdModulo, oUsuario,
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
  pEventosDeSessao: IEventosDeSessao; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FBotList := TList<TBotaoModuloFrame>.Create;
  FAppObj := pAppObj;
  FEventosDeSessao := pEventosDeSessao;
  FLoginConfig := pLoginConfig;
  FSessaoIndexContador := ContadorCreate;

  FPrimeiroShortCut := VK_F3;

  // ToolBar1.Images := SisImgDataModule.PrincImageList89;
  ActionList1.Images := SisImgDataModule.PrincImageList89;
  FLogo1NomeArq := FAppObj.AppInfo.PastaImg + 'App\Logo Tela.jpg';
  SessaoCriadorListPrep;
  BotSessaoAlign;
  // SessaoCriadorListPrepActionList;
  // SessaoCriadorListPrepToolBar;
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

function TSessoesFrame.PodeAbrirModulo(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
  pDBConnection: IDBConnection): Boolean;
var
  SetExigeLoja: set of TOpcaoSisIdModulo;
  sSql: string;
  sNome: string;
begin
  SetExigeLoja := [TOpcaoSisIdModulo.opmoduRetaguarda,
    TOpcaoSisIdModulo.opmoduPDV];

  Result := not (pOpcaoSisIdModulo in SetExigeLoja);
  if Result then
    exit;

  sSql := //
    'SELECT PES.NOME'#13#10 + #13#10

    + 'FROM LOJA LOJ'#13#10 + #13#10

    + 'LEFT JOIN LOJA_EH_PESSOA LEP ON'#13#10 +
    'LOJ.LOJA_ID = LEP.LOJA_ID'#13#10 + #13#10

    + 'LEFT JOIN PESSOA PES ON'#13#10 + 'LEP.LOJA_ID = PES.LOJA_ID'#13#10 +
    'AND LEP.TERMINAL_ID = PES.TERMINAL_ID'#13#10 +
    'AND LEP.PESSOA_ID = PES.PESSOA_ID'#13#10;

  sNome := pDBConnection.GetValueString(sSql);
  Result := sNome <> '';
  if not Result then
  begin
    Showmessage('Antes de utilizar o Módulo ' + TipoOpcaoSisModuloToStr
      (pOpcaoSisIdModulo) +
      ', é necessário completar os dados da loja no Módulo de Configurações');
  end;
end;

procedure TSessoesFrame.SessaoCriadorListPrep;
var
  oSessaoCriador: ISessaoCriador;
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;
  sSql, sN, sI, sTit2: string;
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

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);
  oBotaoModuloFrame.ImageIndex := 0;
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
  oSessaoCriador.Titulo := ShortCutToText(vShortCut) + ' Configurações';

  oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
  oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
  FBotList.Add(oBotaoModuloFrame);
  oBotaoModuloFrame.ImageIndex := 1;
  oBotaoModuloFrame.TerminalId := 0;
  oBotaoModuloFrame.OpcaoSisIdModulo := TOpcaoSisIdModulo.opmoduConfiguracoes;
  oBotaoModuloFrame.Tit := oSessaoCriador.Titulo;
  oBotaoModuloFrame.Tit2 := '';
  oBotaoModuloFrame.OnBotaoClick := BotSessaoClick;
  oBotaoModuloFrame.ShortCut := vShortCut;
  inc(vShortCut);

  DBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);
  oDBConnection := DBConnectionCreate('App.Sessoes.Conn', FAppObj.SisConfig,
    DBConnectionParams, FAppObj.ProcessLog, FAppObj.ProcessOutput);

  sN := FAppObj.SisConfig.ServerMachineId.Name;
  sI := FAppObj.SisConfig.ServerMachineId.IP;

  sSql := 'SELECT TERMINAL_ID, APELIDO, NF_SERIE, SEMPRE_OFFLINE'#13#10 +
    'FROM TERMINAL'#13#10 + 'WHERE NOME_NA_REDE=' + sN.QuotedString +
    #13#10'OR ip=' + sI.QuotedString + #13#10'ORDER BY TERMINAL_ID'#13#10;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

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

        oBotaoModuloFrame := TBotaoModuloFrame.Create(TopoPanel);
        oBotaoModuloFrame.Name := 'BotaoModuloFrame' + FBotList.Count.ToString;
        FBotList.Add(oBotaoModuloFrame);
        oBotaoModuloFrame.ImageIndex := 2;

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
        oBotaoModuloFrame.TerminalId := Q.Fields[0].AsInteger;
        oBotaoModuloFrame.ShortCut := vShortCut;

        Q.Next;
        inc(vShortCut);
      end;
    finally
      if Assigned(Q) then
        Q.Free;
    end;
  finally
    oDBConnection.Fechar;
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

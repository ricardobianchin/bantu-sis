unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.UI.Sessoes.Frame_u, App.Sessao.EventosDeSessao,
  Sis.UI.Form.Login.Config, App.Constants, App.Sessao, Sis.UI.IO.Files;
const
{$IFDEF DEBUG}
  AUTO_OCULTAR = TRUE;
  //AUTO_OCULTAR = FALSE;
{$ELSE}
  AUTO_OCULTAR = TRUE;
{$ENDIF}


type
  TSessoesPrincBasForm = class(TPrincBasForm)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    HideToolButton_SessoesPrincBasForm: TToolButton;
    OcultarAction_SessoesPrincBasForm: TAction;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OcultarAction_SessoesPrincBasFormExecute(Sender: TObject);
  private
    { Private declarations }
    // FSessaoCriadorList: ISessaoCriadorList;
    FSessoesFrame: TSessoesFrame;
    FEventosDeSessao: IEventosDeSessao;

    FLoginConfig: ILoginConfig;
    procedure SessoesFrameCriar;
    function SessoesFrameGarantirAtalhosDesktop: Boolean;
  protected
    procedure ExeParamsDecida; override;

    procedure AppComandoExecute(var pComando: string); override;
    function SessoesFrameCreate: TSessoesFrame; virtual; abstract;
        procedure DoSegundaInstancia; override;
    property LoginConfig: ILoginConfig read FLoginConfig;

    { procedure DoCancel;
      procedure DoOk;
      procedure DoAposModuloOcultar;
      procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
      procedure DoFecharSessao(pSessaoIndex: TSessaoIndex);
      procedure DoAbrirSessao(pSessaoIndex: TSessaoIndex);
    }

    procedure AjusteControles; override;
  public
    { Public declarations }
    property EventosDeSessao: IEventosDeSessao read FEventosDeSessao;
    constructor Create(AOwner: TComponent); override;
  end;

var
  SessoesPrincBasForm: TSessoesPrincBasForm;

implementation

{$R *.dfm}

uses App.Sessao.Factory, Sis.Usuario.Factory, Sis.Sis.InstanciaAtomica_u,
  System.Generics.Collections, Sis.Entities.Types, Sis.Types.Integers,
  Sis.Win.Utils_u, Sis.Types.TStrings_u, App.UI.Form.Perg_u, Sis.Types.Utils_u;

procedure TSessoesPrincBasForm.AppComandoExecute(var pComando: string);
var
  aPalavras: TArray<string>;
  iTerminalId: TTerminalId;
begin
  inherited;
  if pComando = 'RETAG' then
  begin
    pComando := '';
    FSessoesFrame.ExecByName(pComando);
    exit;
  end;

  if pComando = 'CONFIG' then
  begin
    pComando := '';
    FSessoesFrame.ExecByName(pComando);
    exit;
  end;
  aPalavras := pComando.split([' ']);
  if Length(aPalavras) < 2 then
    exit;
  if aPalavras[0] = 'PDV' then
  begin
    iTerminalId := StrToSmallInt(aPalavras[1]);
    FSessoesFrame.ExecByTerminalId(iTerminalId);
  end;

end;

constructor TSessoesPrincBasForm.Create(AOwner: TComponent);
var
  sLog: string;
begin
  inherited;
  if PrecisaFechar then
    exit;

  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    sLog := 'TSessoesPrincBasForm.Create';
    FLoginConfig := LoginConfigCreate(ProcessLog, ProcessOutput);
    sLog := sLog + ';vai FLoginConfig.Ler';
    FLoginConfig.Ler;
    sLog := sLog + ';FLoginConfig.Ler retornou';

    sLog := sLog + ';vai SessoesFrameCriar';
    SessoesFrameCriar;
    sLog := sLog + ';SessoesFrameCriar retornou';

    sLog := sLog + ';vai SessoesFrameGarantirAtalhosDesktop';
    PrecisaFechar := not SessoesFrameGarantirAtalhosDesktop;
    if PrecisaFechar then
    begin
      sLog := sLog +
        ';SessoesFrameGarantirAtalhosDesktop retonou false. vai abortar o sistema';
      exit;
    end;
    sLog := sLog + ';SessoesFrameGarantirAtalhosDesktop retornou ok';

    sLog := sLog + ';vai EventosDeSessaoCreate';
    FEventosDeSessao := EventosDeSessaoCreate;
    sLog := sLog + ';EventosDeSessaoCreate retornou';

    sLog := sLog + ';vai FEventosDeSessao.Pegar';
    FEventosDeSessao.Pegar(Self, FSessoesFrame);
    sLog := sLog + ';FEventosDeSessao.Pegar retornou';

    sLog := sLog + ';vai FSessoesFrame.PegarEventoSessao';
    FSessoesFrame.PegarEventoSessao(FEventosDeSessao);
    sLog := sLog + ';FSessoesFrame.PegarEventoSessao retornou';

    // FSessaoCriadorList := SessaoCriadorListCreate;
  finally
    ProcessLog.RegistreLog(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

procedure TSessoesPrincBasForm.DoSegundaInstancia;
begin
  inherited;
  if ParamCount = 0 then
  begin
    AppComandoSalve('SHOW');
    exit;
  end;
end;

procedure TSessoesPrincBasForm.ExeParamsDecida;
var
  sParam: string;
  i: integer;
begin
  inherited;
  sParam := '';
  for i := 1 to ParamCount do
  begin
    if sParam <> '' then
      sParam := sParam + ' ';
    sParam := sParam + ParamStr(i);
  end;
  AppComandoSalve(sParam);
end;

procedure TSessoesPrincBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if Shift = [] then
    begin
      Key := 0;
      OcultarAction_SessoesPrincBasForm.Execute;
      //FecharAction_ActBasForm.Execute;
    end;
  end;
  FSessoesFrame.ExecutouPeloShortCut(Key, Shift);
  inherited;
end;

procedure TSessoesPrincBasForm.OcultarAction_SessoesPrincBasFormExecute
  (Sender: TObject);
begin
  inherited;
  Hide;
end;

procedure TSessoesPrincBasForm.AjusteControles;
begin
  inherited;
  DtHCompileLabel.Parent := DtHCompilePanel;
  DtHCompileLabel.Left := 3;
  DtHCompileLabel.Top := 10;
  // StatusLabel.left := 30;

  ProcessOutput.Ativo := false;
end;

function TSessoesPrincBasForm.SessoesFrameGarantirAtalhosDesktop: Boolean;
var
  sl: TStrings;
  i: integer;
  iQtd: integer;
  sPastaDesktop: string;
  SLExistentes: TStringList;
  SLDevemSer: TStringList;
  SLScript: TStringList;
  sExe: string;
  sTermId: string;
  sStartIn: string;
  sPerg: string;
begin
  sl := FSessoesFrame.TerminaisPreparadosSL;
  sPastaDesktop := Sis.Win.Utils_u.GetPublicDesktopPath;

  SLExistentes := TStringList.Create;
  SLDevemSer := TStringList.Create;
  SLScript := TStringList.Create;
  sExe := ParamStr(0);
  sStartIn := GetPastaDoArquivo(sExe);
  try
    repeat
      SLDevemSer.Clear;
      for i := 0 to sl.Count - 1 do
      begin
        SLDevemSer.Add(sl[i] + '.lnk');
      end;
      LeDiretorio(sPastaDesktop, SLExistentes, True, 'PDV*.lnk');
      Sis.Types.TStrings_u.DeleteItensIguais(SLExistentes, SLDevemSer);

      Sis.UI.IO.Files.ApagueArquivos(sPastaDesktop, SLExistentes);

      Result := SLDevemSer.Count = 0;

      if Result then
        break;

      sPerg := 'O Sistema precisará de autorização de Administrador'#13#10 +
        'para criar atalhos no Desktop';

      Result := App.UI.Form.Perg_u.Perg(sPerg, 'Criar atalhos no Desktop',
        TBooleanDefault.boolTrue, '&Aceito', '&Fechar o Sistema');
      if not Result then
        exit;

      for i := 0 to SLDevemSer.Count - 1 do
      begin
        sTermId := ExtractFileNameOnly(SLDevemSer[i]);
        Sis.Win.Utils_u.AddScriptCriaAtalho(SLScript, AppInfo.PastaComandos,
          sPastaDesktop, sTermId, sExe, sTermId, sStartIn);
      end;
      Sis.Win.Utils_u.ExecutePowerShellScript(AppInfo.PastaComandos,
        'Cria Atalho', SLScript);
      //
      // apos login, buscar sessao com mesmo modulo e usuario. se tiver, exibe, senao, cria outro
    until false;
  finally
    SLExistentes.Free;
    SLDevemSer.Free;
    SLScript.Free;
  end;
end;

procedure TSessoesPrincBasForm.SessoesFrameCriar;
var
  iBaseLogo: integer;
begin
  FSessoesFrame := SessoesFrameCreate;
  FSessoesFrame.Parent := Self;

  iBaseLogo := Logo1Image.Top + Logo1Image.Height + 1;

  FSessoesFrame.Left := 5;
  FSessoesFrame.Top := iBaseLogo;
  FSessoesFrame.Height := BasePanel.Top - iBaseLogo;
  FSessoesFrame.Anchors := [akLeft, akTop, akBottom];
  // FSessoesFrame.

end;

procedure TSessoesPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  if PrecisaFechar then
    exit;
  inherited;
  if AUTO_OCULTAR then
    Hide;
  FSessoesFrame.ExecuteAutoLogin;
end;

end.

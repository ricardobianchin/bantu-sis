unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.UI.Sessoes.Frame_u, App.Sessao.EventosDeSessao,
  Sis.UI.Form.Login.Config, App.Constants, App.Sessao, Sis.UI.IO.Files;

type
  TSessoesPrincBasForm = class(TPrincBasForm)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    // FSessaoCriadorList: ISessaoCriadorList;
    FSessoesFrame: TSessoesFrame;
    FEventosDeSessao: IEventosDeSessao;

    FLoginConfig: ILoginConfig;
    procedure SessoesFrameCriar;
    procedure SessoesFrameGarantirAtalhosDesktop;
    procedure CrieAtalhoPDVDesktop(pTermId, pPastaDesktop: string);
  protected
    procedure DoSegundaInstancia; override;
    procedure AppComandoExecute(var pComando: string); override;
    function SessoesFrameCreate: TSessoesFrame; virtual; abstract;
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
  Sis.Win.Utils_u, Sis.Types.TStrings_u;

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
begin
  inherited;
  if PrecisaFechar then
    exit;

  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    FLoginConfig := LoginConfigCreate(ProcessLog, ProcessOutput);
    FLoginConfig.Ler;

    SessoesFrameCriar;

    SessoesFrameGarantirAtalhosDesktop;

    FEventosDeSessao := EventosDeSessaoCreate;
    FEventosDeSessao.Pegar(Self, FSessoesFrame);
    FSessoesFrame.PegarEventoSessao(FEventosDeSessao);

    // FSessaoCriadorList := SessaoCriadorListCreate;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TSessoesPrincBasForm.CrieAtalhoPDVDesktop(pTermId,
  pPastaDesktop: string);
var
  sExe: string;
begin
  sExe := ParamStr(0);
  Sis.Win.Utils_u.CrieAtalho(AppInfo.PastaComandos, pPastaDesktop,
    pTermId, sExe, pTermId, GetPastaDoArquivo(ParamStr(0)));
end;

procedure TSessoesPrincBasForm.DoSegundaInstancia;
var
  sParam: string;
  i: integer;
begin
  inherited;
  if ParamCount = 0 then
  begin
    AppComandoSalve('show');
    exit;
  end;

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
  inherited;
  FSessoesFrame.ExecutouPeloShortCut(Key, Shift);
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

procedure TSessoesPrincBasForm.SessoesFrameGarantirAtalhosDesktop;
var
  sl: TStrings;
  i: integer;
  iQtd: integer;
  sCaminhoDesktop: string;
  SLExistentes: TStringList;
  SLDevemSer: TStringList;
begin
  sl := FSessoesFrame.TerminaisPreparadosSL;
  sCaminhoDesktop := Sis.Win.Utils_u.GetPublicDesktopPath;

  SLExistentes := TStringList.Create;
  SLDevemSer := TStringList.Create;
  try
    for i := 0 to sl.Count - 1 do
    begin
      SLDevemSer.Add(sl[i] + '.lnk');
    end;
    LeDiretorio(sCaminhoDesktop, SLExistentes, false, 'PDV*.lnk');
    Sis.Types.TStrings_u.DeleteItensIguais(SLExistentes, SLDevemSer);

    Sis.UI.IO.Files.ApagueArquivos(sCaminhoDesktop, SLExistentes);

    for i := 0 to sl.Count - 1 do
      CrieAtalhoPDVDesktop( nao pode usar sl, tem que pegar sldevemser sl[i], sCaminhoDesktop);

      apos login, buscar sessao com mesmo modulo e usuario. se tiver, exibe, senao, cria outro

  finally
    SLExistentes.Free;
    SLDevemSer.Free;
  end;

  // iQtd := sl.Count;
  // if iQtd = 0 then
  // exit;
  // for i := 0 to sl.Count - 1 do
  // begin
  //
  // end;
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
  FSessoesFrame.ExecuteAutoLogin;
end;

end.

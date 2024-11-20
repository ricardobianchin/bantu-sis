unit App.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.UI.Constants, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Sis.UI.Frame.Status.Thread_u,
  System.Generics.Collections, App.Ger.GerForm.DBI, App.AppObj;

type
  TExecuteTeste = (etNenhum, etUm, etTodos);

const
{$IFDEF DEBUG}
  //FRAME_EXECUTAR: TExecuteTeste = etNenhum;
  FRAME_EXECUTAR: TExecuteTeste = etUm;
  NSECS_PAUSA = 1;
{$ELSE}
  FRAME_EXECUTAR: TExecuteTeste = etTodos;
  NSECS_PAUSA = 15;
{$ENDIF}

type
  TGerAppForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleToolBar: TToolBar;
    TitActionList: TActionList;
    FecharAction_GerAppForm: TAction;
    BasePanel: TPanel;
    SempreVisivelCheckBox: TCheckBox;
    AutoOpenCheckBox: TCheckBox;
    StatusFrameScrollBox: TScrollBox;
    ExecuteTimer: TTimer;

    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FecharAction_GerAppFormExecute(Sender: TObject);
    procedure SempreVisivelCheckBoxClick(Sender: TObject);
    procedure AutoOpenCheckBoxClick(Sender: TObject);
    procedure ExecuteTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FSecPausa: integer;
    FFramesList: TList<TThreadStatusFrame>;
    FAutoOpen: Boolean;
    FSempreVisivel: Boolean;
    FProcessaControles: Boolean;
    FGerFormDBI: IGerFormDBI;
    FAppObj: IAppObj;
    FPodeExecutar: Boolean;

    procedure CarregConfig;

    procedure SetSempreVisivel(Value: Boolean);
    procedure SetAutoOpen(Value: Boolean);

    procedure GerFormDBIInicialize;

  protected
    procedure AjusteControles; override;
    property FramesList: TList<TThreadStatusFrame> read FFramesList;
    property AppObj: IAppObj read FAppObj;
    procedure ExecuteForAllFrames(const Proc: TThreadStatusFrameProcedure);

  public
    { Public declarations }
    property PodeExecutar: Boolean read FPodeExecutar write FPodeExecutar;

    property AutoOpen: Boolean read FAutoOpen write SetAutoOpen;
    property SempreVisivel: Boolean read FSempreVisivel write SetSempreVisivel;

    constructor Create(AOwner: TComponent; pAppObj: IAppObj); reintroduce;
    destructor Destroy; override;

    procedure Terminate;
    procedure EspereTerminar;
  end;

  // var
  // GerAppForm: TGerAppForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.DateUtils, Sis.Types.Bool_u, Sis.DB.DBTypes,
  App.DB.Utils, Sis.Sis.Constants, Sis.DB.DBConfig.Factory_u,
  Sis.DB.DBConfigDBI, Sis.DB.Factory, App.Ger.Factory, Sis.UI.Controls.Utils;

procedure TGerAppForm.AjusteControles;
begin
  inherited;
end;

procedure TGerAppForm.AutoOpenCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  AutoOpen := AutoOpenCheckBox.Checked;
end;

procedure TGerAppForm.CarregConfig;
begin
  FGerFormDBI.PegarConfigs(FSempreVisivel, FAutoOpen);

  if FSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;

  SempreVisivelCheckBox.Checked := FSempreVisivel;
  AutoOpenCheckBox.Checked := FAutoOpen;
end;

procedure TGerAppForm.SempreVisivelCheckBoxClick(Sender: TObject);
begin
  inherited;
  if not FProcessaControles then
    exit;

  SempreVisivel := SempreVisivelCheckBox.Checked;
end;

constructor TGerAppForm.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FSecPausa := 0;
  FProcessaControles := False;
  FFramesList := TList<TThreadStatusFrame>.Create;
  FAppObj := pAppObj;

  GerFormDBIInicialize;

  CarregConfig;
  FProcessaControles := True;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  TitleToolBar.Color := COR_AZUL_TITLEBAR;

  FPodeExecutar := True;
  ClearStyleElements(Self);
end;

destructor TGerAppForm.Destroy;
begin
  FFramesList.Free;
  inherited;
end;

procedure TGerAppForm.EspereTerminar;
var
  oFrame: TThreadStatusFrame;
  bTerminou: Boolean;
begin
  bTerminou := False;
  repeat
    for oFrame in FFramesList do
    begin
      Sleep(200);
      bTerminou := oFrame.PodeFechar;
      if not bTerminou then
        break;

    end;
    if bTerminou then
      break;
    Application.ProcessMessages;
    Sleep(1000);
  until (False);

  // ExecuteForAllFrames(
  // procedure(pFrame: TThreadStatusFrame)
  // begin
  // pFrame.PodeFechar;
  // end);
end;

procedure TGerAppForm.ExecuteForAllFrames(const Proc
  : TThreadStatusFrameProcedure);
var
  oFrame: TThreadStatusFrame;
begin
  // Percorre a lista de frames e executa o procedimento para cada frame
  for oFrame in FFramesList do
  begin
    Proc(oFrame);
  end;
end;

procedure TGerAppForm.ExecuteTimerTimer(Sender: TObject);
begin
  inherited;
  if not PodeExecutar then
    exit;
  inc(FSecPausa);
  if FSecPausa = NSECS_PAUSA then
  begin
    FSecPausa := 0;
  end
  else
  begin
    exit;
  end;

  case FRAME_EXECUTAR of
    etNenhum: ExecuteTimer.Enabled := False;//exit;
    etUm:
      FFramesList[0].Execute;
  else // etTodos:
    ExecuteForAllFrames(
      procedure(pFrame: TThreadStatusFrame)
      begin
        pFrame.Execute;
      end);
  end;
end;

procedure TGerAppForm.Terminate;
begin
  FPodeExecutar := False;
  ExecuteForAllFrames(
    procedure(pFrame: TThreadStatusFrame)
    begin
      pFrame.Terminate;
    end);

end;

procedure TGerAppForm.FecharAction_GerAppFormExecute(Sender: TObject);
begin
  // inherited;
  if not FPodeExecutar then
    exit;

  Hide;
end;

procedure TGerAppForm.GerFormDBIInicialize;
var
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  oDBConfigDBI: IDBConfigDBI;
begin
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  oDBConnection := DBConnectionCreate('App.GerForm.CarregConfig.conn',
    FAppObj.SisConfig, rDBConnectionParams, nil, nil);

  oDBConfigDBI := DBConfigDBICreate(oDBConnection);
  FGerFormDBI := GerFormDBICreate(oDBConnection, oDBConfigDBI);
end;

procedure TGerAppForm.SetAutoOpen(Value: Boolean);
begin
  FAutoOpen := Value;
  FGerFormDBI.AutoOpenGravar(FAutoOpen);
end;

procedure TGerAppForm.SetSempreVisivel(Value: Boolean);
begin
  FSempreVisivel := Value;

  if FSempreVisivel then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  FGerFormDBI.SempreVisivelGravar(FSempreVisivel);
end;

procedure TGerAppForm.TitleBarPanelMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  inherited;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.

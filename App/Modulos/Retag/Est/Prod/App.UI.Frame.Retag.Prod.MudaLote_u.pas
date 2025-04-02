unit App.UI.Frame.Retag.Prod.MudaLote_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Sis.UI.Controls.ComboBoxManager,
  Data.DB, Sis.DB.DBTypes, App.AppObj, Sis.Types;

type
  TMudaLoteFrame = class(TBasFrame)
    TitPanel: TPanel;
    TitLabel: TLabel;
    SubTituloLabel: TLabel;

    ToolBar1: TToolBar;
    ToolButton1: TToolButton;

    FabrLabel: TLabel;
    TipoLabel: TLabel;

    FabrComboBox: TComboBox;
    TipoComboBox: TComboBox;
    ToolBar2: TToolBar;
    ExecutarToolButton: TToolButton;
    ProgressBar1: TProgressBar;
    StatusLabel: TLabel;

    procedure ToolButton1Click(Sender: TObject);
    procedure ExecutarToolButtonClick(Sender: TObject);
    procedure FabrComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FFabrComboBoxManager: IComboBoxManager;
    FTipoComboBoxManager: IComboBoxManager;
    FJaAtualizou: Boolean;
    FDataSetOrigem: TDataSet;
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
    FProdIds: array of integer;
    FQtdRecords: integer;
    FOnExecute: TNotifyEvent;

    FUsuarioId: integer;
    FDoUpdateAndCreateLogsServer_Andamento: TProcedureIntegerOfObject;

    function GetOnExecute: TNotifyEvent;
    procedure SetOnExecute(const Value: TNotifyEvent);

    procedure PreenchaProdIds;
    procedure DoUpdateAndCreateLogsServer;
    procedure DoUpdateAndCreateLogsServer_Iniciar;
    procedure DoUpdateAndCreateLogsServer_Andamento_Exibindo(pPasso: integer);
    procedure DoUpdateAndCreateLogsServer_Andamento_Mudo(pPasso: integer);
    procedure DoUpdateAndCreateLogsServer_Terminar;

    function PodeExecutar: Boolean;
  public
    { Public declarations }
    property FabrComboBoxManager: IComboBoxManager read FFabrComboBoxManager;
    property TipoComboBoxManager: IComboBoxManager read FTipoComboBoxManager;
    property OnExecute: TNotifyEvent read GetOnExecute write SetOnExecute;

    procedure Atualizar(pDBConnection: IDBConnection);

    constructor Create(AOwner: TComponent; pDataSetOrigem: TDataSet;
      pDBConnectionParams: TDBConnectionParams; pAppObj: IAppObj;
      pOnExecute: TNotifyEvent; pUsuarioId: integer); reintroduce;
  end;

  // var
  // MudaLoteFrame: TMudaLoteFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Controls.Factory, Sis.DB.Factory;

{ TMudaLoteFrame }

procedure TMudaLoteFrame.Atualizar(pDBConnection: IDBConnection);
var
  sSql: string;
  q: TDataSet;
  iTipoReg: integer;
  iId: integer;
  sDescr: string;
  oComboBoxManager: IComboBoxManager;
  iUltimoFabrId, iUltimoTipoId: integer;
begin
  if not FJaAtualizou then
  begin
    iUltimoFabrId := 0;
    iUltimoTipoId := 0;
    FJaAtualizou := True;
  end
  else
  begin
    iUltimoFabrId := FabrComboBoxManager.Id;
    iUltimoTipoId := TipoComboBoxManager.Id;
  end;

  sSql := 'SELECT TIPO_REG, ID, DESCR'#13#10 //
    + 'FROM ('#13#10 //
    + '    SELECT 1 AS TIPO_REG, FAB.FABR_ID ID, FAB.NOME DESCR'#13#10 //
    + '    FROM FABR FAB'#13#10 //
    + '    UNION'#13#10 //
    + '    SELECT 2 AS TIPO_REG, TIP.PROD_TIPO_ID ID, TIP.DESCR'#13#10 //
    + '    FROM PROD_TIPO TIP'#13#10 //
    + ') AS TEMP'#13#10 //
    + 'WHERE ID > 0'#13#10 //
    + 'ORDER BY TIPO_REG, DESCR;'#13#10 //
    ;

  FFabrComboBoxManager.Clear;
  FTipoComboBoxManager.Clear;

  FFabrComboBoxManager.PegarId(0, '<SEM MUDANÇA>');
  FTipoComboBoxManager.PegarId(0, '<SEM MUDANÇA>');

  pDBConnection.QueryDataSet(sSql, q);

  if not Assigned(q) then
    exit;

  try
    while not q.eof do
    begin
      iTipoReg := q.fields[0].AsInteger;
      iId := q.fields[1].AsInteger;
      sDescr := q.fields[2].AsString.Trim;

      if iTipoReg = 1 then
        oComboBoxManager := FFabrComboBoxManager
      else
        oComboBoxManager := FTipoComboBoxManager;

      oComboBoxManager.PegarId(iId, sDescr);
      q.next;
    end;
  finally
    q.Free;

    if iUltimoFabrId = 0 then
    begin
      FabrComboBox.ItemIndex := 0;
    end
    else
    begin
      FabrComboBoxManager.Id := iUltimoFabrId;
    end;

    if iUltimoTipoId = 0 then
    begin
      TipoComboBox.ItemIndex := 0;
    end
    else
    begin
      TipoComboBoxManager.Id := iUltimoTipoId;
    end;
  end;
end;

constructor TMudaLoteFrame.Create(AOwner: TComponent; pDataSetOrigem: TDataSet;
  pDBConnectionParams: TDBConnectionParams; pAppObj: IAppObj;
  pOnExecute: TNotifyEvent; pUsuarioId: integer);
begin
  inherited Create(AOwner);
  FOnExecute := pOnExecute;
  FAppObj := pAppObj;

  FUsuarioId := pUsuarioId;

  // Color := RGB(206, 222, 236);
  // TitPanel.Color := RGB(159, 184, 198);
  // ToolBar1.Color := TitPanel.Color;
  FFabrComboBoxManager := ComboBoxManagerCreate(FabrComboBox);
  FTipoComboBoxManager := ComboBoxManagerCreate(TipoComboBox);
  FJaAtualizou := False;
  FDataSetOrigem := pDataSetOrigem;
  FDBConnectionParams := pDBConnectionParams;
  FDBConnection := DBConnectionCreate('Retag.Dataset.Prod.MudaLote.Conn',
    FAppObj.SisConfig, FDBConnectionParams, nil, nil);
end;

procedure TMudaLoteFrame.DoUpdateAndCreateLogsServer;
var
  i: integer;
  sSql: string;
  oDBExec: IDBExec;
begin
  sSql := 'EXECUTE PROCEDURE PROD_PA.MUDA_LOTE_DO(' //
    + ':PROD_ID' //
    + ', ' + FabrComboBoxManager.Id.ToString //
    + ', ' + TipoComboBoxManager.Id.ToString //
    + ', ' + FAppObj.Loja.Id.ToString //
    + ', ' + FUsuarioId.ToString //
    + ', ' + FAppObj.SisConfig.LocalMachineId.IdentId.ToString //
    + ');';

  oDBExec := DBExecCreate('retag.prod.mudalote.exec', FDBConnection, sSql,
    nil, nil);

  if not FDBConnection.Abrir then
    exit;

  oDBExec.Prepare;
  DoUpdateAndCreateLogsServer_Iniciar;

  try
    FDBConnection.StartTransaction;
    try
      for i := 0 to FQtdRecords - 1 do
      begin
        oDBExec.Params[0].AsInteger := FProdIds[i];
        oDBExec.Execute;
        //sleep(2);
        FDoUpdateAndCreateLogsServer_Andamento(i);
      end;
      FDBConnection.Commit;
    except
      begin
        FDBConnection.Rollback;
        raise;
      end;
    end;
  finally
    oDBExec.Unprepare;
    FDBConnection.Fechar;
    DoUpdateAndCreateLogsServer_Terminar;
  end;
end;

procedure TMudaLoteFrame.DoUpdateAndCreateLogsServer_Andamento_Exibindo(
  pPasso: integer);
begin
  if (pPasso div 33) = 0 then
    ProgressBar1.Position := pPasso;
end;

procedure TMudaLoteFrame.DoUpdateAndCreateLogsServer_Andamento_Mudo(
  pPasso: integer);
begin

end;

procedure TMudaLoteFrame.DoUpdateAndCreateLogsServer_Iniciar;
var
  bAndamentoVisivel: Boolean;
begin
  StatusLabel.Font.Color := 128;
  StatusLabel.Caption := 'Executando...';
  ProgressBar1.Left := StatusLabel.Left + StatusLabel.Width + 5;
  StatusLabel.Visible := True;
  bAndamentoVisivel := FQtdRecords > 100;
  ProgressBar1.Visible := bAndamentoVisivel;

  if bAndamentoVisivel then
  begin
    FDoUpdateAndCreateLogsServer_Andamento := DoUpdateAndCreateLogsServer_Andamento_Exibindo;
    ProgressBar1.Max := FQtdRecords;
  end
  else
  begin
    FDoUpdateAndCreateLogsServer_Andamento := DoUpdateAndCreateLogsServer_Andamento_Mudo;
  end;
  Application.ProcessMessages;
end;

procedure TMudaLoteFrame.DoUpdateAndCreateLogsServer_Terminar;
begin
  StatusLabel.Font.Color := clWindowText;
  StatusLabel.Caption := 'Terminado';
  ProgressBar1.Left := StatusLabel.Left + StatusLabel.Width + 5;

  ProgressBar1.Visible := False;
  ProgressBar1.Position := 0;
end;

procedure TMudaLoteFrame.ExecutarToolButtonClick(Sender: TObject);
begin
  inherited;
  ExecutarToolButton.Enabled := False;
  try
    if FDataSetOrigem.isempty then
      exit;

    if not PodeExecutar then
      exit;

    FQtdRecords := FDataSetOrigem.RecordCount;
    SetLength(FProdIds, FQtdRecords);

    PreenchaProdIds;
    DoUpdateAndCreateLogsServer;
  finally
    SetLength(FProdIds, 0);
    if Assigned(FOnExecute) then
      FOnExecute(Self);

    ExecutarToolButton.Enabled := True;
  end;
end;

procedure TMudaLoteFrame.FabrComboBoxChange(Sender: TObject);
begin
  inherited;
  StatusLabel.Visible := False;
  ProgressBar1.Visible := False;
end;

function TMudaLoteFrame.GetOnExecute: TNotifyEvent;
begin
  Result := FOnExecute;
end;

function TMudaLoteFrame.PodeExecutar: Boolean;
begin
  Result := FabrComboBoxManager.Id > 0;
  if Result then
    exit;

  Result := TipoComboBoxManager.Id > 0;
  if Result then
    exit;

  StatusLabel.Font.Color := 128;
  StatusLabel.Caption := 'Nenhuma mudança foi indicada';
  StatusLabel.Visible := True;
end;

procedure TMudaLoteFrame.PreenchaProdIds;
var
  bm: TBookmark;
  i: integer;
begin
  bm := FDataSetOrigem.GetBookmark;
  FDataSetOrigem.DisableControls;
  try
    FDataSetOrigem.First;
    i := 0;
    while not FDataSetOrigem.eof do
    begin
      FProdIds[i] := FDataSetOrigem.fields[0].AsInteger;
      Inc(i);
      FDataSetOrigem.next;
    end;
  finally
    FDataSetOrigem.GotoBookmark(bm);
    FDataSetOrigem.FreeBookmark(bm);
    FDataSetOrigem.EnableControls;
  end;
end;

procedure TMudaLoteFrame.SetOnExecute(const Value: TNotifyEvent);
begin
  FOnExecute := Value
end;

procedure TMudaLoteFrame.ToolButton1Click(Sender: TObject);
begin
  inherited;
  Visible := False;
end;

end.

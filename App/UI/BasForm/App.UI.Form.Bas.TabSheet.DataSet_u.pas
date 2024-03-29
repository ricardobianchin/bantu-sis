unit App.UI.Form.Bas.TabSheet.DataSet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, App.AppInfo, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, Sis.DB.Factory, Vcl.StdCtrls, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed;

type
  TTabSheetDataSetBasForm = class(TTabSheetAppBasForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    AtuAction_DatasetTabSheet: TAction;
    InsAction_DatasetTabSheet: TAction;
    AltAction_DatasetTabSheet: TAction;
    ExclAction_DatasetTabSheet: TAction;
    FiltroAtualizarTimer: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure FiltroAtualizarTimerTimer(Sender: TObject);
    procedure FiltroEdit_DataSetTabSheetChange(Sender: TObject);

    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);

    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FFDMemTable: TFDMemTable;
    FEntEd: IEntEd;
    // FFDDataSetManager: IFDDataSetManager;

    FFiltroEditAutomatico: boolean;

    // oDBConnection: IDBConnection;
    FDBConnectionParams: TDBConnectionParams;
    function GetState: TDataSetState;
    procedure SetState(const Value: TDataSetState);

  protected
    AtuExecutando, InsExecutando, AltExecutando, ExclExecutando: boolean;

    function GetFDMemTable: TFDMemTable;
    property FDMemTable: TFDMemTable read GetFDMemTable;

    function GetFDDataSetManager: IFDDataSetManager;
    property FDDataSetManager: IFDDataSetManager read GetFDDataSetManager;

    procedure DefCampos; virtual;
    function GetNomeArqTabView: string; virtual; abstract;
    // nome,tipo,tamanho,visivel,mask,caption,Largura,Alinhamento Horizontal

    function GetCDS1: TFDMemTable;
    property CDS1: TFDMemTable read GetCDS1;
    property State: TDataSetState read GetState write SetState;

    function GetTitulo: string; override;

    procedure DoAtualizar(Sender: TObject); virtual; abstract;
    function DoInserir: boolean; virtual; abstract;
    procedure DoAlterar; virtual; abstract;
    property EntEd: IEntEd read FEntEd;
    procedure LeRegEInsere(q: TDataSet); virtual; abstract;
    procedure RecordToEnt; virtual;
    procedure FDMemTable1AfterScroll(DataSet: TDataSet); virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS;
      pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
      pEntEd: IEntEd); reintroduce;
  end;
  // TTabSheetDataSetBasFormClass = class of TTabSheetDataSetBasForm;

var
  TabSheetDataSetBasForm: TTabSheetDataSetBasForm;

implementation

{$R *.dfm}
{ TTabSheetDataSetBasForm }

procedure TTabSheetDataSetBasForm.AltAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  Resultado: boolean;
begin
  inherited;
  if FDMemTable.IsEmpty then
  begin
    OutputNotify.exibir('N�o h� registros a alterar');
    exit;
  end;

  if AltExecutando then
    exit;

  AltExecutando := true;
  State := dsEdit;
  try
    RecordToEnt;
    DoAlterar;
  finally
    State := dsBrowse;
    DBGrid1.SetFocus;
    AltExecutando := False;
  end;
end;

procedure TTabSheetDataSetBasForm.AtuAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  inherited;
  if State <> dsBrowse then
    exit;

  if AtuExecutando then
    exit;
  try
    AtuExecutando := true;

    DoAtualizar(Self);
  finally
    DBGrid1.SetFocus;
    AtuExecutando := False;
  end;
end;

constructor TTabSheetDataSetBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd);
begin
  FEntEd := pEntEd;
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS,
    pOutput, pProcessLog, pOutputNotify);
  State := dsBrowse;
  FFiltroEditAutomatico := False;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  FFDMemTable.AfterScroll := FDMemTable1AfterScroll;
  DefCampos;
end;

procedure TTabSheetDataSetBasForm.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  AltAction_DatasetTabSheet.Execute;
end;

procedure TTabSheetDataSetBasForm.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CharInSet(Key, [#32, #13]) then
  begin
    Key := #0;
    AltAction_DatasetTabSheet.Execute;
  end;
end;

procedure TTabSheetDataSetBasForm.DefCampos;
var
  DefsSL: TStringList;
  sNomeArq: string;
  sLinhaAtual: string;
  I: integer;
  Params: TArray<string>;
  oFDDataSetManager: IFDDataSetManager;
begin
  DefsSL := TStringList.Create;
  try
    sNomeArq := GetNomeArqTabView;
    DefsSL.LoadFromFile(sNomeArq);
    oFDDataSetManager := FDDataSetManagerCreate(FFDMemTable, DBGrid1);
    oFDDataSetManager.DefinaCampos(DefsSL);
  finally
    DefsSL.Free;
  end;
end;

procedure TTabSheetDataSetBasForm.FDMemTable1AfterScroll(DataSet: TDataSet);
begin

end;

procedure TTabSheetDataSetBasForm.FiltroAtualizarTimerTimer(Sender: TObject);
begin
  inherited;
  FiltroAtualizarTimer.Enabled := False;
  AtuAction_DatasetTabSheet.Execute;
end;

procedure TTabSheetDataSetBasForm.FiltroEdit_DataSetTabSheetChange
  (Sender: TObject);
begin
  inherited;
  if not FFiltroEditAutomatico then
    exit;

  FiltroAtualizarTimer.Enabled := False;
  FiltroAtualizarTimer.Enabled := true;
end;

procedure TTabSheetDataSetBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  AtuExecutando := False;
  InsExecutando := False;
  AltExecutando := False;
  ExclExecutando := False;

end;

function TTabSheetDataSetBasForm.GetCDS1: TFDMemTable;
begin
  Result := FFDMemTable;
end;

function TTabSheetDataSetBasForm.GetFDDataSetManager: IFDDataSetManager;
begin
  Result := FDDataSetManager;
end;

function TTabSheetDataSetBasForm.GetFDMemTable: TFDMemTable;
begin
  Result := FFDMemTable;
end;

function TTabSheetDataSetBasForm.GetState: TDataSetState;
begin
  Result := FEntEd.State;
end;

function TTabSheetDataSetBasForm.GetTitulo: string;
begin
  Result := FEntEd.Titulo;
end;

procedure TTabSheetDataSetBasForm.InsAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  inherited;
  if InsExecutando then
    exit;
  State := dsInsert;
  InsExecutando := true;
  try
    while DoInserir do;
  finally
    InsExecutando := False;
    State := dsBrowse;
    DBGrid1.SetFocus;
  end;
end;

procedure TTabSheetDataSetBasForm.RecordToEnt;
begin

end;

procedure TTabSheetDataSetBasForm.SetState(const Value: TDataSetState);
begin
  FEntEd.State := Value;
end;

procedure TTabSheetDataSetBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  AtuAction_DatasetTabSheet.Execute;
  FFiltroEditAutomatico := true;
end;

end.

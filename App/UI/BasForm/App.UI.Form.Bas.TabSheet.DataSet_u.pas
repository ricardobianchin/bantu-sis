unit App.UI.Form.Bas.TabSheet.DataSet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, App.AppInfo, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, Sis.DB.Factory, Vcl.StdCtrls, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, Sis.UI.ImgDM, Sis.Types;

type
  TModoForm = (mfBrowse, mfSelect);

  TTabSheetDataSetBasForm = class(TTabSheetAppBasForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    AtuAction_DatasetTabSheet: TAction;
    InsAction_DatasetTabSheet: TAction;
    AltAction_DatasetTabSheet: TAction;
    ExclAction_DatasetTabSheet: TAction;
    FiltroAtualizarTimer: TTimer;
    SelectPanel: TPanel;
    ToolBar1: TToolBar;
    OkToolButton_DataSetForm: TToolButton;
    CancelToolButton_DataSetForm: TToolButton;
    SelectActionList_DataSetForm: TActionList;
    OkAction: TAction;
    CancelAction: TAction;
    Panel1: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure FiltroAtualizarTimerTimer(Sender: TObject);
    procedure FiltroEdit_DataSetTabSheetChange(Sender: TObject);

    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);

    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure OkActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FModoForm: TModoForm;
    FFDMemTable: TFDMemTable;
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FIdPos: integer;
    // FFDDataSetManager: IFDDataSetManager;

    FFiltroEditAutomatico: boolean;

    // oDBConnection: IDBConnection;
    //FDBConnectionParams: TDBConnectionParams;
    function GetState: TDataSetState;
    procedure SetState(const Value: TDataSetState);

    function GetModoForm: TModoForm;
    procedure AjusteBotoesSelect;
  protected
    AtuExecutando, InsExecutando, AltExecutando, ExclExecutando: boolean;

    function GetFDMemTable: TFDMemTable;
    procedure Inicialize; override;
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
    property EntDBI: IEntDBI read FEntDBI;
    procedure LeRegEInsere(q: TDataSet); virtual;
    procedure RecordToEnt; virtual;
    procedure FDMemTable1AfterScroll(DataSet: TDataSet); virtual;
    function SelectPodeOk: boolean; virtual;

    property ModoForm: TModoForm read GetModoForm;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS;
      pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
      pEntEd: IEntEd; pEntDBI: IEntDBI; pModoForm: TModoForm; pIdPos: integer); reintroduce;

    function GetSelectValues: variant;
    function GetSelectItem: TSelectItem; virtual;
  end;
  TTabSheetDataSetBasFormClass = class of TTabSheetDataSetBasForm;

var
  TabSheetDataSetBasForm: TTabSheetDataSetBasForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils;

{ TTabSheetDataSetBasForm }

procedure TTabSheetDataSetBasForm.AjusteBotoesSelect;
var
  LastButton: TToolButton;
  i: Integer;
begin
  if ModoForm = mfBrowse then
    exit;

  // Encontra o último botão na toolbar
  LastButton := nil;
  for i := 0 to TitToolBar1_BasTabSheet.ButtonCount - 1 do
  begin
    if TitToolBar1_BasTabSheet.Buttons[i].Visible then
      LastButton := TitToolBar1_BasTabSheet.Buttons[i];
  end;

  // Muda o parent do panel para a toolbar
  SelectPanel.Parent := TitToolBar1_BasTabSheet;
  // Posiciona o left do panel
  if LastButton <> nil then
    SelectPanel.Left := LastButton.Left + LastButton.Width + 1
  else
    SelectPanel.Left := 0;

  SelectPanel.Visible := True;
end;

procedure TTabSheetDataSetBasForm.AltAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  Resultado: boolean;
begin
  inherited;
  if FDMemTable.IsEmpty then
  begin
    OutputNotify.exibir('Não há registros a alterar');
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

procedure TTabSheetDataSetBasForm.CancelActionExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

constructor TTabSheetDataSetBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI; pModoForm: TModoForm; pIdPos: integer);
var
  sNomeArq: string;
begin
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
  FModoForm := pModoForm;
  FIdPos := pIdPos;
  inherited Create(AOwner, pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS,
    pOutput, pProcessLog, pOutputNotify);

  State := dsBrowse;

  AtuExecutando := False;
  InsExecutando := False;
  AltExecutando := False;
  ExclExecutando := False;

  FFiltroEditAutomatico := False;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  FFDMemTable.AfterScroll := FDMemTable1AfterScroll;
//  DefCampos;

  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, DBGrid1);

  if ModoForm = mfSelect then
  begin
    Position := poDesktopCenter;
    BorderStyle := bsDialog;
    Align := alNone;
    Caption := 'Selecionando '+EntEd.NomeEnt;
  end;
end;

procedure TTabSheetDataSetBasForm.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if FModoForm = mfBrowse  then
    AltAction_DatasetTabSheet.Execute
  else
    OkAction.Execute;
end;

procedure TTabSheetDataSetBasForm.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case key of
    #32:
    begin
      Key := #0;
      AltAction_DatasetTabSheet.Execute
    end;
    #13:
    begin
      Key := #0;
      OkAction.Execute;
    end;
  end;
end;

procedure TTabSheetDataSetBasForm.DefCampos;
var
  DefsSL: TStringList;
  sNomeArq: string;
  sLinhaAtual: string;
  I: integer;
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

procedure TTabSheetDataSetBasForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModoForm = mfBrowse then
    inherited;

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

function TTabSheetDataSetBasForm.GetSelectItem: TSelectItem;
begin
  Result.Id := FDMemTable.Fields[0].AsInteger;
  Result.Descr := FDMemTable.Fields[1].AsString;
end;

function TTabSheetDataSetBasForm.GetModoForm: TModoForm;
begin
  Result := FModoForm;
end;

function TTabSheetDataSetBasForm.GetSelectValues: variant;
var
  UltimoIndex: integer;
  I: Integer;
begin
  if FDMemTable.IsEmpty then
  begin
    Result := varNull;
    exit;
  end;

  UltimoIndex := FDMemTable.FieldCount - 1;
  Result := VarArrayCreate([0, UltimoIndex - 1], UltimoIndex);
  for I := 0 to UltimoIndex do
  begin
    Result[i] := FDMemTable.Fields[I].Value;
  end;
end;

function TTabSheetDataSetBasForm.GetState: TDataSetState;
begin
  Result := FEntEd.State;
end;

function TTabSheetDataSetBasForm.GetTitulo: string;
begin
  Result := FEntEd.Titulo;
end;

procedure TTabSheetDataSetBasForm.Inicialize;
begin
  inherited;
  AjusteBotoesSelect;
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

procedure TTabSheetDataSetBasForm.LeRegEInsere(q: TDataSet);
var
  I: integer;
begin
  FDMemTable.Append;
  for I := 0 to q.FieldCount - 1 do
  begin
    FDMemTable.FIelds[I].Value := q.FIelds[I].Value;
  end;
  FDMemTable.Post;
end;

procedure TTabSheetDataSetBasForm.OkActionExecute(Sender: TObject);
begin
  if not SelectPodeOk then
    exit;
  inherited;
  ModalResult := mrOk;

end;

procedure TTabSheetDataSetBasForm.RecordToEnt;
begin

end;

function TTabSheetDataSetBasForm.SelectPodeOk: boolean;
begin
  Result := ModoForm = mfSelect;
  if not Result then
    exit;

  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    OutputNotify.Exibir('Nenhum registro visível para ser escolhido');
    exit;
  end;
end;

procedure TTabSheetDataSetBasForm.SetState(const Value: TDataSetState);
begin
  FEntEd.State := Value;
end;

procedure TTabSheetDataSetBasForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  sNomeCampo: string;
begin
  inherited;
  AtuAction_DatasetTabSheet.Execute;
  FFiltroEditAutomatico := true;

  if ModoForm = TModoForm.mfBrowse then
    exit;

  if FIdPos = 0 then
    exit;

  sNomeCampo := FDMemTable.Fields[0].FieldName;
  FDMemTable.Locate(sNomeCampo, FIdPos, []);
end;

end.

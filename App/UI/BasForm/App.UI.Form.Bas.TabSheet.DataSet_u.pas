unit App.UI.Form.Bas.TabSheet.DataSet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Data.DB, Vcl.Grids, Vcl.DBGrids, Sis.Usuario,
  FireDAC.Comp.DataSet, App.AppObj, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, Sis.DB.Factory, Vcl.StdCtrls, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI, Sis.UI.ImgDM, Sis.Types, App.UI.TabSheet.DataSet.Types_u;

type
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
    QtdRegsLabel_TabSheetDataSetBasForm: TLabel;

    procedure FiltroAtualizarTimerTimer(Sender: TObject);
    procedure FiltroEdit_DataSetTabSheetChange(Sender: TObject);

    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);

    procedure DBGrid1DblClick(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FModoDataSetForm: TModoDataSetForm;
    FFDMemTable: TFDMemTable;
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FIdPos: integer;
    // FFDDataSetManager: IFDDataSetManager;

    FFiltroEditAutomatico: boolean;

    FAtualizaAposEd: boolean;

    FFDMemTablePodeEventos: boolean;

    // oDBConnection: IDBConnection;
    // FDBConnectionParams: TDBConnectionParams;
    function GetState: TDataSetState;
    procedure SetState(const Value: TDataSetState);

    function GetModoDataSetForm: TModoDataSetForm;
    procedure AjusteBotoesSelect;
  protected
    AtuExecutando, InsExecutando, AltExecutando, ExclExecutando: boolean;

    procedure AjusteQtdRegsLabel;
    property AtualizaAposEd: boolean read FAtualizaAposEd write FAtualizaAposEd;

    function GetFDMemTable: TFDMemTable;
    procedure PrepareControls; override;
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
    procedure DoLer; virtual;
    procedure DoAlterar; virtual; abstract;
    property EntEd: IEntEd read FEntEd;
    property EntDBI: IEntDBI read FEntDBI;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer); virtual;
    procedure RecordToEnt; virtual;
    procedure EntToRecord; virtual;
    function SelectPodeOk: boolean; virtual;

    // afteropen foi cortado. pois quando é aberta é no defcampos. onde nem tudo foi inicializado
    procedure FDMemTable1AfterScroll(DataSet: TDataSet); virtual;

    property ModoDataSetForm: TModoDataSetForm read GetModoDataSetForm;

    procedure DoAntesAtualizar; virtual;
    procedure DoAposAtualizar; virtual;

    procedure FDMemTableColocarEventos;
    procedure FDMemTableRetirarEventos;

    property FDMemTablePodeEventos: boolean read FFDMemTablePodeEventos
      write FFDMemTablePodeEventos;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); virtual;

    function GetSelectValues: variant;
    function GetSelectItem: TSelectItem; virtual;
  end;

  TTabSheetDataSetBasFormClass = class of TTabSheetDataSetBasForm;

var
  TabSheetDataSetBasForm: TTabSheetDataSetBasForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils, Sis.UI.Controls.Utils;

{ TTabSheetDataSetBasForm }

procedure TTabSheetDataSetBasForm.AjusteBotoesSelect;
var
  LastButton: TToolButton;
  i: integer;
begin
  if ModoDataSetForm = mdfBrowse then
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

procedure TTabSheetDataSetBasForm.AjusteQtdRegsLabel;
begin
  if FDMemTable.IsEmpty then
    QtdRegsLabel_TabSheetDataSetBasForm.Caption := 'Nenhum Registro'
  else
    QtdRegsLabel_TabSheetDataSetBasForm.Caption :=
      FDMemTable.RecordCount.ToString + ' Registros';
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

  AltExecutando := True;
  State := dsEdit;
  try
    RecordToEnt;
    DoLer;
    DoAlterar;
  finally
    State := dsBrowse;
    TrySetFocus(DBGrid1);
    AltExecutando := False;

    if AtualizaAposEd then
      AtuAction_DatasetTabSheet.Execute;
  end;
end;

procedure TTabSheetDataSetBasForm.DoAntesAtualizar;
begin
  FFDMemTablePodeEventos := False;
  FDMemTableRetirarEventos;
end;

procedure TTabSheetDataSetBasForm.DoAposAtualizar;
begin
  FFDMemTablePodeEventos := True;
  FDMemTableColocarEventos;
  AjusteQtdRegsLabel;
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
    AtuExecutando := True;

    DoAntesAtualizar;
    DoAtualizar(Self);
    DoAposAtualizar;
  finally
    TrySetFocus(DBGrid1);
    AtuExecutando := False;
  end;
end;

procedure TTabSheetDataSetBasForm.CancelActionExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

constructor TTabSheetDataSetBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
var
  sNomeArq: string;
begin
  FFDMemTablePodeEventos := True;
  FAtualizaAposEd := False;
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
  FModoDataSetForm := pModoDataSetForm;
  FIdPos := pIdPos;
  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pAppObj);

  State := dsBrowse;

  AtuExecutando := False;
  InsExecutando := False;
  AltExecutando := False;
  ExclExecutando := False;

  FFiltroEditAutomatico := False;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';

  // DefCampos;

  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, DBGrid1);

  if ModoDataSetForm = mdfSelect then
  begin
    Position := poDesktopCenter;
    BorderStyle := bsDialog;
    Align := alNone;
    Caption := 'Selecionando ' + EntEd.NomeEnt;
  end;

  FDMemTableColocarEventos;
end;

procedure TTabSheetDataSetBasForm.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if FModoDataSetForm = mdfBrowse then
    AltAction_DatasetTabSheet.Execute
  else
    OkAction.Execute;
end;

procedure TTabSheetDataSetBasForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_INSERT:
      InsAction_DatasetTabSheet.Execute;
    VK_RETURN:
      OkAction.Execute;
    VK_SPACE:
      AltAction_DatasetTabSheet.Execute;
  end;
end;

procedure TTabSheetDataSetBasForm.DefCampos;
var
  DefsSL: TStringList;
  sNomeArq: string;
  sLinhaAtual: string;
  i: integer;
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

procedure TTabSheetDataSetBasForm.DoLer;
begin

end;

procedure TTabSheetDataSetBasForm.EntToRecord;
begin

end;

procedure TTabSheetDataSetBasForm.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  AjusteQtdRegsLabel;
end;

procedure TTabSheetDataSetBasForm.FDMemTableColocarEventos;
begin
  FFDMemTable.AfterScroll := FDMemTable1AfterScroll;
  AjusteQtdRegsLabel;
end;

procedure TTabSheetDataSetBasForm.FDMemTableRetirarEventos;
begin
  FFDMemTable.AfterScroll := nil;
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
  FiltroAtualizarTimer.Enabled := True;
end;

procedure TTabSheetDataSetBasForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModoDataSetForm = mdfBrowse then
    inherited;

end;

procedure TTabSheetDataSetBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
      AtuAction_DatasetTabSheet.Execute;
  end;
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

function TTabSheetDataSetBasForm.GetModoDataSetForm: TModoDataSetForm;
begin
  Result := FModoDataSetForm;
end;

function TTabSheetDataSetBasForm.GetSelectValues: variant;
var
  UltimoIndex: integer;
  i: integer;
begin
  if FDMemTable.IsEmpty then
  begin
    Result := varNull;
    exit;
  end;

  UltimoIndex := FDMemTable.FieldCount - 1;
  Result := VarArrayCreate([0, UltimoIndex - 1], UltimoIndex);
  for i := 0 to UltimoIndex do
  begin
    Result[i] := FDMemTable.Fields[i].Value;
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

procedure TTabSheetDataSetBasForm.PrepareControls;
var
  sNomeCampo: string;
begin
  inherited;
  FFiltroEditAutomatico := True;
  AjusteBotoesSelect;

  AtuAction_DatasetTabSheet.Execute;

  TrySetFocus(DBGrid1);

  if ModoDataSetForm = TModoDataSetForm.mdfBrowse then
    exit;

  if FIdPos = 0 then
    exit;

  sNomeCampo := FDMemTable.Fields[0].FieldName;
  FDMemTable.Locate(sNomeCampo, FIdPos, []);
end;

procedure TTabSheetDataSetBasForm.InsAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  inherited;
  if InsExecutando then
    exit;
  State := dsInsert;
  InsExecutando := True;
  try
    while DoInserir do;
  finally
    InsExecutando := False;
    State := dsBrowse;
    TrySetFocus(DBGrid1);

    if AtualizaAposEd then
      AtuAction_DatasetTabSheet.Execute;
  end;
end;

procedure TTabSheetDataSetBasForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
var
  i: integer;
begin
  if pRecNo = -1 then
    exit;

  FDMemTable.Append;
  for i := 0 to q.FieldCount - 1 do
  begin
    FDMemTable.Fields[i].Value := q.Fields[i].Value;
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
  Result := ModoDataSetForm = mdfSelect;
  if not Result then
    exit;

  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    OutputNotify.exibir('Nenhum registro visível para ser escolhido');
    exit;
  end;
end;

procedure TTabSheetDataSetBasForm.SetState(const Value: TDataSetState);
begin
  FEntEd.State := Value;
end;

end.

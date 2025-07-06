unit App.UI.Form.Bas.DataSet.Est_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, App.UI.Frame.Bas.EstFiltro_u,
  Sis.DB.DBTypes, Sis.Usuario, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.Ent.Ed, App.Ent.DBI, Sis.Types, App.UI.TabSheet.DataSet.Types_u,
  App.AppObj, App.Est.EstMovDBI, Sis.Types.Utils_u, Sis.Entities.Types,
  Sis.UI.Frame.Bas.DBGrid_u, App.Est.EstMovEnt, App.Est.EstMovItem;

type
  TAppEstDataSetForm = class(TTabSheetDataSetBasForm)
    DetailPanel: TPanel;
    DetailTimer: TTimer;
    CancAction_DatasetTabSheet: TAction;
    CancItemAction_DatasetTabSheet: TAction;
    FinalizAction_DatasetTabSheet: TAction;
    InsItemAction_DatasetTabSheet: TAction;
    AltItemAction_DatasetTabSheet: TAction;
    procedure DetailTimerTimer(Sender: TObject);

    procedure CancAction_DatasetTabSheetExecute(Sender: TObject);
    procedure CancItemAction_DatasetTabSheetExecute(Sender: TObject);
    procedure FinalizAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsItemAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltItemAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FEstFiltroFrame: TEstFiltroFrame;
    FDBConnection: IDBConnection;

    FEstMovEnt: IEstMovEnt<IEstMovItem>;
    FEstMovDBI: IEstMovDBI;

    FDMemTableCANCELADO: TField;
    FDMemTableFinalizado: TField;
    FItemCanceladoField: TField;

    FItemsDBGridFrame: TDBGridFrame;
    procedure DispareDetailTimer;

    procedure SetItemsDBGridFrame(Value: TDBGridFrame);

  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); virtual; abstract;
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;
    function PergEd: boolean; virtual; abstract;

    procedure CrieFiltroFrame; virtual; abstract;
    procedure ToolBar1CrieBotoes; override;
    property EstFiltroFrame: TEstFiltroFrame read FEstFiltroFrame
      write FEstFiltroFrame;
    property DBConnection: IDBConnection read FDBConnection;
    procedure FDMemTable1AfterScroll(DataSet: TDataSet); override;
    procedure DetailCarregar; virtual;

    property DMemTableCANCELADO: TField read FDMemTableCANCELADO;
    property DMemTableFINALIZADO: TField read FDMemTableFinalizado;

    property ItemsDBGridFrame: TDBGridFrame read FItemsDBGridFrame
      write SetItemsDBGridFrame;

    function FinalizPode: boolean; virtual;
    // property EstMovDBI: IEstMovDBI read FEstMovDBI;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  AppEstDataSetForm: TAppEstDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.TToolBar, Sis.UI.Controls.TDBGrid, App.DB.Utils,
  Sis.Sis.Constants, Sis.DB.Factory, App.Retag.Est.Factory, App.UI.Form.Perg_u;

{ TAppEstDataSetForm }

procedure TAppEstDataSetForm.AltAction_DatasetTabSheetExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TAppEstDataSetForm.AltItemAction_DatasetTabSheetExecute(
  Sender: TObject);
var
  Result: Boolean;
begin
  inherited;
  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    ShowMessage('Não há registro de nota a alterar');
    exit;
  end;

  Result := not DMemTableFINALIZADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota já está finalizada e não pode ser alterada');
    exit;
  end;

  Result := not DMemTableCANCELADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota está cancelada e não pode ser alterada');
    exit;
  end;

  Result := not FItemCanceladoField.AsBoolean;
  if not Result then
  begin
    ShowMessage('Item está cancelado e não pode ser alterado');
    exit;
  end;

  RecordToEnt;
  FEstMovEnt.EditandoItem := True;
  try
    AltAction_DatasetTabSheet.Execute;
  finally
    FEstMovEnt.EditandoItem := False;
  end;
end;

procedure TAppEstDataSetForm.CancAction_DatasetTabSheetExecute(Sender: TObject);
var
  bResultado: boolean;
  bErroDeu: boolean;
  i: integer;

  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEstMovId: Int64;

  sCod: string;
  sMens: string;
  dCanceladoEm: TDateTime;
begin
  inherited;
  if FDMemTable.IsEmpty then
  begin
    ShowMessage('Não há registro de nota a cancelar');
    exit;
  end;

  if FDMemTableCANCELADO.AsBoolean then
  begin
    ShowMessage('Nota já está cancelada');
    exit;
  end;

  iLojaId := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  iTerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  iEstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;

  sCod := FDMemTable.Fields[4 { COD } ].AsString;

  sMens := 'Cancelar nota ' + sCod + '?';
  bResultado := App.UI.Form.Perg_u.Perg(sMens, 'Daros PDV',
    TBooleanDefault.boolFalse);

  if not bResultado then
    exit;

  FEstMovDBI.EstMovCancele(dCanceladoEm, bErroDeu, sMens, iLojaId, iEstMovId);

  FDMemTable.Edit;
  FDMemTableCANCELADO.AsBoolean := True;
  FDMemTable.Post;
end;

procedure TAppEstDataSetForm.CancItemAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  bResultado: boolean;
  bErroDeu: boolean;

  i: integer;

  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEstMovId: Int64;
  iOrdem: SmallInt;
  iOrdemExibida: SmallInt;

  sCod: string;
  sMens: string;
  dCanceladoEm: TDateTime;
begin
  inherited;
  if FDMemTable.IsEmpty then
  begin
    ShowMessage('Não há registro de nota a cancelar');
    exit;
  end;

  if ItemsDBGridFrame.FDMemTable1.IsEmpty then
  begin
    ShowMessage('Não há registro de item a cancelar');
    exit;
  end;

  if FItemCanceladoField.AsBoolean then
  begin
    ShowMessage('Item já cancelado');
    exit;
  end;

  iLojaId := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  iTerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  iEstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;

  iOrdemExibida := FItemsDBGridFrame.FDMemTable1.Fields[0 { ORDEM } ].AsInteger;
  iOrdem := iOrdemExibida - 1;

  sCod := FDMemTable.Fields[4 { COD } ].AsString;

  sMens := 'Nota ' + sCod + ', item de ordem Nº ' + iOrdemExibida.ToString +
    #13#10'Excluir item?';

  bResultado := App.UI.Form.Perg_u.Perg(sMens, 'Daros PDV',
    TBooleanDefault.boolFalse);

  if not bResultado then
    exit;

  FEstMovDBI.EstMovCanceleItem(bErroDeu, sMens, iLojaId, iEstMovId, iOrdem);

  if bErroDeu then
  begin
    ShowMessage(sMens);
    exit;
  end;

  FItemsDBGridFrame.FDMemTable1.Edit;
  FItemCanceladoField.AsBoolean := True;
  FItemsDBGridFrame.FDMemTable1.Post;
end;

constructor TAppEstDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  FEstMovEnt := EntEdCastToEstMovEnt(pEntEd);
  FEstMovDBI := EntDBICastToEstMovDBI(pEntDBI);

  FEstMovEnt.EditandoItem := False;

  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEstDataSetForm.Conn',
    AppObj.SisConfig, rDBConnectionParams, ProcessLog, Output);

  InsAction_DatasetTabSheet.Caption := 'Nova Nota';
  FDMemTableCANCELADO := FDMemTable.FindField('CANCELADO');
  FDMemTableFinalizado := FDMemTable.FindField('FINALIZADO');
end;

procedure TAppEstDataSetForm.DetailCarregar;
begin

end;

procedure TAppEstDataSetForm.DetailTimerTimer(Sender: TObject);
begin
  inherited;
  DetailTimer.Enabled := False;
  DetailCarregar;
end;

procedure TAppEstDataSetForm.DispareDetailTimer;
begin
  DetailTimer.Enabled := False;
  DetailTimer.Enabled := True;
end;

procedure TAppEstDataSetForm.DoAlterar;
begin
  inherited;
end;

procedure TAppEstDataSetForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(EstFiltroFrame.Values, EstLeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
    DetailCarregar;
  end;
end;

function TAppEstDataSetForm.DoInserir: boolean;
var
  ValAnterior: Boolean;
begin
  ValAnterior := FEstMovEnt.EditandoItem;
//  FEstMovEnt.EditandoItem := False;

  Result := PergEd;

  if not Result then
    exit;

//  if not FEstMovEnt.EditandoItem then
  if not ValAnterior then
  begin
    FDMemTable.Append;
    EntToRecord;
    FDMemTable.Post;
  end;

  DetailCarregar;
end;

procedure TAppEstDataSetForm.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  DispareDetailTimer;
end;

procedure TAppEstDataSetForm.FinalizAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  bResultado: boolean;
  bErroDeu: boolean;
  i: integer;

  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEstMovId: Int64;

  sCod: string;
  sMens: string;
  dFinalizadoEm: TDateTime;
begin
  inherited;
  if not FinalizPode then
    exit;

  iLojaId := FDMemTable.Fields[0 { LOJA_ID } ].AsInteger;
  iTerminalId := FDMemTable.Fields[1 { TERMINAL_ID } ].AsInteger;
  iEstMovId := FDMemTable.Fields[2 { EST_MOV_ID } ].AsLargeInt;

  sCod := FDMemTable.Fields[4 { COD } ].AsString;

  sMens := 'Finalizar nota ' + sCod + '?';
  bResultado := App.UI.Form.Perg_u.Perg(sMens, 'Daros PDV',
    TBooleanDefault.boolFalse);

  if not bResultado then
    exit;

  FEstMovDBI.EstMovFinalize(dFinalizadoEm, bErroDeu, sMens, iLojaId, iEstMovId);

  FDMemTable.Edit;
  FDMemTableFINALIZADO.AsBoolean := True;
  FDMemTable.Post;
end;

function TAppEstDataSetForm.FinalizPode: boolean;
begin
  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    ShowMessage('Não há registro de nota a finalizar');
    exit;
  end;

  Result := not FDMemTableFINALIZADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota já está finalizada');
    exit;
  end;

  Result := not FDMemTableCANCELADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota está cancelada e não pode ser finalizada');
    exit;
  end;
end;

procedure TAppEstDataSetForm.InsItemAction_DatasetTabSheetExecute(
  Sender: TObject);
var
  Result: Boolean;
begin
  inherited;
  Result := not FDMemTable.IsEmpty;
  if not Result then
  begin
    ShowMessage('Não há registro de nota a alterar');
    exit;
  end;

  Result := not DMemTableFINALIZADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota já está finalizada e não pode ser alterada');
    exit;
  end;

  Result := not DMemTableCANCELADO.AsBoolean;
  if not Result then
  begin
    ShowMessage('Nota está cancelada e não pode ser alterada');
    exit;
  end;

  RecordToEnt;
  FEstMovEnt.EditandoItem := True;
  try
    InsAction_DatasetTabSheet.Execute;
  finally
    FEstMovEnt.EditandoItem := False;
  end;
end;

procedure TAppEstDataSetForm.SetItemsDBGridFrame(Value: TDBGridFrame);
begin
  FItemsDBGridFrame := Value;
  FItemCanceladoField := FItemsDBGridFrame.FDMemTable1.FindField('CANCELADO');
end;

procedure TAppEstDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  InsAction_DatasetTabSheet.Caption := 'Nova Nota de '+FEstMovEnt.NomeEnt;
end;

end.

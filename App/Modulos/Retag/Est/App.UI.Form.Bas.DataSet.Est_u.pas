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
  App.AppObj, App.Est.EstMovDBI, Sis.Types.Utils_u, Sis.Entities.Types;

type
  TAppEstDataSetForm = class(TTabSheetDataSetBasForm)
    DetailPanel: TPanel;
    DetailTimer: TTimer;
    CancAction_DatasetTabSheet: TAction;
    CancItemAction_DatasetTabSheet: TAction;
    procedure DetailTimerTimer(Sender: TObject);
    procedure CancAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FEstFiltroFrame: TEstFiltroFrame;
    FDBConnection: IDBConnection;
    FEstMovDBI: IEstMovDBI;

    FDMemTableCANCELADO: TField;
    FDMemTableFinalizado: TField;
    procedure DispareDetailTimer;

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
    property DMemTableFINALIZADO: TField read FDMemTableFINALIZADO;


//    property EstMovDBI: IEstMovDBI read FEstMovDBI;
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

procedure TAppEstDataSetForm.CancAction_DatasetTabSheetExecute(Sender: TObject);
var
  bResultado: boolean;
var
  i: integer;

  iLojaId: TLojaId;
  iTerminalId: TTerminalId;
  iEstMovId: Int64;

  sCod: string;
  sMens: string;
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

  FEstMovDBI.EstMovCancele(iLojaId, iTerminalId, iEstMovId);
  FDMemTable.Edit;
  FDMemTableCANCELADO.AsBoolean := True;
  FDMemTable.Post;
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
  FEstMovDBI := EntDBICastToEstMovDBI(pEntDBI);
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEstDataSetForm.Conn',
    AppObj.SisConfig, rDBConnectionParams, ProcessLog, Output);

  InsAction_DatasetTabSheet.Caption := 'Nova Nota';
  FDMemTableCANCELADO := FDMemTable.FindField('CANCELADO');
  FDMemTableFINALIZADO := FDMemTable.FindField('FINALIZADO');
end;

procedure TAppEstDataSetForm.DetailCarregar;
begin

end;

procedure TAppEstDataSetForm.DetailTimerTimer(Sender: TObject);
begin
  inherited;
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
begin
  Result := PergEd;

  if not Result then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TAppEstDataSetForm.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  DispareDetailTimer;
end;

procedure TAppEstDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

end;

end.

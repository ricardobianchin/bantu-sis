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
  App.AppObj;

type
  TAppEstDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FEstFiltroFrame: TEstFiltroFrame;
    FDBConnection: IDBConnection;

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
  Sis.Sis.Constants, Sis.DB.Factory;

{ TAppEstDataSetForm }

constructor TAppEstDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate('TAppEstDataSetForm.Conn',
    AppObj.SisConfig, rDBConnectionParams, ProcessLog, Output);
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

procedure TAppEstDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

end;

end.

unit App.UI.Form.Bas.TabSheet.DataSet.Master_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.DataSet.Est_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, Sis.Usuario, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo,
  App.UI.TabSheet.DataSet.Types_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  Sis.DBI, App.UI.Form.Perg_u, App.UI.Form.Bas.TabSheet.DataSet_u;

type
  TTabSheetDataSetMasterBasForm = class(TTabSheetDataSetBasForm)
    DetailPanel: TPanel;
    DetailTimer: TTimer;
    InsItemAction_DatasetTabSheet: TAction;
    AltItemAction_DatasetTabSheet: TAction;
    CancItemAction_DatasetTabSheet: TAction;
    CancAction_DatasetTabSheet: TAction;

    procedure DetailTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FDBConnectionParams: TDBConnectionParams;
    FDBConnection: IDBConnection;
  protected
    function PergEd: boolean; virtual; abstract;
    property DBConnection: IDBConnection read FDBConnection;

    procedure DispareDetailTimer; virtual;
    procedure DetailCarregar; virtual;

//    function DoInserir: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pStrBuscaInicial: string;
      pAppObj: IAppObj); override;
  end;

var
  TabSheetDataSetMasterBasForm: TTabSheetDataSetMasterBasForm;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory;

constructor TTabSheetDataSetMasterBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pStrBuscaInicial: string; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pModoDataSetForm,
    pIdPos, pStrBuscaInicial, pAppObj);

  FDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FDBConnection := DBConnectionCreate(classname + 'create.conn',
    AppObj.SisConfig, FDBConnectionParams, ProcessLog, Output);

end;

procedure TTabSheetDataSetMasterBasForm.DetailCarregar;
begin

end;

procedure TTabSheetDataSetMasterBasForm.DetailTimerTimer(Sender: TObject);
begin
  inherited;
  DetailTimer.Enabled := False;
  DetailCarregar;
end;

procedure TTabSheetDataSetMasterBasForm.DispareDetailTimer;
begin
  DetailTimer.Enabled := False;
  DetailTimer.Enabled := True;
end;

//function TTabSheetDataSetMasterBasForm.DoInserir: boolean;
//var
//  ValAnterior: Boolean;
//begin
//  ValAnterior := FEstMovEnt.EditandoItem;
////  FEstMovEnt.EditandoItem := False;
//
//  Result := PergEd;
//
//  if not Result then
//    exit;
//
////  if not FEstMovEnt.EditandoItem then
//  if not ValAnterior then
//  begin
//    FDMemTable.Append;
//    EntToRecord;
//    FDMemTable.Post;
//  end;
//
//  DetailCarregar;
//end;

end.

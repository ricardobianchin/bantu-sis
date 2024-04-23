unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, App.DB.Import.Origem, App.DB.Import, Sis.DB.DBTypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.AppObj, System.Actions, Vcl.ActnList,
  Vcl.Buttons,
  Sis.UI.IO.Output.ProcessLog;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    StatusMemo: TMemo;
    GridsPanel: TPanel;
    ProdDBGrid: TDBGrid;
    ProdDataSource: TDataSource;
    ExecuteBitBtn: TBitBtn;
    ActionList_AppDBImport: TActionList;
    ExecuteAction_AppDBImport: TAction;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure ExecuteAction_AppDBImportExecute(Sender: TObject);
  private
    { Private declarations }
    FStatusOutput: IOutput;
    FDBImport: IDBImport;
    FDBImportOrigem: IDBImportOrigem;
    FProdFDMemTable: TFDMemTable;
    FAppObj: IAppObj;
    FDestinoDBConnection: IDBConnection;

    function GetNomeArqTabViewProd: string;
    procedure DefCampos;
  protected
    property StatusOutput: IOutput read FStatusOutput write FStatusOutput;
    property ProdFDMemTable: TFDMemTable read FProdFDMemTable;
    property AppObj: IAppObj read FAppObj;

    property DBImport: IDBImport read FDBImport write FDBImport;
    property DBImportOrigem: IDBImportOrigem read FDBImportOrigem
      write FDBImportOrigem;

    function DBImportOrigemCreate: IDBImportOrigem; virtual; abstract;
    function DBImportCreate(pDestinoDBConnection: IDBConnection;
      pDBImportOrigem: IDBImportOrigem; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil): IDBImport; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
  end;

var
  DBImportForm: TDBImportForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, Sis.UI.Controls.Utils, App.DB.Utils;

{ TDBImportForm }

constructor TDBImportForm.Create(AOwner: TComponent; pAppObj: IAppObj);
var
  sNomeArq: string;
  oDBConnectionParams: TDBConnectionParams;
begin
  inherited Create(AOwner);
  FStatusOutput := MemoOutputCreate(StatusMemo);

  FAppObj := pAppObj;
  FProdFDMemTable := TFDMemTable.Create(Self);
  FProdFDMemTable.Name := ClassName + 'ProdFDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;
  sNomeArq := GetNomeArqTabViewProd;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdFDMemTable, ProdDBGrid);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppObj.AppInfo, AppObj.SisConfig);

  FDestinoDBConnection := DBConnectionCreate('CarregLojaConn', AppObj.SisConfig,
    AppObj.dbms, oDBConnectionParams, nil, FStatusOutput);

  FDBImportOrigem := DBImportOrigemCreate;
  FDBImport := DBImportCreate(FDestinoDBConnection, FDBImportOrigem,
    FStatusOutput, nil);
end;

procedure TDBImportForm.DefCampos;
var
  DefsSL: TStringList;
  sNomeArq: string;
  sLinhaAtual: string;
  i: integer;
  oFDDataSetManager: IFDDataSetManager;
begin
  DefsSL := TStringList.Create;
  try
    sNomeArq := GetNomeArqTabViewProd;
    DefsSL.LoadFromFile(sNomeArq);
    oFDDataSetManager := FDDataSetManagerCreate(FProdFDMemTable, ProdDBGrid);
    oFDDataSetManager.DefinaCampos(DefsSL);
  finally
    DefsSL.Free;
  end;
end;

procedure TDBImportForm.ExecuteAction_AppDBImportExecute(Sender: TObject);
begin
  inherited;
  FDBImport.Execute;
end;

function TDBImportForm.GetNomeArqTabViewProd: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Config\Import\tabview.config.import.prod.csv';

  Result := sNomeArq;
end;

procedure TDBImportForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
end;

end.

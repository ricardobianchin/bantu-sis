unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, Sis.DB.DBTypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.AppObj, System.Actions, Vcl.ActnList,
  Vcl.Buttons, Sis.UI.IO.Output.ProcessLog, Vcl.ComCtrls, Sis.Usuario;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    GridsPanel: TPanel;
    ProdDBGrid: TDBGrid;
    ExecuteBitBtn: TBitBtn;
    ActionList_AppDBImport: TActionList;
    ExecuteAction_AppDBImport: TAction;
    ZerarExecuteAction_AppDBImport: TAction;
    ZerarBitBtn: TBitBtn;
    AtualizarAction_AppDBImport: TAction;
    ValidarAction_AppDBImport: TAction;
    ValidarBitBtn_AppDBImport: TBitBtn;
    RejeicaoDBGrid: TDBGrid;
    SplitterRejeicaoGrid: TSplitter;
    ProdRejDataSource: TDataSource;
    ProdDataSource: TDataSource;
    StatusPanel: TPanel;
    ProgressBar1: TProgressBar;
    ExibirTitLabel: TLabel;
    ExibirComboBox: TComboBox;
    AtualizarBitBtn_AppDBImport: TBitBtn;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure ZerarExecuteAction_AppDBImportExecute(Sender: TObject);
    procedure ExibirComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    FProcessLog: IProcessLog;
    FStatusOutput: IOutput;
    FProdFDMemTable: TFDMemTable;
    FProdRejFDMemTable: TFDMemTable;
    FAppObj: IAppObj;
    FDestinoDBConnection: IDBConnection;
    FUsuario: IUsuario;

    function GetNomeArqTabViewProd: string;
    function GetNomeArqTabViewRej: string;
    procedure DefCampos;
  protected
    function ZereDados(pDestinoDBConnection: IDBConnection): boolean;

    property ProcessLog: IProcessLog read FProcessLog;
    property StatusOutput: IOutput read FStatusOutput;
    property ProdFDMemTable: TFDMemTable read FProdFDMemTable;
    property ProdRejFDMemTable: TFDMemTable read FProdRejFDMemTable;

    property AppObj: IAppObj read FAppObj;
    property DestinoDBConnection: IDBConnection read FDestinoDBConnection;
    property Usuario: IUsuario read FUsuario;
    procedure CarregarRej;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pUsuario: IUsuario;
      pProcessLog: IProcessLog = nil);
  end;

var
  DBImportForm: TDBImportForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Input.Perg, Sis.DB.DataSet.Utils, Sis.DB.Factory,
  Sis.UI.Controls.Utils, App.DB.Utils,
  Sis.UI.IO.Output.ProcessLog.Factory;

{ TDBImportForm }

procedure TDBImportForm.CarregarRej;
var
  sSql: string;
  q: TDataSet;
  I: integer;
begin
  // inherited;
  sSql :=
    'SELECT'#13#10
    +'  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10
    +'  r.IMPORT_PROD_REJEICAO_ID_DESTINO,'#13#10
    +'  t.DESCR'#13#10
    +'FROM IMPORT_PROD_REJEICAO r'#13#10
    +'JOIN IMPORT_REJEICAO_TIPO t ON'#13#10
    +'r.IMPORT_REJEICAO_TIPO_ID = t.IMPORT_REJEICAO_TIPO_ID'#13#10
//    +'WHERE r.IMPORT_PROD_REJEICAO_ID_ORIGEM = :IMPORT_PROD_ID'#13#10
//    +'   OR r.IMPORT_PROD_REJEICAO_ID_DESTINO = :IMPORT_PROD_ID;'#13#10
    +'ORDER BY'#13#10
    +'  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10
    +'  r.IMPORT_PROD_REJEICAO_ID_DESTINO'#13#10
    ;

  DestinoDBConnection.Abrir;
  ProdRejFDMemTable.DisableControls;
  try
    DestinoDBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        ProdRejFDMemTable.Append;
        QueryToFDMemTable(ProdRejFDMemTable, q);
        ProdRejFDMemTable.Post;

        q.Next;
      end;
    finally
      q.Free;
    end
  finally
    DestinoDBConnection.Fechar;
    ProdRejFDMemTable.EnableControls;
  end
end;

constructor TDBImportForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuario: IUsuario; pProcessLog: IProcessLog = nil);
var
  sNomeArq: string;
  oDBConnectionParams: TDBConnectionParams;
begin
  inherited Create(AOwner);
  FUsuario := pUsuario;
  if pProcessLog = nil then
    FProcessLog := MudoProcessLogCreate
  else
    FProcessLog := pProcessLog;

  FStatusOutput := MudoOutputCreate;

  FAppObj := pAppObj;

  FProdFDMemTable := TFDMemTable.Create(Self);
  FProdFDMemTable.Name := ClassName + 'ProdFDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;

  FProdRejFDMemTable := TFDMemTable.Create(Self);
  FProdRejFDMemTable.Name := ClassName + 'ProdRejFDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;


  sNomeArq := GetNomeArqTabViewProd;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdFDMemTable, ProdDBGrid);

  sNomeArq := GetNomeArqTabViewRej;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdRejFDMemTable, RejeicaoDBGrid);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppObj.AppInfo, AppObj.SisConfig);

  FDestinoDBConnection := DBConnectionCreate('CarregLojaConn', AppObj.SisConfig,
    AppObj.dbms, oDBConnectionParams, ProcessLog, FStatusOutput);
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

procedure TDBImportForm.ExibirComboBoxChange(Sender: TObject);
begin
  inherited;
  AtualizarAction_AppDBImport.Execute;
end;

function TDBImportForm.GetNomeArqTabViewProd: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Config\Import\tabview.config.shop.import.prod.csv';

  Result := sNomeArq;
end;

function TDBImportForm.GetNomeArqTabViewRej: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Config\Import\tabview.config.shop.import.prod.rejeicao.csv';

  Result := sNomeArq;
end;

procedure TDBImportForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
  ProgressBar1.Left := 2;
  AtualizarAction_AppDBImport.Execute;
end;

procedure TDBImportForm.ZerarExecuteAction_AppDBImportExecute(Sender: TObject);
begin
  inherited;
  ZereDados(nil);
end;

function TDBImportForm.ZereDados(pDestinoDBConnection: IDBConnection): boolean;
var
  bRecebeuConex: boolean;
  sSql: string;
begin
{$IFNDEF DEBUG}
  Result := PergBool('Zerar os dados? Esta ação não poderá ser desfeita');
{$ELSE}
  Result := True;
{$ENDIF}
  if not Result then
    exit;
  exit;
  bRecebeuConex := Assigned(pDestinoDBConnection);

  if not bRecebeuConex then
  begin
    Result := FDestinoDBConnection.Abrir;
    if not Result then
      exit;
  end;

  try
    Result := True;
    sSql := 'EXECUTE PROCEDURE IMPORT_PROD_PA.APAGAR_DO;';
    FDestinoDBConnection.ExecuteSQL(sSql);
  finally
    if not bRecebeuConex then
    begin
      FDestinoDBConnection.Fechar;
    end;
    AtualizarAction_AppDBImport.Execute;
  end;
end;

end.

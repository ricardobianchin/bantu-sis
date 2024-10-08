unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, Sis.DB.DBTypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.AppObj, System.Actions, Vcl.ActnList,
  Vcl.Buttons, Sis.UI.IO.Output.ProcessLog, Vcl.ComCtrls, Sis.Usuario,
  Sis.Lists.IntegerList,
  App.DB.Import.Types_u;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    GridsPanel: TPanel;
    ProdDBGrid: TDBGrid;
    ExecuteBitBtn: TBitBtn;
    ActionList_AppDBImport: TActionList;
    ImportarAction_AppDBImport: TAction;
    ZerarAction_AppDBImport: TAction;
    AtualizarAction_AppDBImport: TAction;
    AtualizarBitBtn_AppDBImport: TBitBtn;
    ValidarAction_AppDBImport: TAction;
    RejeicaoDBGrid: TDBGrid;
    SplitterRejeicaoGrid: TSplitter;
    ProdRejDataSource: TDataSource;
    ProdDataSource: TDataSource;
    StatusPanel: TPanel;
    ProgressBar1: TProgressBar;
    FilConfTitLabel: TLabel;
    FIlConfComboBox: TComboBox;
    FilSelecTitLabel: TLabel;
    FilSelecComboBox: TComboBox;
    ZerarBitBtn: TBitBtn;
    ValidarBitBtn_AppDBImport: TBitBtn;
    EditAction_AppDBImport: TAction;
    EditBitBtn_AppDBImport: TBitBtn;
    RejEdAction_AppDBImport: TAction;
    RejEdBitBtn_AppDBImport: TBitBtn;
    InclusaoAlterarAction_AppDBImport: TAction;
    InclusaoAlterarBitBtn_AppDBImport: TBitBtn;
    BitBtn1: TBitBtn;
    FinalizarAction_AppDBImport: TAction;

    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure ZerarAction_AppDBImportExecute(Sender: TObject);
    procedure FIlConfComboBoxChange(Sender: TObject);

    procedure AtualizarAction_AppDBImportExecute(Sender: TObject);
    procedure RejEdAction_AppDBImportExecute(Sender: TObject);
    procedure ValidarAction_AppDBImportExecute(Sender: TObject);
    procedure ImportarAction_AppDBImportExecute(Sender: TObject);
    procedure InclusaoAlterarAction_AppDBImportExecute(Sender: TObject);
    procedure FinalizarAction_AppDBImportExecute(Sender: TObject);
  private
    { Private declarations }
    FProcessLog: IProcessLog;
    FStatusOutput: IOutput;
    FProdFDMemTable: TFDMemTable;
    FProdRejFDMemTable: TFDMemTable;
    FAppObj: IAppObj;
    FDestinoDBConnectionParams: TDBConnectionParams;
    FDestinoDBConnection: IDBConnection;
    FUsuario: IUsuario;

    function GetNomeArqTabViewProd: string;
    function GetNomeArqTabViewRej: string;
    procedure DefCampos;
    procedure RejPreencherIntegerList(pIntegerList: IIntegerList);
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
    procedure DoImport; virtual; abstract;
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
  Sis.Lists.Factory, Sis.UI.Controls.Utils, App.DB.Utils,
  Sis.UI.IO.Output.ProcessLog.Factory, App.DB.Import.Form.SQL.Atualizar_u,
  App.DB.Import.Prod.Rej.Ed.Form_u, Sis.Win.Utils_u,
  App.DB.Import.Form_Finalizar_u, Sis.Types.Bool_u, Sis.Sis.Constants;

{ TDBImportForm }

procedure TDBImportForm.AtualizarAction_AppDBImportExecute(Sender: TObject);
var
  sSql: string;
  q: TDataSet;
  ConfStatus: TConfStatus;
  SelStatus: TSelStatus;
begin
  // inherited;
  case FIlConfComboBox.ItemIndex of
    0:
      ConfStatus := TConfStatus.confTodos;
    1:
      ConfStatus := TConfStatus.confRejeitados;
    2:
      ConfStatus := TConfStatus.confAceitos;
  end;

  case FilSelecComboBox.ItemIndex of
    0:
      SelStatus := TSelStatus.selTodos;
    1:
      SelStatus := TSelStatus.selSelecionados;
    2:
      SelStatus := TSelStatus.selNaoSelecionados;
  end;

  sSql := App.DB.Import.Form.SQL.Atualizar_u.AtualizarGetSQL(ConfStatus,
    SelStatus);

  DestinoDBConnection.Abrir;
  ProdFDMemTable.DisableControls;
  try
    ProdFDMemTable.EmptyDataSet;
    DestinoDBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        ProdFDMemTable.Append;
        QueryToFDMemTable(ProdFDMemTable, q);
        ProdFDMemTable.Post;
        q.Next;
      end;
    finally
      q.Free;
    end
  finally
    CarregarRej;
    DestinoDBConnection.Fechar;
    ProdFDMemTable.First;
    ProdFDMemTable.EnableControls;
    ProdDBGrid.Repaint;
  end
end;

procedure TDBImportForm.CarregarRej;
var
  sSql: string;
  q: TDataSet;
  I: integer;
begin
  // inherited;
  sSql := 'SELECT'#13#10 //
    + '  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10 +
    '  r.IMPORT_PROD_REJEICAO_ID_DESTINO,'#13#10 //
    + '  t.DESCR'#13#10 //
    + 'FROM IMPORT_PROD_REJEICAO r'#13#10 //
    + 'JOIN IMPORT_REJEICAO_TIPO t ON'#13#10 +
    'r.IMPORT_REJEICAO_TIPO_ID = t.IMPORT_REJEICAO_TIPO_ID'#13#10 //
  // +'WHERE r.IMPORT_PROD_REJEICAO_ID_ORIGEM = :IMPORT_PROD_ID'#13#10
  // +'   OR r.IMPORT_PROD_REJEICAO_ID_DESTINO = :IMPORT_PROD_ID;'#13#10
    + 'ORDER BY'#13#10 //
    + '  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10 //
    + '  r.IMPORT_PROD_REJEICAO_ID_DESTINO'#13#10; //

  DestinoDBConnection.Abrir;
  ProdRejFDMemTable.DisableControls;
  try
    ProdRejFDMemTable.EmptyDataSet;
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
    ProdRejFDMemTable.First;
    ProdRejFDMemTable.EnableControls;
  end
end;

constructor TDBImportForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuario: IUsuario; pProcessLog: IProcessLog = nil);
var
  sNomeArq: string;
  sNomeIndice: String;
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

  sNomeArq := GetNomeArqTabViewProd;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdFDMemTable, ProdDBGrid);

  sNomeIndice := 'I' + FProdFDMemTable.Name + FProdFDMemTable.Fields[0]
    .FieldName;
  with FProdFDMemTable.Indexes.Add do
  begin
    Name := sNomeIndice;
    Fields := 'import_prod_id';
    Active := True;
  end;
  FProdFDMemTable.IndexesActive := True;
  FProdFDMemTable.IndexName := sNomeIndice; // Ative o índice


  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;

  FProdRejFDMemTable := TFDMemTable.Create(Self);
  FProdRejFDMemTable.Name := ClassName + 'ProdRejFDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;

  sNomeArq := GetNomeArqTabViewRej;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdRejFDMemTable,
    RejeicaoDBGrid);

  FDestinoDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj.AppInfo, AppObj.SisConfig);

  FDestinoDBConnection := DBConnectionCreate('CarregLojaConn', AppObj.SisConfig,
    AppObj.dbms, FDestinoDBConnectionParams, ProcessLog, FStatusOutput);
end;

procedure TDBImportForm.DefCampos;
var
  DefsSL: TStringList;
  sNomeArq: string;
  sLinhaAtual: string;
  I: integer;
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

procedure TDBImportForm.ImportarAction_AppDBImportExecute(Sender: TObject);
begin
  inherited;
  ImportarAction_AppDBImport.Enabled := False;
  try
    DoImport;
    ValidarAction_AppDBImport.Execute;
  finally
    ImportarAction_AppDBImport.Enabled := True;
  end;
end;

procedure TDBImportForm.FIlConfComboBoxChange(Sender: TObject);
begin
  inherited;
  AtualizarAction_AppDBImport.Execute;
end;

procedure TDBImportForm.FinalizarAction_AppDBImportExecute(Sender: TObject);
begin
  inherited;
  FinalizarAction_AppDBImport.Enabled := False;
  try
    ValidarAction_AppDBImport.Execute;

    if not FProdRejFDMemTable.IsEmpty then
      raise Exception.Create('Não pode ser finalizado existindo ainda rejeições');
    App.DB.Import.Form_Finalizar_u.Finalizar(FProdFDMemTable,
      FDestinoDBConnection, AppObj, Usuario, ProgressBar1);
  finally
    FinalizarAction_AppDBImport.Enabled := True;
  end;
end;

procedure TDBImportForm.FormCreate(Sender: TObject);
begin
  inherited;
  Height := 650;
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

procedure TDBImportForm.InclusaoAlterarAction_AppDBImportExecute
  (Sender: TObject);
var
  bValor: boolean;
  sSql: string;
  oBookmark: TBookmark;
begin
  inherited;
  if FProdFDMemTable.IsEmpty then
    exit;

  InclusaoAlterarAction_AppDBImport.Enabled := False;
  DestinoDBConnection.Abrir;
  oBookmark := FProdFDMemTable.GetBookmark;
  try
    bValor := not FProdFDMemTable.FieldByName('VAI_IMPORTAR').AsBoolean;
    sSql := 'UPDATE IMPORT_PROD SET VAI_IMPORTAR=' + BooleanToStrSQL(bValor) +
      ' WHERE IMPORT_PROD_ID = ' + FProdFDMemTable.FieldByName('IMPORT_PROD_ID')
      .AsInteger.ToString + ';';
    DestinoDBConnection.ExecuteSQL(sSql);

    FProdFDMemTable.Edit;
    FProdFDMemTable.FieldByName('VAI_IMPORTAR').AsBoolean := bValor;
    FProdFDMemTable.Post;
    ValidarAction_AppDBImport.Execute;
  finally
    DestinoDBConnection.Fechar;
    FProdFDMemTable.GotoBookmark(oBookmark);
    FProdFDMemTable.FreeBookmark(oBookmark);
    InclusaoAlterarAction_AppDBImport.Enabled := True;
  end;
end;

procedure TDBImportForm.RejEdAction_AppDBImportExecute(Sender: TObject);
var
  bResultado: boolean;
  oIntegerList: IIntegerList;
begin
  // inherited;
  RejEdAction_AppDBImport.Enabled := False;
  try
    oIntegerList := IntegerListCreate;
    oIntegerList.AceitaRepetidos := False;

    RejPreencherIntegerList(oIntegerList);

    bResultado := App.DB.Import.Prod.Rej.Ed.Form_u.Perg(Self, AppObj, //
      FDestinoDBConnection, //

      FProdFDMemTable, //
      ProdRejFDMemTable, //

      oIntegerList, Usuario, ProcessLog, //
      FStatusOutput); //

    if not bResultado then
      exit;

    ValidarAction_AppDBImport.Execute;
  finally
    RejEdAction_AppDBImport.Enabled := True;
  end;
end;

procedure TDBImportForm.RejPreencherIntegerList(pIntegerList: IIntegerList);
var
  oBookmark: TBookmark;
  iIdAtual: integer;
begin
  pIntegerList.Clear;

  if FProdRejFDMemTable.Eof then
    exit;

  FProdRejFDMemTable.DisableControls;
  iIdAtual := FProdRejFDMemTable.Fields[0].AsInteger;
  oBookmark := FProdRejFDMemTable.GetBookmark;
  FProdRejFDMemTable.First;
  try
    while not FProdRejFDMemTable.Eof do
    begin
      if (FProdRejFDMemTable.Fields[0].AsInteger = iIdAtual) or
        (FProdRejFDMemTable.Fields[1].AsInteger = iIdAtual) then
      begin
        pIntegerList.Add(FProdRejFDMemTable.Fields[0].AsInteger);
        pIntegerList.Add(FProdRejFDMemTable.Fields[1].AsInteger);
      end;
      FProdRejFDMemTable.Next;
    end;
  finally
    FProdRejFDMemTable.GotoBookmark(oBookmark);
    FProdRejFDMemTable.FreeBookmark(oBookmark);
    FProdRejFDMemTable.EnableControls;
  end;
end;

procedure TDBImportForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
  ProgressBar1.Left := 2;
  AtualizarAction_AppDBImport.Execute;
  ProdDBGrid.SetFocus;
end;

procedure TDBImportForm.ValidarAction_AppDBImportExecute(Sender: TObject);
type
  TConfStatus = (confTodos, confRejeitados, confAceitos);
  TSelStatus = (selTodos, selSelecionados, selNaoSelecionados);

var
  OrigQ: TDataSet;
  DestDBQuery: IDBQuery;
  sSqlOrig: string;
  sSqlQtd: string;
  sSqlDest: string;
  sSqlInsRej: string;
  QtdRegs: integer;
  RegAtual: integer;
  InsDBExec: IDBExec;

  RejeicaoIdOrigem, RejeicaoIdDestino, RejeicaoTipoId: integer;
begin
  inherited;
  ValidarAction_AppDBImport.Enabled := False;
  try
    sSqlQtd := 'SELECT COUNT(*) FROM IMPORT_PROD WHERE VAI_IMPORTAR;';

    // orig ini
    sSqlOrig := //
      'WITH IP AS ('#13#10 //
      + '  SELECT '#13#10 //
      + '    IMPORT_PROD_ID,'#13#10 //
      + '    IMPORT_FABR_ID,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_PROD_ID IS NULL OR NOVO_PROD_ID < 1 THEN PROD_ID'#13#10
    //
      + '        ELSE NOVO_PROD_ID'#13#10 //
      + '    END AS PRODUTO_ID,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10
    //
      + '        ELSE NOVO_DESCR'#13#10 //
      + '    END AS DESCRICAO,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_DESCR_RED IS NULL OR NOVO_DESCR_RED = '''' THEN DESCR_RED'#13#10
    //
      + '        ELSE NOVO_DESCR_RED'#13#10 //
      + '    END AS DESCRICAO_RED '#13#10 //
      + '  FROM IMPORT_PROD '#13#10 //
      + '  WHERE VAI_IMPORTAR '#13#10 //
      + '  ORDER BY IMPORT_PROD_ID'#13#10 //
      + ') '#13#10 //
      + 'SELECT '#13#10 //
      + '  IMPORT_PROD_ID,'#13#10 //
      + '  IMPORT_FABR_ID,'#13#10 //
      + '  PRODUTO_ID,'#13#10 //
      + '  DESCRICAO,'#13#10 //
      + '  DESCRICAO_RED '#13#10 //
      + 'FROM IP;'#13#10; //
    // orig fim

    // dest ini
    sSqlDest := //
      'WITH IP AS ('#13#10 //
      + '  SELECT '#13#10 //
      + '    IMPORT_PROD_ID,'#13#10 //
      + '    IMPORT_FABR_ID,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_PROD_ID IS NULL OR NOVO_PROD_ID < 1 THEN PROD_ID'#13#10
    //
      + '        ELSE NOVO_PROD_ID'#13#10 //
      + '    END AS PRODUTO_ID,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10
    //
      + '        ELSE NOVO_DESCR'#13#10 //
      + '    END AS DESCRICAO,'#13#10 //
      + '    CASE'#13#10 //
      + '        WHEN NOVO_DESCR_RED IS NULL OR NOVO_DESCR_RED = '''' THEN DESCR_RED'#13#10
    //
      + '        ELSE NOVO_DESCR_RED'#13#10 //
      + '    END AS DESCRICAO_RED '#13#10 //
      + '  FROM IMPORT_PROD '#13#10 //
      + '  WHERE VAI_IMPORTAR '#13#10 //
      + '  AND IMPORT_PROD_ID > :IMPORT_PROD_ID '#13#10 //
      + '  ORDER BY IMPORT_PROD_ID'#13#10 //
      + ') '#13#10 //
      + 'SELECT '#13#10 //
      + '  IMPORT_PROD_ID,'#13#10 //
      + '  IMPORT_FABR_ID,'#13#10 //
      + '  PRODUTO_ID,'#13#10 //
      + '  DESCRICAO,'#13#10 //
      + '  DESCRICAO_RED'#13#10 //
      + 'FROM IP'#13#10 //
      + 'WHERE IMPORT_FABR_ID = :IMPORT_FABR_ID '#13#10 //
      + 'AND (DESCRICAO = :DESCRICAO '#13#10 //
      + 'OR  DESCRICAO_RED = :DESCRICAO_RED) '#13#10 //
      + ';'#13#10; //
    // dest fim

    sSqlInsRej := 'INSERT INTO IMPORT_PROD_REJEICAO(' +
      'IMPORT_PROD_REJEICAO_ID_ORIGEM, IMPORT_PROD_REJEICAO_ID_DESTINO, IMPORT_REJEICAO_TIPO_ID'
      + ') VALUES (' +
      ':IMPORT_PROD_REJEICAO_ID_ORIGEM, :IMPORT_PROD_REJEICAO_ID_DESTINO, :IMPORT_REJEICAO_TIPO_ID'
      + ');';

    // {$IFDEF DEBUG}
    // SetClipboardText(sSqlQtd);
    // {$ENDIF}

{$IFDEF DEBUG}
    // SetClipboardText(sSqlOrig);
{$ENDIF}
{$IFDEF DEBUG}
    SetClipboardText(sSqlDest);
{$ENDIF}

    // {$IFDEF DEBUG}
    // SetClipboardText(sSqlInsRej);
    // {$ENDIF}

    DestinoDBConnection.Abrir;
    DestinoDBConnection.ExecuteSQL('DELETE FROM IMPORT_PROD_REJEICAO;');

    ProgressBar1.Position := 0;
    ProgressBar1.Visible := True;
    try
      QtdRegs := DestinoDBConnection.GetValueInteger(sSqlQtd);
      ProgressBar1.Max := QtdRegs;

      DestDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q',
        DestinoDBConnection, sSqlDest, ProcessLog, StatusOutput);
      DestDBQuery.Prepare;

      InsDBExec := DBExecCreate('Config.Import.Prod.Rejeicao.Ins',
        DestinoDBConnection, sSqlInsRej, ProcessLog, StatusOutput);
      InsDBExec.Prepare;

      DestinoDBConnection.QueryDataSet(sSqlOrig, OrigQ);

      RegAtual := 0;
      while not OrigQ.Eof do
      begin
        DestDBQuery.Params[0].AsInteger := OrigQ.Fields[0].AsInteger;
        DestDBQuery.Params[1].AsInteger := OrigQ.Fields[1].AsInteger;
        DestDBQuery.Params[2].AsString := Trim(OrigQ.Fields[3].AsString);
        DestDBQuery.Params[3].AsString := Trim(OrigQ.Fields[4].AsString);

        DestDBQuery.Abrir;
        try
          while not DestDBQuery.DataSet.Eof do
          begin
            RejeicaoIdOrigem := OrigQ.Fields[0].AsInteger;
            RejeicaoIdDestino := DestDBQuery.DataSet.Fields[0].AsInteger;

            if OrigQ.Fields[3].AsString = DestDBQuery.DataSet.Fields[3].AsString
            then
            begin
              RejeicaoTipoId := 1;
              InsDBExec.Params[0].AsInteger := RejeicaoIdOrigem;
              InsDBExec.Params[1].AsInteger := RejeicaoIdDestino;
              InsDBExec.Params[2].AsInteger := RejeicaoTipoId;
              InsDBExec.Execute;
            end;

            if OrigQ.Fields[4].AsString = DestDBQuery.DataSet.Fields[4].AsString
            then
            begin
              RejeicaoTipoId := 2;
              InsDBExec.Params[0].AsInteger := RejeicaoIdOrigem;
              InsDBExec.Params[1].AsInteger := RejeicaoIdDestino;
              InsDBExec.Params[2].AsInteger := RejeicaoTipoId;
              InsDBExec.Execute;
            end;

            DestDBQuery.DataSet.Next;
          end;
        finally
          DestDBQuery.Fechar;
        end;
        OrigQ.Next;
        inc(RegAtual);
        ProgressBar1.Position := RegAtual;
      end;

    finally
      DestDBQuery.Unprepare;
      InsDBExec.Unprepare;
      OrigQ.Free;
      AtualizarAction_AppDBImport.Execute;
      DestinoDBConnection.Fechar;
      ProgressBar1.Visible := False;
    end;
  finally
    ValidarAction_AppDBImport.Enabled := True;
  end;
end;

procedure TDBImportForm.ZerarAction_AppDBImportExecute(Sender: TObject);
begin
  inherited;
  ZerarAction_AppDBImport.Enabled := False;
  try
    ZereDados(nil);
  finally
    ZerarAction_AppDBImport.Enabled := True;
  end;
end;

function TDBImportForm.ZereDados(pDestinoDBConnection: IDBConnection): boolean;
var
  bRecebeuConex: boolean;
  sSql: string;
  sl: TStringList;
  I: integer;
  sAssunto: string;
  sNomeBanco: string;
  sPastaComando: string;

  {

    @echo off
    set ISQL="C:\caminho\para\isql.exe"
    set USER=SYSDBA
    set PASSWORD=masterkey
    set DB=DELPHI-BTU:C:\Pr\app\bantu\bantu-sis\Exe\Dados\RETAG.FDB
    set SCRIPT="C:\Pr\app\bantu\bantu-sis\Exe\Comandos\Import\SQL import zerar RETAG 2024-05-06_14-58-54-571.sql"

    %ISQL% -u %USER% -p %PASSWORD% %DB% -i %SCRIPT%


    C:\Pr\app\bantu\bantu-sis\Exe\Comandos\Comandos\Import\teste.bat
  }

begin
{$IFNDEF DEBUG}
  Result := PergBool('Zerar os dados? Esta ação não poderá ser desfeita');
{$ELSE}
  Result := True;
{$ENDIF}
  if not Result then
    exit;

  bRecebeuConex := Assigned(pDestinoDBConnection);

  if not bRecebeuConex then
  begin
    Result := FDestinoDBConnection.Abrir;
    if not Result then
      exit;
  end;

  sl := TStringList.Create;
  try
    Result := True;

    sl.Add('CONNECT "' + FDestinoDBConnectionParams.Database +
      '" USER ''SYSDBA'' PASSWORD ''masterkey'';');

    sl.Add('EXECUTE PROCEDURE IMPORT_PROD_PA.APAGAR_DO;');
    sl.Add('ALTER SEQUENCE PROD_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE FABR_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE PROD_TIPO_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE UNID_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE ICMS_SEQ RESTART WITH  4;');
    sl.Add('ALTER SEQUENCE LOG_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE MACHINE_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE PESSOA_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE IMPORT_FABR_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE IMPORT_PROD_TIPO_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE IMPORT_UNID_SEQ RESTART WITH  1;');
    sl.Add('ALTER SEQUENCE IMPORT_ICMS_SEQ RESTART WITH  4;');
    sl.Add('ALTER SEQUENCE IMPORT_PROD_SEQ RESTART WITH  1;');

    sAssunto := 'import zerar';
    sNomeBanco := FDestinoDBConnectionParams.GetNomeBanco;
    sPastaComando := AppObj.AppInfo.PastaComandos + 'Import\';

    AppObj.dbms.ExecInterative(sAssunto, sl.Text, sNomeBanco, sPastaComando,
      ProcessLog, StatusOutput);
  finally
    if not bRecebeuConex then
    begin
      FDestinoDBConnection.Fechar;
      sl.Free;
    end;
    AtualizarAction_AppDBImport.Execute;
  end;
end;

end.

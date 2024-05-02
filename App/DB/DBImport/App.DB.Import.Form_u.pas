unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, Sis.DB.DBTypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.AppObj, System.Actions, Vcl.ActnList,
  Vcl.Buttons, Sis.UI.IO.Output.ProcessLog, Vcl.ComCtrls, Sis.Usuario, Sis.Lists.IntegerList;

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
    SelecBitBtn_AppDBImport: TBitBtn;
    RejEdAction_AppDBImport: TAction;
    RejEdBitBtn_AppDBImport: TBitBtn;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure ZerarExecuteAction_AppDBImportExecute(Sender: TObject);
    procedure FIlConfComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AtualizarAction_AppDBImportExecute(Sender: TObject);
    procedure RejEdAction_AppDBImportExecute(Sender: TObject);
    procedure ValidarAction_AppDBImportExecute(Sender: TObject);
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
  Sis.UI.IO.Output.ProcessLog.Factory, Sis.Win.Utils_u,
  App.DB.Import.Prod.Rej.Ed.Form_u;

{ TDBImportForm }

procedure TDBImportForm.AtualizarAction_AppDBImportExecute(Sender: TObject);
type
  TConfStatus = (confTodos, confRejeitados, confAceitos);
  TSelStatus = (selTodos, selSelecionados, selNaoSelecionados);

var
  sSql: string;
  q: TDataSet;
  iIdAnt: integer;
  iIdAtu: integer;
  sBarCodes: string;
  ConfStatus: TConfStatus;
  SelStatus: TSelStatus;
  WhereStr: string;
begin
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

  // inherited;
  sSql := 'WITH REJ_ORI AS'#13#10 //
    + '('#13#10 //
    + '  SELECT IPRO.IMPORT_PROD_REJEICAO_ID_ORIGEM ID'#13#10 //
    + '  FROM IMPORT_PROD_REJEICAO IPRO'#13#10 //
    + ')'#13#10 //
    + ', REJ_DEST AS'#13#10 //
    + '('#13#10 //
    + '  SELECT IPRO.IMPORT_PROD_REJEICAO_ID_DESTINO ID'#13#10 //
    + '  FROM IMPORT_PROD_REJEICAO IPRO'#13#10 //
    + ')'#13#10 //
    + ', REJ AS'#13#10 //
    + '('#13#10 //
    + 'SELECT REJ_ORI.ID FROM REJ_ORI'#13#10 //
    + 'UNION DISTINCT'#13#10 //
    + 'SELECT REJ_DEST.ID FROM REJ_DEST'#13#10 //
    + ')'#13#10 //
    + 'select'#13#10 //
    + ' ip.import_prod_id'#13#10 // 0
    + ', ip.vai_importar'#13#10 //
    + ', ip.PROD_ID'#13#10 //
    + ', ip.DESCR'#13#10 //
    + ', ip.DESCR_RED'#13#10 //
    + ', ip.NOVO_DESCR'#13#10 // 5
    + ', ip.NOVO_DESCR_RED'#13#10 //
    + ', ifa.IMPORT_FABR_ID'#13#10 //
    + ', ifa.NOME fabr_nome'#13#10 //
    + ', it.IMPORT_PROD_TIPO_ID'#13#10 //
    + ', it.DESCR tipo_descr'#13#10 // 10
    + ', iu.IMPORT_UNID_ID'#13#10 //
    + ', iu.unid_sigla'#13#10 //
    + ', ii.IMPORT_ICMS_ID'#13#10 //
    + ', ii.ICMS_PERC_DESCR'#13#10 //
    + ', ip.CAPAC_EMB'#13#10 // 15
    + ', ip.NCM'#13#10 //
    + ', ip.CUSTO'#13#10 //
    + ', ipr.PRECO'#13#10 //
    + ', ip.ATIVO'#13#10 //
    + ', ip.LOCALIZ'#13#10 // 20
    + ', ip.MARGEM'#13#10 //
    + ', ip.BAL_USO'#13#10 //
    + ', ip.BAL_DPTO'#13#10 //
    + ', ib.COD_BARRAS'#13#10 // 24

    + 'from import_prod ip'#13#10 //

    + 'join import_fabr ifa on'#13#10 //
    + 'ip.import_fabr_id=ifa.import_fabr_id'#13#10 //

    + 'join import_prod_tipo it on'#13#10 //
    + 'ip.import_prod_tipo_id=it.import_prod_tipo_id'#13#10 //

    + 'join import_unid iu on'#13#10 //
    + 'ip.import_unid_id=iu.import_unid_id'#13#10 //

    + 'join import_icms ii on'#13#10 //
    + 'ip.import_icms_id=ii.import_icms_id'#13#10 //

    + 'join import_prod_preco ipr on'#13#10 //
    + 'ip.import_prod_id=ipr.import_prod_id'#13#10 //

    + 'join import_prod_barras ib on'#13#10 //
    + 'ip.import_prod_id=ib.import_prod_id'#13#10 //

    ;

  WhereStr := '';
  case SelStatus of
    selSelecionados:
      begin
        if WhereStr <> '' then
          WhereStr := WhereStr + ' and ';
        WhereStr := '(ip.vai_importar)'#13#10;
      end;
    selNaoSelecionados:
      begin
        if WhereStr <> '' then
          WhereStr := WhereStr + ' and ';
        WhereStr := '(not ip.vai_importar)'#13#10;
      end;
  end;

  case ConfStatus of
    confRejeitados:
      begin
        sSql := sSql + 'JOIN rej ON'#13#10 //
          + 'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
    confAceitos:
      begin
        if WhereStr <> '' then
          WhereStr := WhereStr + ' and ';
        WhereStr := WhereStr + ' (rej.id is NULL)';
        sSql := sSql + 'LEFT JOIN rej ON'#13#10 //
          + 'ip.import_prod_id=rej.id'#13#10 //
          ;
      end;
  end;
  if WhereStr <> '' then
    sSql := sSql + 'WHERE ' + WhereStr + #13#10;

  sSql := sSql + 'ORDER BY ip.import_prod_id'#13#10; //
  SetClipboardText(sSql);
  // DestinoDBConnection.Abrir;
  ProdFDMemTable.DisableControls;
  try
    ProdFDMemTable.EmptyDataSet;
    DestinoDBConnection.QueryDataSet(sSql, q);
    try
      iIdAnt := -1;
      sBarCodes := '';
      while not q.Eof do
      begin
        iIdAtu := q.Fields[0].AsInteger;
        if iIdAnt <> iIdAtu then
        begin
          if ProdFDMemTable.State <> dsBrowse then
          begin
            ProdFDMemTable.Fields[24].AsString := sBarCodes;
            ProdFDMemTable.Post;
            sBarCodes := '';
          end;
          ProdFDMemTable.Append;
          QueryToFDMemTable(ProdFDMemTable, q);
          if sBarCodes <> '' then
            sBarCodes := sBarCodes + ',';
          sBarCodes := sBarCodes + Trim(q.Fields[24].AsString);
          iIdAnt := iIdAtu;
        end
        else
        begin
          if sBarCodes <> '' then
            sBarCodes := sBarCodes + ',';
          sBarCodes := sBarCodes + Trim(q.Fields[24].AsString);
        end;

        q.Next;
      end;
      if ProdFDMemTable.State <> dsBrowse then
      begin
        ProdFDMemTable.Fields[24].AsString := sBarCodes;
        ProdFDMemTable.Post;
      end;
    finally
      q.Free;
    end
  finally
    CarregarRej;
    DestinoDBConnection.Fechar;
    ProdFDMemTable.First;
    ProdFDMemTable.EnableControls;
  end
end;

procedure TDBImportForm.CarregarRej;
var
  sSql: string;
  q: TDataSet;
  I: integer;
begin
  // inherited;
  sSql := 'SELECT'#13#10 + '  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10 +
    '  r.IMPORT_PROD_REJEICAO_ID_DESTINO,'#13#10 + '  t.DESCR'#13#10 +
    'FROM IMPORT_PROD_REJEICAO r'#13#10 + 'JOIN IMPORT_REJEICAO_TIPO t ON'#13#10
    + 'r.IMPORT_REJEICAO_TIPO_ID = t.IMPORT_REJEICAO_TIPO_ID'#13#10
  // +'WHERE r.IMPORT_PROD_REJEICAO_ID_ORIGEM = :IMPORT_PROD_ID'#13#10
  // +'   OR r.IMPORT_PROD_REJEICAO_ID_DESTINO = :IMPORT_PROD_ID;'#13#10
    + 'ORDER BY'#13#10 + '  r.IMPORT_PROD_REJEICAO_ID_ORIGEM,'#13#10 +
    '  r.IMPORT_PROD_REJEICAO_ID_DESTINO'#13#10;

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

  sNomeArq := GetNomeArqTabViewProd;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdFDMemTable, ProdDBGrid);

  FProdRejFDMemTable := TFDMemTable.Create(Self);
  FProdRejFDMemTable.Name := ClassName + 'ProdRejFDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;

  sNomeArq := GetNomeArqTabViewRej;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdRejFDMemTable,
    RejeicaoDBGrid);

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

procedure TDBImportForm.FIlConfComboBoxChange(Sender: TObject);
begin
  inherited;
  AtualizarAction_AppDBImport.Execute;
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

procedure TDBImportForm.RejEdAction_AppDBImportExecute(Sender: TObject);
var
  bResultado: boolean;
  oIntegerList: IIntegerList;
begin
  // inherited;
  oIntegerList := IntegerListCreate;
  oIntegerList.AceitaRepetidos := False;

  RejPreencherIntegerList(oIntegerList);

  bResultado := App.DB.Import.Prod.Rej.Ed.Form_u.Perg(Self, AppObj,//
    FDestinoDBConnection,//

    FProdFDMemTable,//
    ProdRejFDMemTable,//

    oIntegerList, Usuario, ProcessLog,//
    FStatusOutput);//

  if not bResultado then
    exit;
  ValidarAction_AppDBImport.Execute;
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
      if (FProdRejFDMemTable.Fields[0].AsInteger = iIdAtual)
        or (FProdRejFDMemTable.Fields[1].AsInteger = iIdAtual)
        then
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
    + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10 //
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
    + '        WHEN NOVO_DESCR IS NULL OR NOVO_DESCR = '''' THEN DESCR'#13#10 //
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

  DestinoDBConnection.Abrir;
  DestinoDBConnection.ExecuteSQL('DELETE FROM IMPORT_PROD_REJEICAO;');

  ProgressBar1.Position := 0;
  ProgressBar1.Visible := true;
  try
    QtdRegs := DestinoDBConnection.GetValueInteger(sSqlQtd);
    ProgressBar1.Max := QtdRegs;

    SetClipboardText(sSqlDest);
    DestDBQuery := DBQueryCreate('Config.Import.Prod.Rejeicao.Q',
      DestinoDBConnection, sSqlDest, ProcessLog, StatusOutput);
    DestDBQuery.Prepare;

    InsDBExec := DBExecCreate('Config.Import.Prod.Rejeicao.Ins',
      DestinoDBConnection, sSqlInsRej, ProcessLog, StatusOutput);
    InsDBExec.Prepare;

    SetClipboardText(sSqlOrig);
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
          end;

          InsDBExec.Execute;

          if OrigQ.Fields[4].AsString = DestDBQuery.DataSet.Fields[4].AsString
          then
          begin
            RejeicaoTipoId := 2;
            InsDBExec.Params[0].AsInteger := RejeicaoIdOrigem;
            InsDBExec.Params[1].AsInteger := RejeicaoIdDestino;
            InsDBExec.Params[2].AsInteger := RejeicaoTipoId;
          end;

          InsDBExec.Execute;
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
  Result := true;
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
    Result := true;
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

unit App.DB.Import.Prod.Rej.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Sis.UI.IO.Factory, Sis.DB.DBTypes, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.FDDataSetManager,
  App.AppObj, Sis.UI.IO.Output.ProcessLog, Vcl.ComCtrls, Sis.Usuario,
  Sis.UI.IO.Output.ProcessLog.Factory, Sis.DB.DataSet.Utils, Sis.UI.IO.Output,
  Sis.Lists.IntegerList, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf;

type
  TProdRejEdForm = class(TDiagBtnBasForm)
    ProdDBGrid: TDBGrid;
    ProdDataSource: TDataSource;
    FDMemTable1: TFDMemTable;
    FDMemTable1id: TIntegerField;
    FDMemTable1descr: TStringField;

    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure ProdDBGridColEnter(Sender: TObject);
    procedure ProdDBGridEditButtonClick(Sender: TObject);

    procedure FDMemTable1descrValidate(Sender: TField);
    procedure FDMemTable1descrSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
    FFDMemTable: TFDMemTable;
    FAppObj: IAppObj;
    FDBConnection: IDBConnection;
    FUsuario: IUsuario;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FProdFDMemTable: TFDMemTable;
    FProdRejFDMemTable: TFDMemTable;
    FIdsIntegerList: IIntegerList;
    FColEditavelIntegerList: IIntegerList;
    FIndexNovoDescr: integer;
    FIndexNovoDescrRed: integer;
    FIndexNovoCusto: integer;
    FIndexNovoPreco: integer;
    FIndexNovoBarras: integer;

    function GetNomeArqTabView: string;
    procedure DefCampos;
    procedure ImportarProds;
    procedure TrazerReg;
    function ColEditavel(pSelectedIndex: integer): boolean;

    procedure FFDMemTableNovoDescrSetText(Sender: TField; const Text: string);
  protected
    property FDMemTable: TFDMemTable read FFDMemTable;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; //
      pDBConnection: IDBConnection; //

      pProdFDMemTable: TFDMemTable; //
      pProdRejFDMemTable: TFDMemTable; //

      pIdsIntegerList: IIntegerList; //
      pUsuario: IUsuario; pProcessLog: IProcessLog = nil; //
      pOutput: IOutput = nil); //
  end;

function Perg(AOwner: TComponent; pAppObj: IAppObj; //
  pDBConnection: IDBConnection; //

  pProdFDMemTable: TFDMemTable; //
  pProdRejFDMemTable: TFDMemTable; //

  pIdsIntegerList: IIntegerList; //
  pUsuario: IUsuario; pProcessLog: IProcessLog = nil; //
  pOutput: IOutput = nil): boolean;

var
  ProdRejEdForm: TProdRejEdForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory, Sis.Lists.Factory, Sis.Types.strings_u,
  Sis.UI.Controls.TDBGrid, App.DB.Import.Prod.BarrasList.Ed.Form_u,
  Sis.UI.Controls.Utils;

function Perg(AOwner: TComponent; pAppObj: IAppObj; //
  pDBConnection: IDBConnection; //

  pProdFDMemTable: TFDMemTable; //
  pProdRejFDMemTable: TFDMemTable; //

  pIdsIntegerList: IIntegerList; //
  pUsuario: IUsuario; pProcessLog: IProcessLog; //
  pOutput: IOutput): boolean;
begin
  ProdRejEdForm := TProdRejEdForm.Create(AOwner, pAppObj, pDBConnection, //
    pProdFDMemTable, //
    pProdRejFDMemTable, //

    pIdsIntegerList, pUsuario, pProcessLog, pOutput); //
  Result := ProdRejEdForm.Perg;
end;

{ TProdRejEdForm }

function TProdRejEdForm.ColEditavel(pSelectedIndex: integer): boolean;
var
  iIndex: integer;
  s: string;
begin
  iIndex := FColEditavelIntegerList.ValueToIndex(pSelectedIndex);
  s := FColEditavelIntegerList.AsStringCSV;
  Result := iIndex > -1;
end;

constructor TProdRejEdForm.Create(AOwner: TComponent; pAppObj: IAppObj; //
  pDBConnection: IDBConnection; //

  pProdFDMemTable: TFDMemTable; //
  pProdRejFDMemTable: TFDMemTable; //

  pIdsIntegerList: IIntegerList; //
  pUsuario: IUsuario; pProcessLog: IProcessLog; //
  pOutput: IOutput);
var
  sNomeArq: string;
  ScreenWidth, ScreenHeight: integer;
  oColumn: TColumn;
  oField: TField;
begin
  inherited Create(AOwner);
  ScreenWidth := Screen.WorkAreaWidth;
  ScreenHeight := Screen.WorkAreaHeight;

  Self.Width := ScreenWidth - 40;
  Self.Height := ScreenHeight div 2;

  FUsuario := pUsuario;
  FProdFDMemTable := pProdFDMemTable;
  FProdRejFDMemTable := pProdRejFDMemTable;
  FIdsIntegerList := pIdsIntegerList;

  if pProcessLog = nil then
    FProcessLog := MudoProcessLogCreate
  else
    FProcessLog := pProcessLog;

  FAppObj := pAppObj;

  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  // FFDMemTable.AfterScroll := FDMemTable1AfterScroll;

  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, ProdDBGrid);

  oColumn := DBGridColumnByFieldName(ProdDBGrid, 'novo_descr');
  FIndexNovoDescr := oColumn.Index;
  oField := oColumn.Field;
  oField.OnSetText := FFDMemTableNovoDescrSetText;

  oColumn := DBGridColumnByFieldName(ProdDBGrid, 'novo_descr_red');
  FIndexNovoDescrRed := oColumn.Index;
  oField := oColumn.Field;
  oField.OnSetText := FFDMemTableNovoDescrSetText;

  oColumn := DBGridColumnByFieldName(ProdDBGrid, 'novo_custo');
  FIndexNovoCusto := oColumn.Index;
  oField := oColumn.Field;

  oColumn := DBGridColumnByFieldName(ProdDBGrid, 'novo_preco');
  FIndexNovoPreco := oColumn.Index;
  oField := oColumn.Field;

  oColumn := DBGridColumnByFieldName(ProdDBGrid, 'novo_codbarras');
  FIndexNovoBarras := oColumn.Index;
  oField := oColumn.Field;
  oColumn.ButtonStyle := TColumnButtonStyle.cbsEllipsis;

  ImportarProds;

  FColEditavelIntegerList := IntegerListCreate;
  FColEditavelIntegerList.Add(FIndexNovoDescr);
  FColEditavelIntegerList.Add(FIndexNovoDescrRed);
  FColEditavelIntegerList.Add(FIndexNovoCusto);
  FColEditavelIntegerList.Add(FIndexNovoPreco);
  FColEditavelIntegerList.Add(FIndexNovoBarras);

  {
    0	import_prod_id
    1	vai_importar
    2	PROD_ID
    3	DESCR
    4	DESCR_RED
    5	NOVO_DESCR//
    6	NOVO_DESCR_RED//
    7	IMPORT_FABR_ID
    8	FABR_NOME
    9	CUSTO
    10	novo_CUSTO//
    11	PRECO
    12	novo_PRECO
    13	codbarras
    14	novo_codbarras
  }
end;

procedure TProdRejEdForm.DefCampos;
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
    oFDDataSetManager := FDDataSetManagerCreate(FFDMemTable, ProdDBGrid);
    oFDDataSetManager.DefinaCampos(DefsSL);
  finally
    DefsSL.Free;
  end;
end;

procedure TProdRejEdForm.FDMemTable1descrSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  //
end;

procedure TProdRejEdForm.FDMemTable1descrValidate(Sender: TField);
begin
  inherited;
  //
end;

procedure TProdRejEdForm.FFDMemTableNovoDescrSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString := StrSemAcento(Text);
end;

function TProdRejEdForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\Config\Import\tabview.config.shop.import.prod.corrigir.ed.csv';

  Result := sNomeArq;
end;

procedure TProdRejEdForm.ImportarProds;
var
  i: integer;
  iId: integer;
  b: TBookmark;
  bResultado: boolean;
begin
  FProdFDMemTable.DisableControls;
  b := FProdFDMemTable.GetBookmark;
  try
    for i := 0 to FIdsIntegerList.Count - 1 do
    begin
      iId := FIdsIntegerList[i];
      bResultado := FProdFDMemTable.FindKey([iId]);
      if bResultado then
      begin
        TrazerReg;
      end;
    end;
  finally
    FProdFDMemTable.GotoBookmark(b);
    FProdFDMemTable.FreeBookmark(b);
    FProdFDMemTable.EnableControls;
  end;
end;

procedure TProdRejEdForm.ProdDBGridColEnter(Sender: TObject);
var
  bResultado: boolean;
begin
  inherited;
  bResultado := ColEditavel(ProdDBGrid.SelectedIndex);
  if bResultado then
  begin
    ProdDBGrid.Options := [dgEditing, dgAlwaysShowEditor, dgTitles,
      dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection,
      dgConfirmDelete, dgTitleClick, dgTitleHotTrack];
  end
  else
  begin
    ProdDBGrid.Options := [dgTitles, dgColumnResize, dgColLines, dgRowLines,
      dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgTitleClick,
      dgTitleHotTrack];
  end;
end;

procedure TProdRejEdForm.ProdDBGridEditButtonClick(Sender: TObject);
var
  sBarras, sNovoBarras: string;
  bResultado: boolean;
begin
  inherited;
  sBarras := FFDMemTable.Fields[FIndexNovoBarras - 1].AsString;
  sNovoBarras := FFDMemTable.Fields[FIndexNovoBarras].AsString;

  bResultado := App.DB.Import.Prod.BarrasList.Ed.Form_u.ImportBarrasEdPerg(sBarras,
    sNovoBarras);

  if not bResultado then
    exit;
end;

procedure TProdRejEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ProdDBGrid.SetFocus;
  ClearStyleElements(Self);
end;

procedure TProdRejEdForm.TrazerReg;
begin
  FFDMemTable.Append;
  FFDMemTable.Fields[0].Value := FProdFDMemTable.Fields[0].Value;
  // 0	import_prod_id 0
  FFDMemTable.Fields[1].Value := FProdFDMemTable.Fields[1].Value;
  // 1	vai_importar 1
  FFDMemTable.Fields[2].Value := FProdFDMemTable.Fields[2].Value;
  // 2	PROD_ID 2
  FFDMemTable.Fields[3].Value := FProdFDMemTable.Fields[3].Value; // 3	DESCR 3
  FFDMemTable.Fields[4].Value := FProdFDMemTable.Fields[4].Value;
  // 4	DESCR_RED 4
  FFDMemTable.Fields[5].Value := FProdFDMemTable.Fields[5].Value;
  // 5	NOVO_DESCR 5
  FFDMemTable.Fields[6].Value := FProdFDMemTable.Fields[6].Value;
  // 6	NOVO_DESCR_RED 6
  FFDMemTable.Fields[7].Value := FProdFDMemTable.Fields[7].Value;
  // 7	IMPORT_FABR_ID 7
  FFDMemTable.Fields[8].Value := FProdFDMemTable.Fields[8].Value;
  // 8	FABR_NOME 8
  FFDMemTable.Fields[9].Value := FProdFDMemTable.Fields[17].Value;
  // 9	codbarras 24
  FFDMemTable.Fields[10].Value := FProdFDMemTable.Fields[18].Value;
  // 9	codbarras 24
  FFDMemTable.Fields[11].Value := FProdFDMemTable.Fields[19].Value;
  // 9	codbarras 24
  FFDMemTable.Fields[12].Value := FProdFDMemTable.Fields[20].Value;
  // 9	codbarras 24
  FFDMemTable.Fields[13].Value := FProdFDMemTable.Fields[26].Value;
  // 9	codbarras 24
  FFDMemTable.Fields[14].Value := FProdFDMemTable.Fields[27].Value;
  // 9	codbarras 24
  FFDMemTable.Post;
end;

end.

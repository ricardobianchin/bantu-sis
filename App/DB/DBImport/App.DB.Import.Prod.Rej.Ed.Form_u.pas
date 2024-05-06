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
  Sis.Lists.IntegerList, Vcl.Grids, Vcl.DBGrids;

type
  TProdRejEdForm = class(TDiagBtnBasForm)
    ProdDBGrid: TDBGrid;
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

    function GetNomeArqTabView: string;
    procedure DefCampos;
    procedure ImportarProds;
    procedure TrazerReg;
  protected
    property FDMemTable: TFDMemTable read FFDMemTable;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;//
      pDBConnection: IDBConnection;//

      pProdFDMemTable: TFDMemTable;//
      pProdRejFDMemTable: TFDMemTable;//

      pIdsIntegerList: IIntegerList;//
      pUsuario: IUsuario; pProcessLog: IProcessLog = nil;//
      pOutput: IOutput = nil);//
  end;

function Perg(AOwner: TComponent; pAppObj: IAppObj;//
      pDBConnection: IDBConnection;//

      pProdFDMemTable: TFDMemTable;//
      pProdRejFDMemTable: TFDMemTable;//

      pIdsIntegerList: IIntegerList;//
      pUsuario: IUsuario; pProcessLog: IProcessLog = nil;//
      pOutput: IOutput = nil): boolean;

var
  ProdRejEdForm: TProdRejEdForm;

implementation

{$R *.dfm}

uses Sis.DB.Factory;

function Perg(AOwner: TComponent; pAppObj: IAppObj;//
      pDBConnection: IDBConnection;//

      pProdFDMemTable: TFDMemTable;//
      pProdRejFDMemTable: TFDMemTable;//

      pIdsIntegerList: IIntegerList;//
      pUsuario: IUsuario; pProcessLog: IProcessLog;//
      pOutput: IOutput): boolean;
begin
  ProdRejEdForm := TProdRejEdForm.Create(AOwner, pAppObj, pDBConnection,//
    pProdFDMemTable,//
    pProdRejFDMemTable,//

    pIdsIntegerList, pUsuario, pProcessLog, pOutput);//
  Result := ProdRejEdForm.Perg;
end;
{ TProdRejEdForm }

constructor TProdRejEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;//
      pDBConnection: IDBConnection;//

      pProdFDMemTable: TFDMemTable;//
      pProdRejFDMemTable: TFDMemTable;//

      pIdsIntegerList: IIntegerList;//
      pUsuario: IUsuario; pProcessLog: IProcessLog;//
      pOutput: IOutput);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
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
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, nil);

  ImportarProds;
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
  I: integer;
  iId: integer;
  b: TBookmark;
  bResultado: boolean;
begin
  FProdFDMemTable.DisableControls;
  b := FProdFDMemTable.GetBookmark;
  try
  for I := 0 to FIdsIntegerList.Count - 1 do
  begin
    iId := FIdsIntegerList[I];
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

procedure TProdRejEdForm.TrazerReg;
begin
  FFDMemTable.Append;
  FFDMemTable.Fields[0].Value := FProdFDMemTable.Fields[0].Value;//0	import_prod_id 0
  FFDMemTable.Fields[1].Value := FProdFDMemTable.Fields[1].Value;//1	vai_importar 1
  FFDMemTable.Fields[2].Value := FProdFDMemTable.Fields[2].Value;//2	PROD_ID 2
  FFDMemTable.Fields[3].Value := FProdFDMemTable.Fields[3].Value;//3	DESCR 3
  FFDMemTable.Fields[4].Value := FProdFDMemTable.Fields[4].Value;//4	DESCR_RED 4
  FFDMemTable.Fields[5].Value := FProdFDMemTable.Fields[5].Value;//5	NOVO_DESCR 5
  FFDMemTable.Fields[6].Value := FProdFDMemTable.Fields[6].Value;//6	NOVO_DESCR_RED 6
  FFDMemTable.Fields[7].Value := FProdFDMemTable.Fields[7].Value;//7	IMPORT_FABR_ID 7
  FFDMemTable.Fields[8].Value := FProdFDMemTable.Fields[8].Value;//8	FABR_NOME 8
  FFDMemTable.Fields[9].Value := FProdFDMemTable.Fields[24].Value;//9	codbarras 24
  FFDMemTable.Post;
end;

end.

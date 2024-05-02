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
  Sis.Lists.IntegerList;

type
  TProdRejEdForm = class(TDiagBtnBasForm)
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
    oFDDataSetManager := FDDataSetManagerCreate(FFDMemTable, nil);
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

end.

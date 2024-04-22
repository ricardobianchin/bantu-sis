unit App.DB.Import.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.IO.Output,
  Sis.UI.IO.Factory, App.DB.Import.Origem, App.DB.Import, Sis.DB.DBTypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Sis.DB.FDDataSetManager, App.AppObj;

type
  TDBImportForm = class(TBasForm)
    TopoPanel: TPanel;
    BasePanel: TPanel;
    MeioPanel: TPanel;
    StatusMemo: TMemo;
    GridsPanel: TPanel;
    ProdDBGrid: TDBGrid;
    ProdDataSource: TDataSource;
  private
    { Private declarations }
    FStatusOutput: IOutput;
    FDBImport: IDBImport;
    FDBImportOrigem: IDBImportOrigem;
    FProdFDMemTable: TFDMemTable;
    FAppObj: IAppObj;
  protected
    property StatusOutput: IOutput read FStatusOutput write FStatusOutput;
    property DBImport: IDBImport read FDBImport write FDBImport;
    property DBImportOrigem: IDBImportOrigem read FDBImportOrigem
      write FDBImportOrigem;
    procedure DefCampos; virtual;
    function GetNomeArqTabViewProd: string; virtual;
    property ProdFDMemTable: TFDMemTable read FProdFDMemTable;
    property AppObj: IAppObj read FAppObj;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
  end;

var
  DBImportForm: TDBImportForm;

implementation

{$R *.dfm}

uses Sis.DB.DataSet.Utils;

{ TDBImportForm }

constructor TDBImportForm.Create(AOwner: TComponent; pAppObj: IAppObj);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FProdFDMemTable := TFDMemTable.Create(Self);
  FProdFDMemTable.Name := ClassName + 'ProdFDMemTable';
//  FFDMemTable.AfterScroll := FDMemTable1AfterScroll;
  sNomeArq := GetNomeArqTabViewProd;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FProdFDMemTable, ProdDBGrid);
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
    oFDDataSetManager := FDDataSetManagerCreate(FFDMemTable, DBGrid1);
    oFDDataSetManager.DefinaCampos(DefsSL);
  finally
    DefsSL.Free;
  end;
end;

function TDBImportForm.GetNomeArqTabViewProd: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.tipo.csv';

  Result := sNomeArq;
end;

end.

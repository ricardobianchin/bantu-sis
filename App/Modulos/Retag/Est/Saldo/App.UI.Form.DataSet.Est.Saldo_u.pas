unit App.UI.Form.DataSet.Est.Saldo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin,
  Sis.Usuario, Sis.DB.DBTypes, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed, App.Ent.DBI,
  App.UI.TabSheet.DataSet.Types_u, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, App.AppObj, Vcl.StdCtrls, App.Retag.Est.Saldo.DBI,
  App.Retag.Est.Saldo.Ent, System.Generics.Collections,
  App.UI.Form.DataSet.Est.Saldo_u_HistProdFormList;

type
  TRetagSaldoDataSetForm = class(TTabSheetDataSetBasForm)
    ProdHistAction_RetagSaldoDataSetForm: TAction;
    ProdHistsFecharAction_RetagSaldoDataSetForm: TAction;
    procedure ProdHistAction_RetagSaldoDataSetFormExecute(Sender: TObject);
    procedure ProdHistsFecharAction_RetagSaldoDataSetFormExecute
      (Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FRetagSaldoEnt: IRetagSaldoEnt;
    FRetagSaldoDBI: IRetagSaldoDBI;
    FPROD_IDField: TField;
    FDESCR_REDField: TField;
    FHistProdFormList: IHistProdFormList;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure DoCloseHistForm(pProdId: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  RetagSaldoDataSetForm: TRetagSaldoDataSetForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.Controls.TDBGrid,
  App.Acesso.PerfilDeUso.UI.Factory_u, Sis.UI.ImgDM, Sis.Types;

{ TRetagSaldoDataSetForm }

constructor TRetagSaldoDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pModoDataSetForm,
    pIdPos, pAppObj);

  FRetagSaldoEnt := EntEdCastToRetagSaldoEnt(pEntEd);
  FPROD_IDField := FDMemTable.FindField('PROD_ID');
  FDESCR_REDField := FDMemTable.FindField('DESCR_RED');

  FHistProdFormList := HistProdFormListCreate;
end;

procedure TRetagSaldoDataSetForm.DBGrid1DblClick(Sender: TObject);
begin
  // inherited;
  ProdHistAction_RetagSaldoDataSetForm.Execute;
end;

procedure TRetagSaldoDataSetForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(0 { EstFiltroFrame.Values } , LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
    // DetailCarregar;
  end;
end;

procedure TRetagSaldoDataSetForm.DoCloseHistForm(pProdId: integer);
begin
  if not Assigned(FHistProdFormList) then
    exit;
  try
    FHistProdFormList.RemoveByProdId(pProdId);
  except

  end;
end;

procedure TRetagSaldoDataSetForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ProdHistsFecharAction_RetagSaldoDataSetForm.Execute;
  inherited;

end;

function TRetagSaldoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Saldo\tabview.est.saldo.csv';
  Result := sNomeArq;
end;

procedure TRetagSaldoDataSetForm.ProdHistAction_RetagSaldoDataSetFormExecute
  (Sender: TObject);
var
  i: integer;
  iProdId: TId;
  sDescr: string;
  Form: TForm;
begin
  inherited;
  iProdId := FPROD_IDField.AsInteger;
  sDescr := FDESCR_REDField.AsString;

  i := FHistProdFormList.FindIndexByProdId(iProdId);
  if i > -1 then
  begin
    FHistProdFormList.BringToFront(iProdId);
    exit;
  end;

  Form := EstSaldoHistProdFormCreate(Self, DoCloseHistForm, iProdId,
    sDescr, AppObj);
  FHistProdFormList.AddRecord(iProdId, Form);
  Form.Show;
end;

procedure TRetagSaldoDataSetForm.
  ProdHistsFecharAction_RetagSaldoDataSetFormExecute(Sender: TObject);
begin
  inherited;
  FHistProdFormList.FecheForms;
end;

procedure TRetagSaldoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ProdHistAction_RetagSaldoDataSetForm,
    TitToolBar1_BasTabSheet);
  ToolBarAddButton(ProdHistsFecharAction_RetagSaldoDataSetForm,
    TitToolBar1_BasTabSheet);

end;

end.

unit App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppObj,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.Filtro.BuscaString_u, Sis.Usuario,
  Sis.UI.IO.Output, App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Fabr.Ent,
  Sis.UI.ImgDM, App.Ent.Ed, App.UI.TabSheet.DataSet.Types_u;

type
  TRetagEstProdFabrDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ExclAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CrieFiltroFrame;
    function GetProdFabrEnt: IProdFabrEnt;
    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer; pStrBuscaInicial: string;
      pAppObj: IAppObj); override;
  end;

var
  RetagEstProdFabrDataSetForm: TRetagEstProdFabrDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Fabr.Ent_u;

{ TFabricanteTabSheetDataSetForm }

procedure TRetagEstProdFabrDataSetForm.DoAlterar;
var
  Resultado: boolean;
begin
  Resultado := ProdFabrPerg(Self, AppObj, EntEd, EntDBI { oFabrDBI } );
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := ProdFabrEnt.Descr;
  FDMemTable.Post;
end;

procedure TRetagEstProdFabrDataSetForm.DoAtualizar(Sender: TObject);
// var
// Resultado: boolean;
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(FiltroFrame.Values, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdFabrDataSetForm.DoInserir: boolean;
begin
  inherited;
  Result := ProdFabrPerg(Self, AppObj, EntEd, EntDBI { oFabrDBI } );

  if not Result then
    exit;

  FDMemTable.InsertRecord([ProdFabrEnt.Id, ProdFabrEnt.Descr]);
end;

constructor TRetagEstProdFabrDataSetForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pStrBuscaInicial: string; pAppObj: IAppObj);
begin
  inherited;
end;

procedure TRetagEstProdFabrDataSetForm.CrieFiltroFrame;
var
  iIndexUltimoBotao: integer;
  l, w: integer;
  oToolB: TToolBar;
begin
  if Assigned(FiltroFrame) then
    exit;

  // FFiltroStringFrame
  oToolB := TitToolBar1_BasTabSheet;
  FiltroFrame := TFiltroStringFrame.Create(oToolB, DoAtualizar);
  FiltroFrame.Parent := oToolB;

  iIndexUltimoBotao := oToolB.ButtonCount - 1;

  if iIndexUltimoBotao > -1 then
  begin
    l := oToolB.ControlCount;
    l := oToolB.Buttons[iIndexUltimoBotao].Left;
    w := oToolB.Buttons[iIndexUltimoBotao].Width;
    FiltroFrame.Left := l + w;
  end
  else
    FiltroFrame.Left := 0;
end;

procedure TRetagEstProdFabrDataSetForm.ExclAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  Resultado: boolean;
  oDecoratorExcl: IDecoratorExcl;
  oFabr: IEntIdDescr;
begin
  inherited;
  exit;
  // if ExclExecutando then
  // exit;
  // ExclExecutando := true;
  // Resultado := False;
  // try
  //
  // if FDMemTable.IsEmpty then
  // begin
  // outputnotify.exibir('Não há registros a excluir');
  // exit;
  // end;
  //
  // oFabr := RetagEstProdFabrCreate(dsEdit, FDMemTable.Fields[0].AsInteger,
  // FDMemTable.Fields[1].AsString);
  //
  // oDecoratorExcl := DecoratorExclFabrCreate(oFabr);
  // Resultado := ExclFormPerg(nil, oDecoratorExcl);
  // finally
  // ExclExecutando := False;
  // end;
end;

function TRetagEstProdFabrDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\tabview.est.prod.fabr.csv';

  Result := sNomeArq;
end;

function TRetagEstProdFabrDataSetForm.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := TProdFabrEnt(EntEd);
end;

procedure TRetagEstProdFabrDataSetForm.RecordToEnt;
begin
  inherited;
  ProdFabrEnt.Id := FDMemTable.Fields[0].AsInteger;
  ProdFabrEnt.Descr := FDMemTable.Fields[1].AsString;
end;

procedure TRetagEstProdFabrDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

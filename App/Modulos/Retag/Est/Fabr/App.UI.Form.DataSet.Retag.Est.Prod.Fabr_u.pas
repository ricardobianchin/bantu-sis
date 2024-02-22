unit App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Fabr.Ent;

type
  TRetagEstProdFabrDataSetForm = class(TTabSheetDataSetBasForm)
    procedure FormCreate(Sender: TObject);
    procedure ExclAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FFiltroParamsStringFrame: TFiltroParamsStringFrame;
    procedure CrieFiltroFrame;
    function GetProdFabrEnt: IProdFabrEnt;
    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure LeRegEInsere(q: TDataSet); override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdFabrDataSetForm: TRetagEstProdFabrDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Fabr.Ent_u;

{ TFabricanteTabSheetDataSetForm }

procedure TRetagEstProdFabrDataSetForm.DoAlterar;
var
  oFabrDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
  Resultado: boolean;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Fabr.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oFabrDBI := RetagEstProdFabrDBICreate(oConn, EntEd);

  Resultado := ProdFabrPerg(Self, EntEd, oFabrDBI);
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := ProdFabrEnt.Descr;
  FDMemTable.Post;
end;

procedure TRetagEstProdFabrDataSetForm.DoAtualizar(Sender: TObject);
var
  oFabrDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Fabr.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oFabrDBI := RetagEstProdFabrDBICreate(oConn, EntEd);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oFabrDBI.PreencherDataSet(FFiltroParamsStringFrame.Values, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdFabrDataSetForm.DoInserir: boolean;
var
  oFabrDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited;
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oDBConnection := DBConnectionCreate('Retag.Fabr.Ed.Ins.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oFabrDBI := RetagEstProdFabrDBICreate(oDBConnection, EntEd);

  Result := ProdFabrPerg(Self, EntEd, oFabrDBI);

  if not Result then
    exit;

  FDMemTable.InsertRecord([ProdFabrEnt.Id, ProdFabrEnt.Descr]);
end;

procedure TRetagEstProdFabrDataSetForm.CrieFiltroFrame;
var
  iIndexUltimoBotao: integer;
  l, w: integer;
  oToolB: TToolBar;
begin
  if Assigned(FFiltroParamsStringFrame) then
    exit;

  // FFiltroParamsStringFrame
  oToolB := TitToolBar1_BasTabSheet;
  FFiltroParamsStringFrame := TFiltroParamsStringFrame.Create(oToolB,
    DoAtualizar);
  FFiltroParamsStringFrame.Parent := oToolB;

  iIndexUltimoBotao := oToolB.ButtonCount - 1;

  if iIndexUltimoBotao > -1 then
  begin
    l := oToolB.ControlCount;
    l := oToolB.Buttons[iIndexUltimoBotao].Left;
    w := oToolB.Buttons[iIndexUltimoBotao].Width;
    FFiltroParamsStringFrame.Left := l + w;
  end
  else
    FFiltroParamsStringFrame.Left := 0;
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

procedure TRetagEstProdFabrDataSetForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFiltroParamsStringFrame := nil;
end;

function TRetagEstProdFabrDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.fabr.csv';

  Result := sNomeArq;
end;

function TRetagEstProdFabrDataSetForm.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := TProdFabrEnt(EntEd);
end;

procedure TRetagEstProdFabrDataSetForm.LeRegEInsere(q: TDataSet);
begin
  inherited;
  FDMemTable.InsertRecord([q.Fields[0].AsInteger, q.Fields[1].AsString]);
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

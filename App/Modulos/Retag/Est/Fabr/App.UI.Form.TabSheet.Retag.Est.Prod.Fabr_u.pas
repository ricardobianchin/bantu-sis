unit App.UI.Form.TabSheet.Retag.Est.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Retag.Est.Prod.Fabr, App.Retag.Est.Prod.Fabr.DBI, Sis.DB.DBTypes,
  App.UI.Decorator.Form.Excl;

type
  TRetagEstProdFabrTabSheetDataSetForm = class(TTabSheetDataSetBasForm)
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
    procedure AltAction_DatasetTabSheetExecute(Sender: TObject);
    procedure ExclAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FFiltroParamsStringFrame: TFiltroParamsStringFrame;
    AtuExecutando, InsExecutando, AltExecutando, ExclExecutando: boolean;
    procedure CrieFiltroFrame;
    procedure DoAtualizar(Sender: TObject);
  protected
    function GetNomeArqTabView: string; override;
    function GetTitulo: string; override;
    procedure ToolBar1CrieBotoes; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdFabrTabSheetDataSetForm: TRetagEstProdFabrTabSheetDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid;

{ TFabricanteTabSheetDataSetForm }

procedure TRetagEstProdFabrTabSheetDataSetForm.AltAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  oFabr: IProdFabr;
  oFabrDBI: IProdFabrDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  inherited;
  Resultado := False;
  if FDMemTable.IsEmpty then
  begin
    outputnotify.exibir('Não há registros a alterar');
    exit;
  end;

  if AltExecutando then
    exit;

  State := dsEdit;
  AltExecutando := true;
  try
    oFabr := RetagEstProdFabrCreate(dsEdit, FDMemTable.Fields[0].AsInteger,
      FDMemTable.Fields[1].AsString);

    oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
      AppInfo, SisConfig);

    oConn := DBConnectionCreate('Retag.Fabr.Ed.Alt.Conn', SisConfig, DBMS,
      oDBConnectionParams, ProcessLog, Output);

    oFabrDBI := RetagEstProdFabrDBICreate(oConn, oFabr);

    Resultado := ProdFabrPerg(Self, Titulo, dsEdit, oFabr, oFabrDBI);
    if not Resultado then
      exit;

  finally
    State := dsBrowse;
    DBGrid1.SetFocus;
    AltExecutando := False;
    if Resultado then
    begin
      FDMemTable.Edit;
      FDMemTable.Fields[1].AsString := oFabr.Descr;
      FDMemTable.Post;
    end;
  end;

end;

procedure TRetagEstProdFabrTabSheetDataSetForm.AtuAction_DatasetTabSheetExecute
  (Sender: TObject);
begin
  inherited;
  if State <> dsBrowse then
    exit;

  if AtuExecutando then
    exit;
  try
    AtuExecutando := true;

    DoAtualizar(Self);
  finally
    DBGrid1.SetFocus;
    AtuExecutando := False;
  end;
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.DoAtualizar(Sender: TObject);
var
  oFabr: IProdFabr;
  oFabrDBI: IProdFabrDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
begin
  oFabr := RetagEstProdFabrCreate(dsInsert);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Fabr.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oFabrDBI := RetagEstProdFabrDBICreate(oConn, oFabr);

  sBusca := FFiltroParamsStringFrame.BuscaString;

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oFabrDBI.PreencherDataSet(sBusca,
      procedure(q: TDataSet)
      begin
        FDMemTable.InsertRecord([q.Fields[0].AsInteger, q.Fields[1].AsString]);
      end);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.CrieFiltroFrame;
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

procedure TRetagEstProdFabrTabSheetDataSetForm.ExclAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  Resultado: boolean;
  oDecoratorExcl: IDecoratorExcl;
  oFabr: IProdFabr;
begin
  inherited;
  if ExclExecutando then
    exit;
  ExclExecutando := true;
  Resultado := False;
  try

    if FDMemTable.IsEmpty then
    begin
      outputnotify.exibir('Não há registros a excluir');
      exit;
    end;

    oFabr := RetagEstProdFabrCreate(dsEdit, FDMemTable.Fields[0].AsInteger,
      FDMemTable.Fields[1].AsString);

    oDecoratorExcl := DecoratorExclFabrCreate(oFabr);
    Resultado := ExclFormPerg(nil, oDecoratorExcl);
  finally
    ExclExecutando := False;
  end;
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFiltroParamsStringFrame := nil;
  AtuExecutando := False;
  InsExecutando := False;
  AltExecutando := False;
  ExclExecutando := False;
end;

function TRetagEstProdFabrTabSheetDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.fabr.csv';

  Result := sNomeArq;
end;

function TRetagEstProdFabrTabSheetDataSetForm.GetTitulo: string;
begin
  Result := 'Fabricantes';
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.InsAction_DatasetTabSheetExecute
  (Sender: TObject);
var
  oFabr: IProdFabr;
  oFabrDBI: IProdFabrDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  inherited;
  if InsExecutando then
    exit;
  Resultado := False;
  try
    InsExecutando := true;
    State := dsInsert;
    oFabr := RetagEstProdFabrCreate(dsInsert);

    oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
      AppInfo, SisConfig);

    oConn := DBConnectionCreate('Retag.Fabr.Ed.Ins.Conn', SisConfig, DBMS,
      oDBConnectionParams, ProcessLog, Output);

    oFabrDBI := RetagEstProdFabrDBICreate(oConn, oFabr);

    Resultado := ProdFabrPerg(Self, Titulo, dsInsert, oFabr, oFabrDBI);
    if not Resultado then
      exit;

  finally
    InsExecutando := False;
    State := dsBrowse;
    DBGrid1.SetFocus;
    if Resultado then
      AtuAction_DatasetTabSheet.Execute;
  end;
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.ShowTimer_BasFormTimer
  (Sender: TObject);
begin
  inherited;
  AtuAction_DatasetTabSheet.Execute;
  ExclAction_DatasetTabSheet.Execute;
end;

procedure TRetagEstProdFabrTabSheetDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

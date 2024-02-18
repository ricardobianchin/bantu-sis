unit App.UI.Form.TabSheet.Retag.Est.Prod.Tipo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Entidade.Ed.Id.Descr;

type
  TRetagEstProdTipoTabSheetDataSetForm = class(TTabSheetDataSetBasForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFiltroParamsStringFrame: TFiltroParamsStringFrame;
    procedure CrieFiltroFrame;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    function GetTitulo: string; override;
    procedure ToolBar1CrieBotoes; override;
    function GetNome: string; override;
    function GetNomeAbrev: string; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdTipoTabSheetDataSetForm: TRetagEstProdTipoTabSheetDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid;

procedure TRetagEstProdTipoTabSheetDataSetForm.CrieFiltroFrame;
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

procedure TRetagEstProdTipoTabSheetDataSetForm.DoAlterar;
var
  oProdTipo: IEntIdDescr;
  oProdTipoDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
  Resultado: boolean;
begin
  oProdTipo := RetagEstProdTipoCreate(State, FDMemTable.Fields[0].AsInteger, FDMemTable.Fields[1].AsString);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.ProdTipo.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdTipoDBI := RetagEstProdTipoDBICreate(oConn, oProdTipo);

  Resultado := ProdTipoPerg(Self, Titulo, dsEdit, oProdTipo, oProdTipoDBI);
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := oProdTipo.Descr;
  FDMemTable.Post;
end;

procedure TRetagEstProdTipoTabSheetDataSetForm.DoAtualizar(Sender: TObject);
var
  oProdTipo: IEntIdDescr;
  oProdTipoDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
begin
  oProdTipo := RetagEstProdTipoCreate(dsInsert);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.ProdTipo.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdTipoDBI := RetagEstProdTipoDBICreate(oConn, oProdTipo);

  sBusca := FFiltroParamsStringFrame.BuscaString;

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oProdTipoDBI.PreencherDataSetIdDescr(sBusca,
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

function TRetagEstProdTipoTabSheetDataSetForm.DoInserir: boolean;
var
  oProdTipo: IEntIdDescr;
  oProdTipoDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  inherited;
  oProdTipo := RetagEstProdTipoCreate(State);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.ProdTipo.Ed.Ins.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdTipoDBI := RetagEstProdTipoDBICreate(oConn, oProdTipo);

  Result := ProdTipoPerg(Self, Titulo, dsInsert, oProdTipo, oProdTipoDBI);

  if not Result then
    exit;

  FDMemTable.InsertRecord([oProdTipo.Id, oProdTipo.Descr]);
end;

procedure TRetagEstProdTipoTabSheetDataSetForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFiltroParamsStringFrame := nil;
end;

function TRetagEstProdTipoTabSheetDataSetForm.GetNome: string;
begin
  Result := 'Tipo de Produtos';
end;

function TRetagEstProdTipoTabSheetDataSetForm.GetNomeAbrev: string;
begin
  Result := 'ProdTipo';
end;

function TRetagEstProdTipoTabSheetDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.tipo.csv';

  Result := sNomeArq;
end;

function TRetagEstProdTipoTabSheetDataSetForm.GetTitulo: string;
begin
  Result := 'Tipos de Produtos';
end;

procedure TRetagEstProdTipoTabSheetDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

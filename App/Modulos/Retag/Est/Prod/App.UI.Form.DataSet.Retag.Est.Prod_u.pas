unit App.UI.Form.DataSet.Retag.Est.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Ent;

type
  TRetagEstProdDataSetForm = class(TTabSheetDataSetBasForm)
  private
    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;
    procedure EntToCampos;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RetagEstProdDataSetForm: TRetagEstProdDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Ent_u;

{ TRetagEstProdDataSetForm }

procedure TRetagEstProdDataSetForm.DoAlterar;
var
  oProdDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
  Resultado: boolean;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Prod.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdDBI := RetagEstProdDBICreate(oConn, EntEd);

  Resultado := ProdPerg(Self, EntEd, oProdDBI);
  if not Resultado then
    exit;

  FDMemTable.Edit;
  EntToCampos;
  FDMemTable.Post;
end;

procedure TRetagEstProdDataSetForm.DoAtualizar(Sender: TObject);
var
  oProdDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Prod.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdDBI := RetagEstProdDBICreate(oConn, EntEd);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oProdDBI.PreencherDataSet(0, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdDataSetForm.DoInserir: boolean;
var
  oProdDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited;
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oDBConnection := DBConnectionCreate('Retag.Prod.Ed.Ins.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oProdDBI := RetagEstProdDBICreate(oDBConnection, EntEd);

  Result := ProdPerg(Self, EntEd, oProdDBI);

  if not Result then
    exit;

  FDMemTable.Insert;
  FDMemTable.Fields[0].AsInteger := ProdEnt.Id;
  EntToCampos;
  FDMemTable.Post;
end;

procedure TRetagEstProdDataSetForm.EntToCampos;
begin
  FDMemTable.Fields[1].AsString := ProdEnt.Descr;
  FDMemTable.Fields[2].AsString := ProdEnt.DescrRed;
  FDMemTable.Fields[3].AsInteger := ProdEnt.FabrId;
  FDMemTable.Fields[4].AsString := ProdEnt.FabrNome;
end;

function TRetagEstProdDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.csv';

  Result := sNomeArq;
end;

function TRetagEstProdDataSetForm.GetProdEnt: IProdEnt;
begin
  Result := TProdEnt(EntEd);
end;

procedure TRetagEstProdDataSetForm.RecordToEnt;
begin
  inherited;
  ProdEnt.Id := FDMemTable.Fields[0].AsInteger;
  ProdEnt.Descr := FDMemTable.Fields[1].AsString;
  ProdEnt.DescrRed := FDMemTable.Fields[2].AsString;
  ProdEnt.FabrId := FDMemTable.Fields[3].AsInteger;
  ProdEnt.FabrNome := FDMemTable.Fields[4].AsString;
end;

procedure TRetagEstProdDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

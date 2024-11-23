unit App.UI.Form.DataSet.Retag.Est.Prod.Unid_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppObj,
  Vcl.StdCtrls, Sis.Types,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Unid.Ent;

type
  TRetagEstProdUnidDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    function GetProdUnidEnt: IProdUnidEnt;
    property ProdUnidEnt: IProdUnidEnt read GetProdUnidEnt;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
    function GetSelectItem: TSelectItem; override;
  end;

var
  RetagEstProdUnidDataSetForm: TRetagEstProdUnidDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Unid.Ent_u, Sis.Sis.Constants;

{ TRetagEstProdUnidDataSetForm }

procedure TRetagEstProdUnidDataSetForm.DoAlterar;
var
  oUnidDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
  Resultado: boolean;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oConn := DBConnectionCreate( 'Retag.Unid.Ed.Atu.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oUnidDBI := RetagEstProdUnidDBICreate(oConn, EntEd);

  Resultado := ProdUnidPerg(Self, AppObj, EntEd, oUnidDBI);
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := ProdUnidEnt.Descr;
  FDMemTable.Fields[2].AsString := ProdUnidEnt.Sigla;
  FDMemTable.Post;
end;

procedure TRetagEstProdUnidDataSetForm.DoAtualizar(Sender: TObject);
var
  oUnidDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oConn := DBConnectionCreate('Retag.Unid.Ed.Atu.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oUnidDBI := RetagEstProdUnidDBICreate(oConn, EntEd);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oUnidDBI.ForEach(0, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdUnidDataSetForm.DoInserir: boolean;
var
  oUnidDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  inherited;
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    AppObj);

  oDBConnection := DBConnectionCreate('Retag.Unid.Ed.Ins.Conn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, Output);

  oUnidDBI := RetagEstProdUnidDBICreate(oDBConnection, EntEd);

  Result := ProdUnidPerg(Self, AppObj, EntEd, oUnidDBI);

  if not Result then
    exit;

  FDMemTable.InsertRecord([ProdUnidEnt.Id, ProdUnidEnt.Descr, ProdUnidEnt.Sigla]);
end;

function TRetagEstProdUnidDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews + 'App\Retag\Est\tabview.est.prod.unid.csv';

  Result := sNomeArq;
end;

function TRetagEstProdUnidDataSetForm.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := TProdUnidEnt(EntEd);
end;

function TRetagEstProdUnidDataSetForm.GetSelectItem: TSelectItem;
var
  fPerc: currency;
  Descr: string;
begin
  Result.Id := FDMemTable.Fields[0].AsInteger;
  Result.Descr := FDMemTable.Fields[2].AsString;
end;

procedure TRetagEstProdUnidDataSetForm.RecordToEnt;
begin
  inherited;
  ProdUnidEnt.Id := FDMemTable.Fields[0].AsInteger;
  ProdUnidEnt.Descr := FDMemTable.Fields[1].AsString;
  ProdUnidEnt.Sigla := FDMemTable.Fields[2].AsString;
end;

procedure TRetagEstProdUnidDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

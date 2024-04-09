unit App.UI.Form.DataSet.Retag.Est.Prod.Tipo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Est.Prod.Tipo.Ent;

type
  TRetagEstProdTipoDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    function GetProdTipoEnt: IProdTipoEnt;
    property ProdTipoEnt: IProdTipoEnt read GetProdTipoEnt;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdTipoDataSetForm: TRetagEstProdTipoDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid, App.Retag.Est.Prod.Tipo.Ent_u;

{ TTipoicanteTabSheetDataSetForm }

procedure TRetagEstProdTipoDataSetForm.DoAlterar;
var
//  oTipoDBI: IEntDBI;
//  oDBConnectionParams: TDBConnectionParams;
//  oConn: IDBConnection;
//  sBusca: string;
  Resultado: boolean;
begin
//  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
//    AppInfo, SisConfig);
//
//  oConn := DBConnectionCreate('Retag.Tipo.Ed.Atu.Conn', SisConfig, DBMS,
//    oDBConnectionParams, ProcessLog, Output);
//
//  oTipoDBI := RetagEstProdTipoDBICreate(oConn, EntEd);

  Resultado := ProdTipoPerg(Self, EntEd,EntDBI{ oTipoDBI});
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := ProdTipoEnt.Descr;
  FDMemTable.Post;
end;

procedure TRetagEstProdTipoDataSetForm.DoAtualizar(Sender: TObject);
var
//  oTipoDBI: IEntDBI;
//  oDBConnectionParams: TDBConnectionParams;
//  oConn: IDBConnection;
  Resultado: boolean;
begin
//  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
//    AppInfo, SisConfig);
//
//  oConn := DBConnectionCreate('Retag.Tipo.Ed.Atu.Conn', SisConfig, DBMS,
//    oDBConnectionParams, ProcessLog, Output);
//
//  oTipoDBI := RetagEstProdTipoDBICreate(oConn, EntEd);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    //oTipoDBI.PreencherDataSet(0, LeRegEInsere);
    EntDBI.PreencherDataSet(0, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagEstProdTipoDataSetForm.DoInserir: boolean;
//var
//  oTipoDBI: IEntDBI;
//  oDBConnectionParams: TDBConnectionParams;
//  oDBConnection: IDBConnection;
begin
  inherited;
//  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
//    AppInfo, SisConfig);
//
//  oDBConnection := DBConnectionCreate('Retag.Tipo.Ed.Ins.Conn', SisConfig, DBMS,
//    oDBConnectionParams, ProcessLog, Output);
//
//  oTipoDBI := RetagEstProdTipoDBICreate(oDBConnection, EntEd);
//
  Result := ProdTipoPerg(Self, EntEd, EntDBI{oTipoDBI});

  if not Result then
    exit;

  FDMemTable.InsertRecord([ProdTipoEnt.Id, ProdTipoEnt.Descr]);
end;

function TRetagEstProdTipoDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.tipo.csv';

  Result := sNomeArq;
end;

function TRetagEstProdTipoDataSetForm.GetProdTipoEnt: IProdTipoEnt;
begin
  Result := TProdTipoEnt(EntEd);
end;

procedure TRetagEstProdTipoDataSetForm.RecordToEnt;
begin
  inherited;
  ProdTipoEnt.Id := FDMemTable.Fields[0].AsInteger;
  ProdTipoEnt.Descr := FDMemTable.Fields[1].AsString;
end;

procedure TRetagEstProdTipoDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

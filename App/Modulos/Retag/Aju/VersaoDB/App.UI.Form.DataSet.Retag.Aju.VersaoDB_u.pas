unit App.UI.Form.DataSet.Retag.Aju.VersaoDB_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl, App.Ent.Ed,
  App.Ent.Ed.Id.Descr, Sis.UI.FormCreator, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario;

type
  TRetagAjuVersaoDBDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure DoAtualizar(Sender: TObject); override;
    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
  public
    { Public declarations }
  end;

var
  RetagAjuVersaoDBDataSetForm: TRetagAjuVersaoDBDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, Sis.DB.Factory, App.DB.Utils,
  Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u, Sis.UI.Controls.TDBGrid,
  Sis.Types.Bool_u, App.Retag.Aju.Factory;

{ TRetagAjuVersaoDBDataSetForm }

procedure TRetagAjuVersaoDBDataSetForm.DoAtualizar(Sender: TObject);
var
  oVersaoDBDBI: IEntDBI;
  Resultado: boolean;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.VersaoDB.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oVersaoDBDBI := RetagAjuVersaoDBDBICreate(oConn, EntEd);

  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    oVersaoDBDBI.PreencherDataSet('', LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagAjuVersaoDBDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'App\Retag\Aju\tabview.aju.versaodb.csv';

  Result := sNomeArq;
end;

procedure TRetagAjuVersaoDBDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.

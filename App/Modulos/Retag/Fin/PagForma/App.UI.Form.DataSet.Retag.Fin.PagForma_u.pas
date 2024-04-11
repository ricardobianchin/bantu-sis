unit App.UI.Form.DataSet.Retag.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Fin.PagForma.Ent;

type
  TRetagFinPagFormaDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    function GetPagFormaEnt: IPagFormaEnt;
    property PagFormaEnt: IPagFormaEnt read GetPagFormaEnt;

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
  RetagFinPagFormaDataSetForm: TRetagFinPagFormaDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Fin.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, Sis.UI.Controls.TDBGrid;

{ TTabSheetDataSetBasForm1 }

procedure TRetagFinPagFormaDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TRetagFinPagFormaDataSetForm.DoAtualizar(Sender: TObject);
var
  Resultado: boolean;
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.PreencherDataSet(0, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TRetagFinPagFormaDataSetForm.DoInserir: boolean;
begin

end;

function TRetagFinPagFormaDataSetForm.GetNomeArqTabView: string;
begin

end;

function TRetagFinPagFormaDataSetForm.GetPagFormaEnt: IPagFormaEnt;
begin
  Result := EntEdCastToPagFormaEnt(EntEd);
end;

procedure TRetagFinPagFormaDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TRetagFinPagFormaDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.

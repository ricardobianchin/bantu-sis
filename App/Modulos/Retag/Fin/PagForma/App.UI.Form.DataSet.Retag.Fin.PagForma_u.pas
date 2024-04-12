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
    procedure EntToRecord; override;

    procedure LeRegEInsere(q: TDataSet; pRecNo: integer); override;
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

procedure TRetagFinPagFormaDataSetForm.EntToRecord;
begin
  FDMemTable.Fields[0 {forma_id}].AsInteger := PagFormaEnt.Id;
  FDMemTable.Fields[1 {forma_tipo_descr}].AsString := PagFormaEnt.PagFormaTipo.Descr;
  FDMemTable.Fields[2 {descr}].AsString := PagFormaEnt.Descr;
  FDMemTable.Fields[3 {descr_red}].AsString := PagFormaEnt.DescrRed;
  FDMemTable.Fields[4 {Para_Venda}].AsBoolean := PagFormaEnt.ParaVenda;
  FDMemTable.Fields[5 {Ativo}].AsBoolean := PagFormaEnt.Ativo;
end;

function TRetagFinPagFormaDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Fin\tabview.fin.pagforma.csv';

  Result := sNomeArq;
end;

function TRetagFinPagFormaDataSetForm.GetPagFormaEnt: IPagFormaEnt;
begin
  Result := EntEdCastToPagFormaEnt(EntEd);
end;

procedure TRetagFinPagFormaDataSetForm.LeRegEInsere(q: TDataSet;
  pRecNo: integer);
begin
  inherited;
  //o inherited dá conta
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

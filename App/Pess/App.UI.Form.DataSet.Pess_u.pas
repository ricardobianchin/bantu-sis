unit App.UI.Form.DataSet.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin;

type
  TAppPessDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoLer; override;
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
  AppPessDataSetForm: TAppPessDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.TDBGrid;

procedure TAppPessDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TAppPessDataSetForm.DoAtualizar(Sender: TObject);
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

function TAppPessDataSetForm.DoInserir: boolean;
begin

end;

procedure TAppPessDataSetForm.DoLer;
begin
  inherited;

end;

procedure TAppPessDataSetForm.EntToRecord;
begin
  inherited;

end;

function TAppPessDataSetForm.GetNomeArqTabView: string;
begin

end;

procedure TAppPessDataSetForm.LeRegEInsere(q: TDataSet; pRecNo: integer);
begin
  inherited;

end;

procedure TAppPessDataSetForm.RecordToEnt;
begin
  inherited;

end;

procedure TAppPessDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
end;

procedure TAppPessDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.

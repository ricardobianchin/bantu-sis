unit App.UI.Form.Bas.DataSet.Est_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin, Vcl.StdCtrls, App.UI.Frame.Bas.EstFiltro_u;

type
  TAppEstDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    FEstFiltroFrame: TEstFiltroFrame;

  protected
    procedure EstLeRegEInsere(q: TDataSet; pRecNo: integer); virtual; abstract;
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;
    function PergEd: boolean; virtual; abstract;

    procedure CrieFiltroFrame; virtual; abstract;
    procedure ToolBar1CrieBotoes; override;
    property EstFiltroFrame: TEstFiltroFrame read FEstFiltroFrame
      write FEstFiltroFrame;
  public
    { Public declarations }
  end;

var
  AppEstDataSetForm: TAppEstDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.TToolBar, Sis.UI.Controls.TDBGrid;

{ TAppEstDataSetForm }

procedure TAppEstDataSetForm.DoAlterar;
begin
  inherited;

end;

procedure TAppEstDataSetForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(EstFiltroFrame.Values, EstLeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
  end;
end;

function TAppEstDataSetForm.DoInserir: boolean;
begin
  Result := PergEd;

  if not Result then
    exit;

  FDMemTable.Append;
  EntToRecord;
  FDMemTable.Post;
end;

procedure TAppEstDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

end;

end.

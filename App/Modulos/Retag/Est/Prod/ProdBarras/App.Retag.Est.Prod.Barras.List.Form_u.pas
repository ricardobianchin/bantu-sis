unit App.Retag.Est.Prod.Barras.List.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, App.AppInfo,
  FireDAC.Comp.Client;

type
  TProdBarrasListForm = class(TForm)
    BasePanel: TPanel;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    NovoAction: TAction;
    ExclAction: TAction;
    OkAction: TAction;
    CancAction: TAction;
    ConsultarWebAction: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    procedure CancActionExecute(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
    procedure NovoActionExecute(Sender: TObject);
    procedure ExclActionExecute(Sender: TObject);
  private
    { Private declarations }
    FFDMemTable: TFDMemTable;
  public
    { Public declarations }
    property FDMemTable: TFDMemTable read FFDMemTable;
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo);
  end;

var
  ProdBarrasListForm: TProdBarrasListForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.DB.DataSet.Utils, App.UI.Form.Ed.Prod.Barras_u,
  Sis.UI.IO.Input.Perg;

procedure TProdBarrasListForm.CancActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

constructor TProdBarrasListForm.Create(AOwner: TComponent; pAppInfo: IAppInfo);
var
  sNomeArq: string;
begin
  sNomeArq := pAppInfo.PastaConsTabViews + 'Est\tabview.est.prod.barras.csv';
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, DBGrid1);
end;

procedure TProdBarrasListForm.ExclActionExecute(Sender: TObject);
begin
  if FDMemTable.IsEmpty then
  begin
    ShowMessage('Não há registro a excluir');
    exit;
  end;

  if not PergBool('Excluir o código de barras?') then
    exit;

  FDMemTable.Delete;
end;

procedure TProdBarrasListForm.NovoActionExecute(Sender: TObject);
var
  iOrdem: integer;
begin
  ProdBarrasEdForm := TProdBarrasEdForm.Create(nil);
  try
    if not ProdBarrasEdForm.Perg then
      exit;
    iOrdem := FDMemTable.RecordCount + 1;
    FDMemTable.Append;
    FDMemTable.Fields[0].AsInteger := iOrdem;
    FDMemTable.Fields[1].AsString := ProdBarrasEdForm.LabeledEdit1.Text;
    FDMemTable.Post;
  finally
    ProdBarrasEdForm.Free;
  end;

end;

procedure TProdBarrasListForm.OkActionExecute(Sender: TObject);
begin
  ModalResult := mrOk;

end;

end.

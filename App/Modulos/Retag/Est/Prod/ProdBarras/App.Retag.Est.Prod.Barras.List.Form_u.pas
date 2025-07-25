unit App.Retag.Est.Prod.Barras.List.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, App.AppObj,
  FireDAC.Comp.Client, App.Est.Prod.Barras.DBI;

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
    procedure ConsultarWebActionExecute(Sender: TObject);
  private
    { Private declarations }
    FFDMemTable: TFDMemTable;
    FBarrasDBI: IBarrasDBI;
    FProdId: integer;
    function GetAsString: string;
  public
    { Public declarations }
    property AsString: string read GetAsString;
    property FDMemTable: TFDMemTable read FFDMemTable;
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pBarrasDBI: IBarrasDBI; pProdId: integer); reintroduce;
  end;

var
  ProdBarrasListForm: TProdBarrasListForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.DB.DataSet.Utils, App.UI.Form.Ed.Prod.Barras_u,
  ShellAPI, Sis.Types.Utils_u, App.UI.Form.Perg_u;

procedure TProdBarrasListForm.CancActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TProdBarrasListForm.ConsultarWebActionExecute(Sender: TObject);
var
  Url: string;
begin
  if FDMemTable.IsEmpty then
  begin
    ShowMessage('N�o h� registro a consultar');
    exit;
  end;
  Url := 'https://www.google.com/search?q=' //
    + 'produto+com+%22c%C3%B3digo+de+barras%22+%22' //
    + FDMemTable.Fields[1].AsString //
    + '%22%3F' //
    ;

  ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL);

end;

constructor TProdBarrasListForm.Create(AOwner: TComponent; pAppObj: IAppObj; pBarrasDBI: IBarrasDBI; pProdId: integer);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FBarrasDBI := pBarrasDBI;
  FProdId := pProdId;

  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  sNomeArq := pAppObj.AppInfo.PastaConsTabViews + 'App\Retag\Est\tabview.est.prod.barras.csv';
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable, DBGrid1);
end;

procedure TProdBarrasListForm.ExclActionExecute(Sender: TObject);
begin
  if FDMemTable.IsEmpty then
  begin
    ShowMessage('N�o h� registro a excluir');
    exit;
  end;

  if not App.UI.Form.Perg_u.Perg('Excluir o c�digo de barras?', '', TBooleanDefault.boolFalse) then
    exit;

  FDMemTable.Delete;
end;

function TProdBarrasListForm.GetAsString: string;
var
  oBookmark: TBookmark;
begin
  Result := '';
  if FDMemTable.IsEmpty then
    exit;

  oBookmark := FDMemTable.GetBookmark;
  FDMemTable.DisableControls;
  try
    FDMemTable.First;
    while not FDMemTable.Eof do
    begin
      if Result <> '' then
        Result := Result + #13#10;
      Result := Result + FDMemTable.Fields[1].AsString;
      FDMemTable.Next;
    end;
  finally
    FDMemTable.GotoBookmark(oBookmark);
    FDMemTable.FreeBookmark(oBookmark);
    FDMemTable.EnableControls;
  end;
end;

procedure TProdBarrasListForm.NovoActionExecute(Sender: TObject);
var
  iOrdem: integer;
  sBarras: string;
begin
  sBarras := AsString;
  ProdBarrasEdForm := TProdBarrasEdForm.Create(nil, sBarras, FBarrasDBI, FProdId);
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

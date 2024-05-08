unit App.DB.Import.Prod.BarrasList.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TImportProdBarrasListEdForm = class(TDiagBtnBasForm)
    BarrasLabeledEdit: TLabeledEdit;
    ActionList1: TActionList;
    FDMemTable1: TFDMemTable;
    FDMemTable1CodBarras: TStringField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    InserirAction: TAction;
    ExcluirAction: TAction;
    procedure FDMemTable1BeforeInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    function GetNovoBarras: string;
    procedure SetNovoBarras(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property NovoBarras: string read GetNovoBarras write SetNovoBarras;
  end;

function ImportBarrasEdPerg(pBarras: string; var pNovoBarras: string): Boolean;

var
  ImportProdBarrasListEdForm: TImportProdBarrasListEdForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.Types.strings_u, Sis.UI.Controls.Utils;

function ImportBarrasEdPerg(pBarras: string; var pNovoBarras: string): Boolean;
begin
  ImportProdBarrasListEdForm := TImportProdBarrasListEdForm.Create(Application);
  try
    ImportProdBarrasListEdForm.BarrasLabeledEdit.Text := pBarras;
    ImportProdBarrasListEdForm.NovoBarras := pNovoBarras;
  finally
    ImportProdBarrasListEdForm.Free;
  end;
end;

procedure TImportProdBarrasListEdForm.FDMemTable1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TImportProdBarrasListEdForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDMemTable1.Active := False;
  inherited;
end;

procedure TImportProdBarrasListEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FDMemTable1.Active := True;
end;

function TImportProdBarrasListEdForm.GetNovoBarras: string;
begin
  Result := '';
  FDMemTable1.DisableControls;
  FDMemTable1.First;
  while not FDMemTable1.Eof do
  begin
    if Result <> '' then
      Result := Result + ',';
    Result := Result + FDMemTable1.Fields[0].AsString;
    FDMemTable1.Next;
  end;
  FDMemTable1.First;
  FDMemTable1.EnableControls;
end;

procedure TImportProdBarrasListEdForm.SetNovoBarras(const Value: string);
var
  oItens: TArray<string>;
  I: integer;
  s: string;
begin
  FDMemTable1.DisableControls;
  FDMemTable1.EmptyDataSet;
  oItens := Value.Split([',']);
  for I := 0 to Length(oItens) - 1 do
  begin
    FDMemTable1.Append;
    s := StrToOnlyDigit(oItens[I]);
    FDMemTable1.Fields[0].AsString := s;
    FDMemTable1.Post;
  end;
  FDMemTable1.First;
  FDMemTable1.EnableControls;
end;

procedure TImportProdBarrasListEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);

end;

end.

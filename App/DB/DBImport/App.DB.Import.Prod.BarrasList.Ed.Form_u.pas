unit App.DB.Import.Prod.BarrasList.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TImportProdBarrasListEdForm = class(TDiagBtnBasForm)
    BarrasLabeledEdit: TLabeledEdit;
    ListActionList: TActionList;
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
    UndoBitBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure FDMemTable1BeforeInsert(DataSet: TDataSet);

    procedure InserirActionExecute(Sender: TObject);
    procedure ExcluirActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UndoBitBtnClick(Sender: TObject);

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

uses Sis.UI.ImgDM, Sis.Types.strings_u, Sis.UI.Controls.Utils,
  Sis.UI.IO.Input.Str, App.DB.Import.Factory;

function ImportBarrasEdPerg(pBarras: string; var pNovoBarras: string): Boolean;
begin
  ImportProdBarrasListEdForm := TImportProdBarrasListEdForm.Create(Application);
  try
    ImportProdBarrasListEdForm.BarrasLabeledEdit.Text := pBarras;
    ImportProdBarrasListEdForm.NovoBarras := pNovoBarras;
    Result := ImportProdBarrasListEdForm.Perg;

    if not Result then
      exit;

    pNovoBarras := ImportProdBarrasListEdForm.NovoBarras;
  finally
    ImportProdBarrasListEdForm.Free;
  end;
end;

procedure TImportProdBarrasListEdForm.ExcluirActionExecute(Sender: TObject);
begin
  inherited;
  if FDMemTable1.IsEmpty then
    exit;

  FDMemTable1.Delete;
end;

procedure TImportProdBarrasListEdForm.FDMemTable1BeforeInsert
  (DataSet: TDataSet);
begin
  inherited;
  // if ActiveControl <> DBGrid1 then
  // exit;
  // Abort;
end;

procedure TImportProdBarrasListEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FDMemTable1.Active := True;
end;

procedure TImportProdBarrasListEdForm.FormDestroy(Sender: TObject);
begin
  FDMemTable1.Active := False;
  inherited;
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

procedure TImportProdBarrasListEdForm.InserirActionExecute(Sender: TObject);
var
  sBarras: string;
  oInputBarras: IInputStr;
  bResultado: Boolean;
begin
  inherited;
  sBarras := '';
  oInputBarras := ImportBarEdFormCreate;
  bResultado := oInputBarras.EditStr(sBarras);
  if not bResultado then
    exit;

  FDMemTable1.Append;
  FDMemTable1.Fields[0].AsString := sBarras;
  FDMemTable1.Post;
end;

procedure TImportProdBarrasListEdForm.SetNovoBarras(const Value: string);
var
  oItens: TArray<string>;
  I: integer;
  sBarras: string;
begin
  FDMemTable1.DisableControls;
  FDMemTable1.EmptyDataSet;
  oItens := Value.Split([',']);
  for I := 0 to Length(oItens) - 1 do
  begin
    FDMemTable1.Append;
    sBarras := StrToOnlyDigit(oItens[I]);
    FDMemTable1.Fields[0].AsString := sBarras;
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

procedure TImportProdBarrasListEdForm.UndoBitBtnClick(Sender: TObject);
begin
  inherited;
  SetNovoBarras(BarrasLabeledEdit.Text);
end;

end.

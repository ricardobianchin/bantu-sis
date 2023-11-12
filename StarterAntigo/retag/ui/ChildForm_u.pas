unit ChildForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.DApt, Vcl.Mask;

type
  TChildForm = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    FDConnection1: TFDConnection;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionList1: TActionList;
    InsAction: TAction;
    AlterarAction: TAction;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FecharAction: TAction;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    FiltroLabeledEdit: TLabeledEdit;
    CarregarTimer: TTimer;
    GeralPanel: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FecharActionExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FiltroLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure CarregarTimerTimer(Sender: TObject);
    procedure FiltroLabeledEditChange(Sender: TObject);
  private
    { Private declarations }
    procedure AjusteConnection;
  protected
    procedure Carregar; virtual; abstract;
    function Conectou: boolean;
    procedure Desconectar;
  public
    { Public declarations }
    FormClassNames: TStrings;
    constructor Create(AOwner: TComponent; pFormClassNames: TStrings); reintroduce;

  end;
  TChildFormClass = class of TChildForm;
var
  ChildForm: TChildForm;

implementation

{$R *.dfm}

uses btn.lib.types.strings;

procedure TChildForm.AjusteConnection;
var
  s: string;
begin
  s := Application.ExeName;
  s := ExtractFilePath(s);
  s := IncludeTrailingPathDelimiter(s);
  s := s + 'Dados.fdb';
  FDConnection1.LoginPrompt := False;
  FDConnection1.Params.Text :=
    'Database='+s+#13#10
    +'User_Name=sysdba'#13#10
    +'Password=masterkey'#13#10
    +'DriverID=FB'#13#10
    ;
end;

procedure TChildForm.CarregarTimerTimer(Sender: TObject);
begin
  CarregarTimer.Enabled := false;
  AjusteConnection;
  if not Conectou then
    exit;
  try
    Carregar;
  finally
    Desconectar;
  end;
end;

function TChildForm.Conectou: boolean;
begin
  FDConnection1.Open;
  result := FDConnection1.Connected;
end;

constructor TChildForm.Create(AOwner: TComponent; pFormClassNames: TStrings);
begin
  inherited Create(AOwner);
  FormClassNames := pFormClassNames;
end;

procedure TChildForm.DBGrid1DblClick(Sender: TObject);
begin
  AlterarAction.Execute;
end;

procedure TChildForm.Desconectar;
begin
  FDConnection1.Close;
end;

procedure TChildForm.FecharActionExecute(Sender: TObject);
begin
  close;
end;

procedure TChildForm.FiltroLabeledEditChange(Sender: TObject);
begin
  CarregarTimer.Enabled := false;
  CarregarTimer.Enabled := true;

end;

procedure TChildForm.FiltroLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key := #0;
    exit;
  end;

  CharSemAcento(key);
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iIndex: integer;
begin
  Action := TCloseAction.caFree;

  try
    iIndex := FormClassNames.IndexOf(UpperCase(ClassName));
    if iIndex>-1 then
      FormClassNames.Delete(iIndex);
  except

  end;
end;

procedure TChildForm.FormShow(Sender: TObject);
begin
  AjusteConnection;
  if not Conectou then
    exit;
  FormClassNames.Add(UpperCase(ClassName));
  try
    Carregar;
  finally
    Desconectar;
  end;
end;

end.

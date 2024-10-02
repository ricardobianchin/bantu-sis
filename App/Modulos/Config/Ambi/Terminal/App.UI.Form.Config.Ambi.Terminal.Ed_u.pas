unit App.UI.Form.Config.Ambi.Terminal.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.Types.Integers;

type
  TTerminalEdDiagForm = class(TDiagBtnBasForm)
    ObjetivoLabel: TLabel;
    TerminalIdTitLabel: TLabel;
    TerminalIdEdit: TEdit;
  private
    { Private declarations }
    FTerminaisDataSet: TDataSet;
    FState: TDataSetState;

    procedure Zerar;
    procedure AjusteControles; override;

    function TerminaIdOk: Boolean;
    procedure Gravar;

    procedure ControlesToDataSet;
    procedure DataSetToControles;

    function TerminalIdMaior: integer;
  protected
    function PodeOk: Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTerminaisDataSet: TDataSet;
      pDataSetState: TDataSetState); reintroduce;
  end;

var
  TerminalEdDiagForm: TTerminalEdDiagForm;

implementation

{$R *.dfm}

uses System.Math;

{ TTerminalEdDiagForm }

procedure TTerminalEdDiagForm.AjusteControles;
var
  i: integer;
begin
  inherited;
  if FState = dsInsert then
  begin
    ObjetivoLabel.Caption := 'Inserindo Terminal';

    TerminalIdEdit.Enabled := True;

    Zerar;
    i := TerminalIdMaior + 1;
    TerminalIdEdit.Text := i.ToString;
  end
  else
  begin
    ObjetivoLabel.Caption := 'Alterando Terminal ' + TerminalIdEdit.Text;

    DataSetToControles;

    TerminalIdEdit.Enabled := False;
  end;
end;

procedure TTerminalEdDiagForm.ControlesToDataSet;
var
  i: integer;
begin
  i := StrToInteger(TerminalIdEdit.Text);
  FTerminaisDataSet.FieldByName('TERMINAL_ID').AsInteger := i;

end;

constructor TTerminalEdDiagForm.Create(AOwner: TComponent;
  pTerminaisDataSet: TDataSet; pDataSetState: TDataSetState);
begin
  inherited Create(AOwner);
  FTerminaisDataSet := pTerminaisDataSet;
  FState := pDataSetState;
end;

procedure TTerminalEdDiagForm.DataSetToControles;
begin

end;

procedure TTerminalEdDiagForm.Gravar;
begin
  if FState = dsInsert then
  begin
    FTerminaisDataSet.Append;
  end
  else
  begin
    FTerminaisDataSet.Edit;
  end;
  ControlesToDataSet;
end;

function TTerminalEdDiagForm.TerminalIdMaior: integer;
var
  b: TBookmark;
  Tab: TDataSet;
begin
  Result := 0;
  Tab := FTerminaisDataSet;
  b := Tab.GetBookmark;
  try
    Tab.First;
    while not Tab.Eof do
    begin
      Result := Max(Result, Tab.FieldByName('TERMINAL_ID').AsInteger);
      Tab.Next;
    end;
  finally
    Tab.GotoBookmark(b);
    Tab.FreeBookmark(b);
  end;
end;

function TTerminalEdDiagForm.PodeOk: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := TerminaIdOk;
  if not Result then
    exit;

  Gravar;
end;

function TTerminalEdDiagForm.TerminaIdOk: Boolean;
begin

end;

procedure TTerminalEdDiagForm.Zerar;
begin
  TerminalIdEdit.Clear;
end;

end.

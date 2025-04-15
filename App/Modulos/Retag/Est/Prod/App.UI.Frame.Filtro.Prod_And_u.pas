unit App.UI.Frame.Filtro.Prod_And_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  System.Generics.Collections;

type
  TProdAndFiltroFrame = class(TFiltroFrame)
    FundoPanel: TPanel;
    FiltroStringLabeledEdit: TLabeledEdit;
    CodCheckBox: TCheckBox;
    BarrasCheckBox: TCheckBox;
    DescrCheckBox: TCheckBox;
    FabrCheckBox: TCheckBox;
    TipoCheckBox: TCheckBox;
    procedure FiltroStringLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure FiltroStringLabeledEditChange(Sender: TObject);
  private
    { Private declarations }
    FCheckBoxList: TList<TCheckBox>;
    procedure CheckBoxClick(Sender: TObject);
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent); override;
    destructor Destroy; override;

  end;

var
  ProdAndFiltroFrame: TProdAndFiltroFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

{ TProdFiltroFrame }

procedure TProdAndFiltroFrame.CheckBoxClick(Sender: TObject);
begin
  DoChange;
end;

constructor TProdAndFiltroFrame.Create(AOwner: TComponent;
  pOnChange: TNotifyEvent);
var
  c: TCheckBox;
  i: Integer;
begin
  inherited;
  FCheckBoxList := TList<TCheckBox>.Create;

  FCheckBoxList.Add(CodCheckBox);
  FCheckBoxList.Add(BarrasCheckBox);
  FCheckBoxList.Add(DescrCheckBox);
  FCheckBoxList.Add(FabrCheckBox);
  FCheckBoxList.Add(TipoCheckBox);

  for i := 0 to FCheckBoxList.Count -1 do
  begin
    c := FCheckBoxList[i];
    c.Left := 160 + i * 90;
    c.Top := FiltroStringLabeledEdit.Top + 4;
    c.onclick := CheckBoxClick;
  end;
  ProcessaFiltro := True;
end;

destructor TProdAndFiltroFrame.Destroy;
begin
  FCheckBoxList.Free;
  inherited;
end;

procedure TProdAndFiltroFrame.FiltroStringLabeledEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;
end;

procedure TProdAndFiltroFrame.FiltroStringLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    DoChange;
  end;
  CharSemAcento(Key);
end;

function TProdAndFiltroFrame.GetValues: variant;
var
  c: TCheckBox;
  i: Integer;
begin
  Result := inherited;
  Result[0] := FiltroStringLabeledEdit.Text;

  for i := 0 to FCheckBoxList.Count -1 do
  begin
    c := FCheckBoxList[i];
    Result[i+1] := c.Checked;
  end;
end;

function TProdAndFiltroFrame.NewArrayCreate: variant;
begin
  Result := VarArrayCreate([0, 5], varVariant);
end;

procedure TProdAndFiltroFrame.SetValues(Value: variant);
var
  c: TCheckBox;
  i: Integer;
begin
  if VarArrayDimCount(Value) < 6 then
    exit;

  FiltroStringLabeledEdit.Text := VarToStr(Value[0]);

  for i := 0 to FCheckBoxList.Count -1 do
  begin
    c := FCheckBoxList[i];
    c.Checked := Value[i+1];
  end;

  AjusteValores;
end;

end.

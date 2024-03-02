unit Sis.UI.Controls.ComboBoxManager_u;

interface

uses Vcl.StdCtrls, Sis.UI.Controls.ComboBoxManager;

type
  TComboBoxManager = class(TInterfacedObject, IComboBoxManager)
  private
    FComboBox: TComboBox;
    function GetComboBox: TComboBox;
  protected
    procedure SetId(const pId: integer); virtual;
    function GetId: integer; virtual;
    procedure LimparItens; virtual;

    property ComboBox: TComboBox read GetComboBox;
  public
    procedure Cicle;

    constructor Create(pComboBox: TComboBox);
    property Id: integer read GetId write SetId;

    function PegarId(pId: integer; pDescr: string): integer; virtual;
    function PegarChar(pId: char; pDescr: string): integer; virtual;
  end;

implementation

{ TComboBoxManager }

procedure TComboBoxManager.Cicle;
var
  i, q: integer;
begin
  q := FComboBox.Items.Count;
  if q < 2 then
    exit;

  i := FComboBox.ItemIndex;

  inc(i);

  if i = q then
    i := 0;

  FComboBox.ItemIndex := i;
end;

constructor TComboBoxManager.Create(pComboBox: TComboBox);
begin
  FComboBox := pComboBox;
end;

function TComboBoxManager.GetComboBox: TComboBox;
begin
  Result := FComboBox;
end;

function TComboBoxManager.GetId: integer;
var
  I: integer;
  P: pointer;
  Resultado: integer;
begin
  I := FComboBox.ItemIndex;
  P := FComboBox.Items.Objects[I];
  Resultado := integer(P);
  Result := Resultado;
end;

procedure TComboBoxManager.LimparItens;
begin
  FComboBox.Items.Clear;
end;

function TComboBoxManager.PegarChar(pId: char; pDescr: string): integer;
var
  iId: integer;
begin
  iId := Ord(pId);
  Result := PegarId(iId, pDescr);
end;

function TComboBoxManager.PegarId(pId: integer; pDescr: string): integer;
var
  P: pointer;
begin
  if pId < 1 then
  begin
    Result := FComboBox.Items.Add(pDescr);
    exit;
  end;
  P := Pointer(pId);
  Result := FComboBox.Items.AddObject(pDescr, P);
end;

procedure TComboBoxManager.SetId(const pId: integer);
var
  i: integer;
begin
  if pId < 1 then
    exit;

  i := FComboBox.Items.IndexOfObject(Pointer(pId));
  if i <0 then
    exit;

  FComboBox.ItemIndex := i;
end;

end.

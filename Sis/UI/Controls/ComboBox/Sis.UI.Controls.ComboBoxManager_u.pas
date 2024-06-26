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

    procedure SetIdChar(const pId: Char); virtual;
    function GetIdChar: Char; virtual;

    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;

    property ComboBox: TComboBox read GetComboBox;
  public
    procedure Cicle;
    procedure Clear; virtual;

    constructor Create(pComboBox: TComboBox);

    property Id: integer read GetId write SetId;
    property IdChar: Char read GetIdChar write SetIdChar;
    property Text: string read GetText write SetText;

    function PegarId(pId: integer; pDescr: string): integer; virtual;
    function PegarIdChar(pId: char; pDescr: string): integer; virtual;
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

function TComboBoxManager.GetIdChar: Char;
begin
  Result := char(GetId);
end;

function TComboBoxManager.GetText: string;
begin
  Result := FComboBox.Text;
end;

procedure TComboBoxManager.Clear;
begin
  FComboBox.Items.Clear;
  FComboBox.Text := '';
end;

function TComboBoxManager.PegarIdChar(pId: char; pDescr: string): integer;
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
  iIndex: integer;
begin
  if pId < 1 then
  begin
    FComboBox.ItemIndex := -1;
    FComboBox.Text := '';
    exit;
  end;

  iIndex := FComboBox.Items.IndexOfObject(Pointer(pId));
  if iIndex < 0 then
    exit;

  FComboBox.ItemIndex := iIndex;
end;

procedure TComboBoxManager.SetIdChar(const pId: Char);
var
  iId: integer;
begin
  if (pId=#0) or (pId=#32) then
  begin
    iId := 0;
  end
  else
    iId := Ord(pId);

  SetId(iId);
end;

procedure TComboBoxManager.SetText(const Value: string);
var
  I: integer;
begin
  I := FComboBox.Items.IndexOf(Value);

  if I < 0 then
    exit;

  FComboBox.ItemIndex := i;
end;

end.

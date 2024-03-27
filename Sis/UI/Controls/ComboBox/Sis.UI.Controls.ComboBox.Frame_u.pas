unit Sis.UI.Controls.ComboBox.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TComboBoxBasFrame = class(TControlBasFrame)
    ControlsPanel: TPanel;
    TitLabel: TLabel;
    EspacadorLabel: TLabel;
    ComboBox1: TComboBox;
    MensLabel: TLabel;
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetCaption: string; virtual; abstract;

    function GetId: integer; virtual;
    procedure SetId(const Value: integer); virtual;

    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;

  public
    { Public declarations }
    procedure EscondeMens;
    procedure ExibaMens(pFrase: string);
    procedure Limpar; virtual;

    property Id: integer read GetId write SetId;
    property Text: string read GetText write SetText;

    procedure PegarItem(pId: integer; pText: string);

    constructor Create(AOwner: TComponent); override;
  end;

var
  ComboBoxBasFrame: TComboBoxBasFrame;

implementation

{$R *.dfm}

{ TComboBoxBasFrame }

procedure TComboBoxBasFrame.ComboBox1Change(Sender: TObject);
begin
  inherited;
  EscondeMens;
end;

procedure TComboBoxBasFrame.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, key);
  if (Key >= #32) or (Key = #8) then
    ComboBox1.DroppedDown := True;
end;

constructor TComboBoxBasFrame.Create(AOwner: TComponent);
var
  sCaption: string;
begin
  inherited;
  Limpar;
  sCaption := GetCaption;
  TitLabel.Caption := sCaption;
end;

procedure TComboBoxBasFrame.EscondeMens;
begin
  MensLabel.Visible := false;
end;

procedure TComboBoxBasFrame.ExibaMens(pFrase: string);
begin
  MensLabel.Visible := false;
  MensLabel.Caption := pFrase;
end;

function TComboBoxBasFrame.GetText: string;
begin
  Result := ComboBox1.Text;
end;

function TComboBoxBasFrame.GetId: integer;
var
  I: integer;
  P: pointer;
  Resultado: integer;
begin
  I := ComboBox1.ItemIndex;
  if I < 0 then
  begin
    Result := 0;
    exit;
  end;
  P := ComboBox1.Items.Objects[I];
  Resultado := integer(P);
  Result := Resultado;
end;

procedure TComboBoxBasFrame.Limpar;
begin
  ComboBox1.Items.Clear;
  ComboBox1.Text := '';
end;

procedure TComboBoxBasFrame.PegarItem(pId: integer; pText: string);
begin
  if pId < 1 then
  begin
    ComboBox1.Items.Add(pText);
    exit;
  end;

  ComboBox1.Items.AddObject(pText, Pointer(pId));
end;

procedure TComboBoxBasFrame.SetText(const Value: string);
begin
  ComboBox1.Text := Value;
end;

procedure TComboBoxBasFrame.SetId(const Value: integer);
var
  i: integer;
begin
  if Value < 1 then
    exit;

  i := ComboBox1.Items.IndexOfObject(Pointer(Value));
  if i <0 then
    exit;

  ComboBox1.ItemIndex := i;
end;

end.

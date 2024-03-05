unit Sis.UI.Controls.ComboBox.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TComboBoxBasFrame = class(TControlBasFrame)
    TitLabel: TLabel;
    ComboBox1: TComboBox;
    EspacadorLabel: TLabel;
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
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
    procedure Limpar; virtual;

    property Id: integer read GetId write SetId;
    property Text: string read GetText write SetText;

    constructor Create(AOwner: TComponent); override;
  end;

var
  ComboBoxBasFrame: TComboBoxBasFrame;

implementation

{$R *.dfm}

{ TComboBoxBasFrame }

procedure TComboBoxBasFrame.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, key);
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
  P := ComboBox1.Items.Objects[I];
  Resultado := integer(P);
  Result := Resultado;
end;

procedure TComboBoxBasFrame.Limpar;
begin
  ComboBox1.Items.Clear;
  ComboBox1.Text := '';
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

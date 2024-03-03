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
  private
    { Private declarations }
  protected
    function GetCaption: string; virtual; abstract;
  public
    { Public declarations }
    procedure PreenchaComboBox; virtual;
    procedure Limpar; virtual;
    constructor Create(AOwner: TComponent); override;
  end;

var
  ComboBoxBasFrame: TComboBoxBasFrame;

implementation

{$R *.dfm}

{ TComboBoxBasFrame }

constructor TComboBoxBasFrame.Create(AOwner: TComponent);
begin
  inherited;
  TitLabel.Caption := GetCaption;
end;

procedure TComboBoxBasFrame.Limpar;
begin
  ComboBox1.Items.Clear;
  ComboBox1.Text := '';
end;

procedure TComboBoxBasFrame.PreenchaComboBox;
begin
  Limpar;
end;

end.

unit App.UI.Config.MaqNomeEdFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls;

type
  TMaqNomeEdFrame = class(TBasFrame)
    GroupBox1: TGroupBox;
    ObsLabel: TLabel;
    NomeLabeledEdit: TLabeledEdit;
    IpLabeledEdit: TLabeledEdit;
    ErroLabel: TLabel;
    procedure IpLabeledEditExit(Sender: TObject);
    procedure NomeLabeledEditChange(Sender: TObject);
    procedure IpLabeledEditChange(Sender: TObject);
    procedure NomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure EsconderErro;
    procedure ExibirErro(const pFrase: string);
    function IsDataOk: boolean;
  public
    { Public declarations }
    function PodeOk: boolean;
    function GetIdentStr: string;
  end;

var
  MaqNomeEdFrame: TMaqNomeEdFrame;

implementation

{$R *.dfm}

procedure TMaqNomeEdFrame.EsconderErro;
begin
  ErroLabel.Visible := false;
end;

procedure TMaqNomeEdFrame.ExibirErro(const pFrase: string);
begin
  ErroLabel.Caption := pFrase;
  ErroLabel.Visible := true;
end;

function TMaqNomeEdFrame.GetIdentStr: string;
begin
  if NomeLabeledEdit.Text <> '' then
    result := NomeLabeledEdit.Text
  else
    result := IpLabeledEdit.Text;
end;

procedure TMaqNomeEdFrame.IpLabeledEditChange(Sender: TObject);
begin
  inherited;
  EsconderErro;
end;

procedure TMaqNomeEdFrame.IpLabeledEditExit(Sender: TObject);
begin
  inherited;
  PodeOk;

end;

function TMaqNomeEdFrame.IsDataOk: boolean;
begin
  Result := not Visible;
  if Result then
    exit;

  NomeLabeledEdit.Text := Trim(NomeLabeledEdit.Text);
  IpLabeledEdit.Text := Trim(IpLabeledEdit.Text);

  result := (NomeLabeledEdit.Text <> '') or (IpLabeledEdit.Text <> '');
end;

procedure TMaqNomeEdFrame.NomeLabeledEditChange(Sender: TObject);
begin
  inherited;
  EsconderErro;
end;

procedure TMaqNomeEdFrame.NomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

function TMaqNomeEdFrame.PodeOk: boolean;
begin
  result := IsDataOk;

  if not result then
    ExibirErro('Confira os dados da '+GroupBox1.Caption);
end;

end.

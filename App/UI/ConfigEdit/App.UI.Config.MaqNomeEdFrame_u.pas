unit App.UI.Config.MaqNomeEdFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TMaqNomeEdFrame = class(TFrame)
    GroupBox1: TGroupBox;
    NomeLabeledEdit: TLabeledEdit;
    IpLabeledEdit: TLabeledEdit;
    ObsLabel: TLabel;
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
  end;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

{ TMaqNomeEdFrame }

procedure TMaqNomeEdFrame.EsconderErro;
begin
  ErroLabel.Visible := false;
end;

procedure TMaqNomeEdFrame.ExibirErro(const pFrase: string);
begin
  ErroLabel.Caption := pFrase;
  ErroLabel.Visible := true;
end;

function TMaqNomeEdFrame.IsDataOk: boolean;
begin
  result := not Visible;
  if result then
    exit;

  NomeLabeledEdit.Text := Trim(NomeLabeledEdit.Text);
  IpLabeledEdit.Text := Trim(IpLabeledEdit.Text);

  result := (NomeLabeledEdit.Text <> '') or (IpLabeledEdit.Text <> '');
end;

procedure TMaqNomeEdFrame.NomeLabeledEditChange(Sender: TObject);
begin
  EsconderErro;
end;

procedure TMaqNomeEdFrame.NomeLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    key := #0;
    IpLabeledEdit.SetFocus;
    exit;
  end;

  CharSemAcento(Key, true);

end;

function TMaqNomeEdFrame.PodeOk: boolean;
begin
  result := IsDataOk;

  if not result then
    ExibirErro('Confira os dados da '+GroupBox1.Caption);
end;

procedure TMaqNomeEdFrame.IpLabeledEditChange(Sender: TObject);
begin
  EsconderErro;
end;

procedure TMaqNomeEdFrame.IpLabeledEditExit(Sender: TObject);
begin
  PodeOk;
end;

end.

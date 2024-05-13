unit Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.Buttons;

type
  TFileSelectLabeledEditFrame = class(TFrame)
    MeioPanel: TPanel;
    NomeArqLabeledEdit: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    function GetNomeArq: string;
    procedure SetNomeArq(Value: string);
    function GetEditCaption: string;
    procedure SetEditCaption(const Value: string);
  public
    { Public declarations }
    procedure PegarFiltro(pFilterStr: string);
    property NomeArq: string read GetNomeArq write SetNomeArq;
    property EditCaption: string read GetEditCaption write SetEditCaption;
  end;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TFileSelectLabeledEditFrame }

function TFileSelectLabeledEditFrame.GetEditCaption: string;
begin
  Result := NomeArqLabeledEdit.EditLabel.Caption;
end;

function TFileSelectLabeledEditFrame.GetNomeArq: string;
begin
  Result := Trim(NomeArqLabeledEdit.Text);
end;

procedure TFileSelectLabeledEditFrame.PegarFiltro(pFilterStr: string);
begin
  OpenDialog1.Filter := pFilterStr;
end;

procedure TFileSelectLabeledEditFrame.SetEditCaption(const Value: string);
var
  L: integer;
begin
  NomeArqLabeledEdit.EditLabel.Caption := Value;

  L := NomeArqLabeledEdit.EditLabel.Left;

  if L = 0 then
    exit;

  NomeArqLabeledEdit.Width := NomeArqLabeledEdit.Width + L;
  NomeArqLabeledEdit.Left := NomeArqLabeledEdit.Left - L;
end;

procedure TFileSelectLabeledEditFrame.SetNomeArq(Value: string);
begin
  NomeArqLabeledEdit.Text := Trim(Value);
end;

procedure TFileSelectLabeledEditFrame.SpeedButton1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    exit;
  SetNomeArq(OpenDialog1.FileName);
end;

end.

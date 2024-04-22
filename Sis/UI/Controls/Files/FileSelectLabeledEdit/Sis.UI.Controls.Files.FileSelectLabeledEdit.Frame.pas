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
  public
    { Public declarations }
    procedure PegarFiltro(pFilterStr: string);
  end;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TFileSelectLabeledEditFrame }

procedure TFileSelectLabeledEditFrame.PegarFiltro(pFilterStr: string);
begin
  OpenDialog1.Filter := pFilterStr;
end;

procedure TFileSelectLabeledEditFrame.SpeedButton1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    exit;
  NomeArqLabeledEdit.Text := OpenDialog1.FileName;
end;

end.

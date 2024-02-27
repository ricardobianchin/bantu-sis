unit Sis.UI.Frame.Control.EditSelect_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Sis.Ui.Img.Utils;

type
  TControlBasFrame1 = class(TControlBasFrame)
    IdLabeledEdit: TLabeledEdit;
    DescrLabeledEdit: TLabeledEdit;
    ValorLabeledEdit: TLabeledEdit;
    TitLabel: TLabel;
    BuscaBitBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  ControlBasFrame1: TControlBasFrame1;

implementation

{$R *.dfm}

{ TControlBasFrame1 }

constructor TControlBasFrame1.Create(AOwner: TComponent);
var
  sNomeArq: string;
begin
  inherited;
  sNomeArq := ImgsList.ImgIndexToFileName(ImgIndexesSis.Lupa16);
  BuscaBitBtn.Glyph.LoadFromFile(sNomeArq);
end;

end.

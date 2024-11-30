unit App.UI.Controls.NumerarioEditFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TNumerarioEditFrame = class(TBasFrame)
    QtdEdit: TEdit;
    UpDown1: TUpDown;
    Image1: TImage;
    ExtensoLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  NumerarioEditFrame: TNumerarioEditFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TNumerarioEditFrame }

constructor TNumerarioEditFrame.Create(AOwner: TComponent);
begin
  inherited;
  ClearStyleElements(Self);
end;

end.

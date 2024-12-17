unit App.UI.PDV.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.ToolWin, Vcl.ComCtrls, App.Est.Venda.CaixaSessaoDM_u;

type
  TPDVFrame = class(TBasFrame)
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  PDVFrame: TPDVFrame;

implementation

{$R *.dfm}

{ TPDVFrame }

uses Sis.UI.Controls.Utils;

constructor TPDVFrame.Create(AOwner: TComponent);
begin
  inherited;
  ClearStyleElements(Self);
end;

end.

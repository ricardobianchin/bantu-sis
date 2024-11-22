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
  end;

var
  PDVFrame: TPDVFrame;

implementation

{$R *.dfm}

{ TPDVFrame }

end.

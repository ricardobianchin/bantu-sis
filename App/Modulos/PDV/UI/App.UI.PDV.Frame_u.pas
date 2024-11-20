unit App.UI.PDV.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ToolWin,
  Vcl.ComCtrls;

type
  TPDVFrame = class(TBasFrame)
  private
    { Private declarations }
    FToolBar1: TToolBar;
  protected
    property ToolBar1: TToolBar read FToolBar1;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pToolBar: TToolBar); reintroduce; virtual;
  end;

var
  PDVFrame: TPDVFrame;

implementation

{$R *.dfm}

{ TPDVFrame }

constructor TPDVFrame.Create(AOwner: TComponent; pToolBar: TToolBar);
begin
  inherited Create(AOwner);
  FToolBar1 := pToolBar;
end;

end.

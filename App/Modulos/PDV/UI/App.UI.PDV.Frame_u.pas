unit App.UI.PDV.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.ToolWin, Vcl.ComCtrls, App.Est.Venda.CaixaSessaoDM_u,
  Vcl.StdCtrls;

type
  TPDVFrame = class(TBasFrame)
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Iniciar; virtual;
    procedure OculteControles; virtual;
    procedure ExibaControles; virtual;
    procedure DimensioneControles; virtual;

    constructor Create(AOwner: TComponent); override;

    procedure ExecKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure ExecKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure ExibaErro(pMens: string); virtual;
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

procedure TPDVFrame.DimensioneControles;
begin

end;

procedure TPDVFrame.ExecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
begin

end;

procedure TPDVFrame.ExibaErro(pMens: string);
begin

end;

procedure TPDVFrame.ExibaControles;
begin

end;

procedure TPDVFrame.FrameResize(Sender: TObject);
begin
  inherited;
  DimensioneControles;
end;

procedure TPDVFrame.Iniciar;
begin

end;

procedure TPDVFrame.OculteControles;
begin

end;

end.

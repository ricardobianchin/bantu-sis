unit App.UI.PDV.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  App.PDV.Obj;

type
  TPDVFrame = class(TBasFrame)
    MeioPanel: TPanel;
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    FPDVObj: IPDVObj;

  protected
    property PDVObj: IPDVObj read FPDVObj;

  public
    { Public declarations }
    procedure Iniciar; virtual;
    procedure OculteControles; virtual;
    procedure ExibaControles; virtual;

    procedure DimensioneControles; virtual;

    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure ExecKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure ExibaErro(pMens: string); virtual;
    procedure ExibaMens(pMens: string); virtual;

    constructor Create(AOwner: TComponent; pPDVObj: IPDVObj);
      reintroduce;
  end;

var
  PDVFrame: TPDVFrame;

implementation

{$R *.dfm}
{ TPDVFrame }

uses Sis.UI.Controls.Utils;

constructor TPDVFrame.Create(AOwner: TComponent;
  pPDVObj: IPDVObj);
begin
  inherited Create(AOwner);
  ClearStyleElements(Self);
  FPDVObj := pPDVObj;
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

procedure TPDVFrame.ExibaMens(pMens: string);
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

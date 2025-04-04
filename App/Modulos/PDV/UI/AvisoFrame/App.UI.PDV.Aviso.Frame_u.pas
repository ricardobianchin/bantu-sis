unit App.UI.PDV.Aviso.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.Frame_u, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  App.Est.Venda.CaixaSessaoDM_u, Vcl.ActnList, App.PDV.Obj;

type
  TAvisoPDVFrame = class(TPDVFrame)
    Panel1: TPanel;
    Button1: TButton;
    GavButton: TButton;
    MensagemLabel: TLabel;
    procedure GavButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DimensioneControles; override;
    procedure ExibaControles; override;
    procedure OculteControles; override;

    constructor Create(AOwner: TComponent; pPDVObj: IPDVObj;
      pCaption: TCaption; pAction: TAction); reintroduce; virtual;
  end;

var
  AvisoPDVFrame: TAvisoPDVFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.TToolBar;

{ TAvisoPDVFrame }

procedure TAvisoPDVFrame.DimensioneControles;
var
  LargDif: integer;
  AltuDif: integer;
  rRect: TRect;
  oControl: TControl;
begin
  Inherited;
  rRect := Self.ClientRect;
  oControl := Panel1;
  LargDif := rRect.Width - oControl.Width;
  oControl.Left := LargDif div 2;

  AltuDif := rRect.Height - oControl.Height;
  oControl.Top := (AltuDif div 10) * 4;
end;

procedure TAvisoPDVFrame.GavButtonClick(Sender: TObject);
begin
  inherited;
  GavButton.Enabled := False;
  try
    PDVObj.Gaveta.Acione;
    sleep(300);
  finally
    GavButton.Enabled := True;
  end;
end;

constructor TAvisoPDVFrame.Create(AOwner: TComponent;
  pPDVObj: IPDVObj; pCaption: TCaption; pAction: TAction);
begin
  inherited Create(AOwner, pPDVObj);

  MensagemLabel.Caption := pCaption;
  ControlAlignHorizontal(MensagemLabel);

  Button1.Action := pAction;
end;

procedure TAvisoPDVFrame.ExibaControles;
begin
  inherited;
  Panel1.Visible := True;
  TrySetFocus(Button1);
end;

procedure TAvisoPDVFrame.OculteControles;
begin
  inherited;
  Panel1.Visible := False;
end;

end.

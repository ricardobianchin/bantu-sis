unit App.UI.PDV.SessaoAbrir.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.PDV.Frame_u, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls;

type
  TSessaoAbrirPDVFrame = class(TPDVFrame)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AjusteControles; override;
    constructor Create(AOwner: TComponent; pToolBar: TToolBar); reintroduce; override;
  end;

var
  SessaoAbrirPDVFrame: TSessaoAbrirPDVFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TSessaoAbrirPDVFrame }

procedure TSessaoAbrirPDVFrame.AjusteControles;
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
//  ControlAlignToRect(Panel1, Parent.ClientRect);
end;

constructor TSessaoAbrirPDVFrame.Create(AOwner: TComponent; pToolBar: TToolBar);
begin
  inherited;
end;

end.

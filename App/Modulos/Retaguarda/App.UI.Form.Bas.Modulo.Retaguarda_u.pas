unit App.UI.Form.Bas.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Menus;

type
  TRetaguardaModuloBasForm = class(TModuloBasForm)
    RetagActionList: TActionList;
    RetagEstoqueProdTipoAction: TAction;
    MenuPanel: TPanel;
    MenuPageControl: TPageControl;
    EstoqueTabSheet: TTabSheet;
    EstoqueToolBar: TToolBar;
    ToolButton2: TToolButton;
    TabSheet1: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure RetagEstoqueProdTipoActionExecute(Sender: TObject);
    procedure MenuPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RetaguardaModuloBasForm: TRetaguardaModuloBasForm;

implementation

{$R *.dfm}

uses App.UI.Retaguarda.ImgDM_u;

procedure TRetaguardaModuloBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  if not Assigned(RetagImgDM) then
  begin
    RetagImgDM := TRetagImgDM.Create(Application);
  end;
end;

procedure TRetaguardaModuloBasForm.MenuPageControlDrawTab
  (Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
var
  vRect: TRect;
  sTexto: string;
begin
  inherited;
  vRect := Rect;
  vRect.Top := vRect.Top + 2;
  Control.Canvas.Pen.Style := psClear;
  Control.Canvas.Brush.Style := bsClear;
//  Control.Canvas.Font.Color := clBlack;
  if Active then
  begin
//    Control.Canvas.Brush.Color := RGB(230, 230, 230);
    Control.Canvas.Rectangle(vRect);
//    Control.Canvas.Pen.Style := psSolid;
  Control.Canvas.Font.Color := RGB(230, 230, 230);
    Control.Canvas.Font.Style := [TFontStyle.fsUnderline];
  end
  else
  begin
//    Control.Canvas.Brush.Color := RGB(204, 204, 204);
    Control.Canvas.Rectangle(vRect);
//    Control.Canvas.Pen.Style := psSolid;
//    Control.Canvas.Font.Color := clBlack;
  Control.Canvas.Font.Color := RGB(204, 204, 204);
  end;
  sTexto := TTabControl(Control).Tabs[TabIndex];
  Control.Canvas.TextRect(vRect, sTexto, [tfCenter, tfVerticalCenter]);
end;

procedure TRetaguardaModuloBasForm.RetagEstoqueProdTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  //
end;

end.

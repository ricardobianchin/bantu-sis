unit App.UI.Form.Bas.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.Types.Contador, Sis.UI.Form.Bas.TabSheet_u;

type
  TRetaguardaModuloBasForm = class(TModuloBasForm)
    RetagActionList: TActionList;
    RetagEstProdTipoAction: TAction;
    MenuPanel: TPanel;
    MenuPageControl: TPageControl;
    EstoqueTabSheet: TTabSheet;
    AjudaTabSheet: TTabSheet;
    PageControl1: TPageControl;
    RetagEstProdFabrAction: TAction;
    EstProdGroupBox: TGroupBox;
    EstoqueToolBar: TToolBar;
    EstProdTipoToolButton: TToolButton;
    EstProdFabrToolButton: TToolButton;
    BalloonHint1: TBalloonHint;
    BalloonHint1CloseTimer: TTimer;
    ToolBar3: TToolBar;
    RetagAjuBemAction: TAction;
    AjuBemToolButton: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure RetagEstProdTipoActionExecute(Sender: TObject);
    procedure MenuPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure RetagEstProdFabrActionExecute(Sender: TObject);
    procedure BalloonHint1CloseTimerTimer(Sender: TObject);
    procedure RetagAjuBemActionExecute(Sender: TObject);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;

    procedure TabSheetCrie(pTabSheetBasFormClass: TTabSheetBasFormClass);
  public
    { Public declarations }
  end;

var
  RetaguardaModuloBasForm: TRetaguardaModuloBasForm;

implementation

{$R *.dfm}

uses App.UI.Retaguarda.ImgDM_u, Sis.Types.Factory, System.Types,
  App.UI.Form.TabSheet.Retag.Aju.BemVindo_u;

procedure TRetaguardaModuloBasForm.BalloonHint1CloseTimerTimer(Sender: TObject);
begin
  inherited;
  BalloonHint1CloseTimer.Enabled := False;
  BalloonHint1.HideHint;
end;

procedure TRetaguardaModuloBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  if not Assigned(RetagImgDM) then
  begin
    RetagImgDM := TRetagImgDM.Create(Application);
  end;

  FFormClassNamesSL := TStringList.Create;
  FContador := ContadorCreate;
end;

procedure TRetaguardaModuloBasForm.FormDestroy(Sender: TObject);
begin
  FFormClassNamesSL.Free;
  inherited;
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
  // Control.Canvas.Font.Color := clBlack;
  if Active then
  begin
    // Control.Canvas.Brush.Color := RGB(230, 230, 230);
    Control.Canvas.Rectangle(vRect);
    // Control.Canvas.Pen.Style := psSolid;
    Control.Canvas.Font.Color := RGB(230, 230, 230);
    Control.Canvas.Font.Style := [TFontStyle.fsUnderline];
  end
  else
  begin
    // Control.Canvas.Brush.Color := RGB(204, 204, 204);
    Control.Canvas.Rectangle(vRect);
    // Control.Canvas.Pen.Style := psSolid;
    // Control.Canvas.Font.Color := clBlack;
    Control.Canvas.Font.Color := RGB(204, 204, 204);
  end;
  sTexto := TTabControl(Control).Tabs[TabIndex];
  Control.Canvas.TextRect(vRect, sTexto, [tfCenter, tfVerticalCenter]);
end;

procedure TRetaguardaModuloBasForm.RetagAjuBemActionExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(TRetagAjuBemForm);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdFabrActionExecute
  (Sender: TObject);
var
  t: TTabSheet;
begin
  inherited;

  //
end;

procedure TRetaguardaModuloBasForm.RetagEstProdTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  //
end;

procedure TRetaguardaModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  RetagAjuBemAction.Execute;
end;

procedure TRetaguardaModuloBasForm.TabSheetCrie(pTabSheetBasFormClass
  : TTabSheetBasFormClass);
var
  oTabSheet: TTabSheet;
  oTabSheetBasForm: TTabSheetBasForm;
  HintPoint: TPoint;
  sFormClassName: string;
  iPageIndex: Integer;
  oTRect: TRect;
  iExistenteIndex: integer;

  oFormOwner: TComponent;
begin
  sFormClassName := UpperCase(pTabSheetBasFormClass.ClassName);

  iExistenteIndex := FFormClassNamesSL.IndexOf(sFormClassName);
  if iExistenteIndex > -1 then
  begin
    // HintPoint := Mouse.CursorPos;
    oTabSheet := TTabSheet(FFormClassNamesSL.Objects[iExistenteIndex]);
    PageControl1.ActivePage := oTabSheet;
    iPageIndex := PageControl1.ActivePageIndex;
    oTRect := PageControl1.TabRect(iPageIndex);
    HintPoint := CenterPoint(oTRect);

    if HintPoint.X < 20 then
      HintPoint.X := 20;
    // Dec(HintPoint.Y, 3);

    BalloonHint1.Title := 'Opção já aberta';
    BalloonHint1.ShowHint(HintPoint);
    BalloonHint1CloseTimer.Enabled := False;
    BalloonHint1CloseTimer.Enabled := true;
    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oTabSheetBasForm := pTabSheetBasFormClass.Create(oFormOwner, FFormClassNamesSL);
  oTabSheetBasForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := oTabSheetBasForm.Caption;
  oTabSheetBasForm.Show;

end;

end.

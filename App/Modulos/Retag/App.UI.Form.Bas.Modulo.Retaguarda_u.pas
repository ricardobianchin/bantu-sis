unit App.UI.Form.Bas.Modulo.Retaguarda_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.Types.Contador,
  App.UI.Form.Bas.TabSheet_u, App.UI.Form.Bas.TabSheet.DataSet_u,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.Eventos, App.Constants,
  Sis.Usuario, App.AppInfo, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, FlatBtn;

type
  TRetaguardaModuloBasForm = class(TModuloBasForm)
    RetagActionList: TActionList;
    MenuPanel: TPanel;
    MenuPageControl: TPageControl;
    EstoqueTabSheet: TTabSheet;
    AjudaTabSheet: TTabSheet;
    PageControl1: TPageControl;
    EstProdGroupBox: TGroupBox;
    EstProdEnvTermPanel: TPanel;

    RetagAjuBemAction: TAction;

    RetagEstProdAction: TAction;
    RetagEstProdFabrAction: TAction;
    RetagEstProdTipoAction: TAction;
    RetagEstProdUnidAction: TAction;

    RetagEstProdEnviarTermAction: TAction;

    BalloonHint1: TBalloonHint;
    ToolBar3: TToolBar;
    AjuBemToolButton: TToolButton;
    ToolBar4: TToolBar;
    ToolButton2: TToolButton;
    RetagEstProdICMSAction: TAction;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure MenuPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);

    // Aju
    procedure RetagAjuBemActionExecute(Sender: TObject);

    // Est

    // EstProd
    procedure RetagEstProdFabrActionExecute(Sender: TObject);
    procedure RetagEstProdTipoActionExecute(Sender: TObject);
    procedure RetagEstProdUnidActionExecute(Sender: TObject);
    procedure RetagEstProdICMSActionExecute(Sender: TObject);

    procedure RetagEstProdActionExecute(Sender: TObject);
    procedure RetagEstProdEnviarTermActionExecute(Sender: TObject);
  private
    { Private declarations }
    FEstProdFlatBtn: TFlatBtn;
    FEstProdFabrFlatBtn: TFlatBtn;
    FEstProdTipoFlatBtn: TFlatBtn;

    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

    procedure CriaFlatBtns;

    // tab crie
    procedure TabSheetAppCrie(pFunctionTabSheetGetClassName
      : TFunctionTabSheetGetClassName;
      pFunctionTabSheetFormCreate: TFunctionTabSheetFormCreate);

  public
    { Public declarations }
  end;

var
  RetaguardaModuloBasForm: TRetaguardaModuloBasForm;

implementation

{$R *.dfm}

uses App.UI.Retaguarda.ImgDM_u, Sis.Types.Factory, System.Types,
  Sis.Types.strings_u, Sis.UI.IO.Factory, App.UI.TabSheetForm.Factory,
  Sis.UI.Controls.TFlatBtn;

procedure TRetaguardaModuloBasForm.CriaFlatBtns;
const
  BTN_WIDTH = 70;
  BTN_HEIGHT = 42;
  BTN_TOP = 17;
var
  iLeftAtual: integer;
  oParent: TWinControl;
begin
  oParent := EstProdGroupBox;
  iLeftAtual := 2;

  FEstProdFlatBtn := FlatBtnCreate(RetagEstProdAction, oParent,
    iLeftAtual, BTN_TOP, BTN_WIDTH, BTN_HEIGHT);

  FEstProdFabrFlatBtn := FlatBtnCreate(RetagEstProdFabrAction, oParent,
    iLeftAtual, BTN_TOP, BTN_WIDTH, BTN_HEIGHT);

  FEstProdTipoFlatBtn := FlatBtnCreate(RetagEstProdTipoAction, oParent,
    iLeftAtual, BTN_TOP, BTN_WIDTH, BTN_HEIGHT);

  FEstProdTipoFlatBtn := FlatBtnCreate(RetagEstProdUnidAction, oParent,
    iLeftAtual, BTN_TOP, BTN_WIDTH, BTN_HEIGHT);

  FEstProdTipoFlatBtn := FlatBtnCreate(RetagEstProdICMSAction, oParent,
    iLeftAtual, BTN_TOP, BTN_WIDTH, BTN_HEIGHT);

//  FEstProdFabrFlatBtn := TFlatBtn.Create(EstProdGroupBox);
//  FEstProdFabrFlatBtn.Parent := EstProdGroupBox;
//  FEstProdFabrFlatBtn.Left := 2;
//  FEstProdFabrFlatBtn.Top := 17;
//  FEstProdFabrFlatBtn.WIdth := 67;
//  FEstProdFabrFlatBtn.Height := 54;
//  FEstProdFabrFlatBtn.Action := RetagEstProdFabrAction;
end;

procedure TRetaguardaModuloBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  if not Assigned(RetagImgDM) then
  begin
    RetagImgDM := TRetagImgDM.Create(Application);
  end;
  FOutputNotify := BalloonHintOutputCreate(BalloonHint1);

  FFormClassNamesSL := TStringList.Create;
  FContador := ContadorCreate;

  CriaFlatBtns;

  MenuPageControl.ActivePage := EstoqueTabSheet;
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
  TabSheetAppCrie(RetagAjuBemVindoFormGetClassName, RetagAjuBemVindoFormCreate);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdActionExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TRetaguardaModuloBasForm.RetagEstProdEnviarTermActionExecute
  (Sender: TObject);
begin
  inherited;
  //
end;

procedure TRetaguardaModuloBasForm.RetagEstProdFabrActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetAppCrie(RetagEstProdFabrFormGetClassName, RetagEstProdFabrFormCreate);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdICMSActionExecute(
  Sender: TObject);
begin
  inherited;
  TabSheetAppCrie(RetagEstProdICMSFormGetClassName, RetagEstProdICMSFormCreate);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  TabSheetAppCrie(RetagEstProdTipoFormGetClassName, RetagEstProdTipoFormCreate);
end;

procedure TRetaguardaModuloBasForm.RetagEstProdUnidActionExecute(
  Sender: TObject);
begin
  inherited;
  TabSheetAppCrie(RetagEstProdUnidFormGetClassName, RetagEstProdUnidFormCreate);
//  TabSheetAppCrie(RetagEstProdUnidFormGetClassName, RetagEstProdUnidFormCreate);
end;

procedure TRetaguardaModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//  RetagAjuBemAction.Execute;
  RetagEstProdICMSAction.Execute;
//  sleep(150);
//  RetagEstProdFabrAction.Execute;
end;

procedure TRetaguardaModuloBasForm.TabSheetAppCrie(pFunctionTabSheetGetClassName
  : TFunctionTabSheetGetClassName;
  pFunctionTabSheetFormCreate: TFunctionTabSheetFormCreate);
var
  oTabSheet: TTabSheet;
  oTabSheetBasForm: TTabSheetAppBasForm;
  // HintPoint: TPoint;
  sFormClassName: string;
  iPageIndex: Integer;
  //oTRect: TRect;
  iExistenteIndex: Integer;

  oFormOwner: TComponent;
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
begin
  sFormClassName := pFunctionTabSheetGetClassName;

  iExistenteIndex := FFormClassNamesSL.IndexOf(sFormClassName);
  if iExistenteIndex > -1 then
  begin
    oTabSheet := TTabSheet(FFormClassNamesSL.Objects[iExistenteIndex]);
    PageControl1.ActivePage := oTabSheet;

    //iPageIndex := PageControl1.ActivePageIndex;
    // HintPoint := Mouse.CursorPos;
    // oTRect := PageControl1.TabRect(iPageIndex);
    // HintPoint := CenterPoint(oTRect);

    // if HintPoint.X < 20 then
    // HintPoint.X := 20;
    // Dec(HintPoint.Y, 3);

    FOutputNotify.Exibir('Opção já aberta');

    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oAppInfo := AppInfo;
  oSisConfig := SisConfig;

  oTabSheetBasForm := pFunctionTabSheetFormCreate(oFormOwner, FFormClassNamesSL,
    oAppInfo, oSisConfig, DBMS, Output, ProcessLog, FOutputNotify);
  oTabSheetBasForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := oTabSheetBasForm.Titulo;
  oTabSheetBasForm.Show;
end;

end.

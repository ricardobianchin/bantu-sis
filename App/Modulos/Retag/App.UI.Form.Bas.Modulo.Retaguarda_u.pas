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
  Sis.UI.IO.Output.ProcessLog;

type
  TRetaguardaModuloBasForm = class(TModuloBasForm)
    RetagActionList: TActionList;
    MenuPanel: TPanel;
    MenuPageControl: TPageControl;
    EstoqueTabSheet: TTabSheet;
    AjudaTabSheet: TTabSheet;
    PageControl1: TPageControl;
    EstProdGroupBox: TGroupBox;
    EstoqueToolBar: TToolBar;
    EstProdEnvTermPanel: TPanel;

    EstProdFabrToolButton: TToolButton;
    EstProdTipoToolButton: TToolButton;

    RetagAjuBemAction: TAction;

    RetagEstProdFabrAction: TAction;
    RetagEstProdTipoAction: TAction;
    RetagEstProdAction: TAction;
    RetagEstProdEnviarTermAction: TAction;

    BalloonHint1: TBalloonHint;
    ToolBar3: TToolBar;
    AjuBemToolButton: TToolButton;
    ToolBar4: TToolBar;
    ToolButton2: TToolButton;
    ProdToolButton: TToolButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure RetagEstProdTipoActionExecute(Sender: TObject);
    procedure MenuPageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);

    // Aju
    procedure RetagAjuBemActionExecute(Sender: TObject);

    // Est

    // EstProd
    procedure RetagEstProdFabrActionExecute(Sender: TObject);
    procedure RetagEstProdActionExecute(Sender: TObject);
    procedure RetagEstProdEnviarTermActionExecute(Sender: TObject);

  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

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
  Sis.Types.strings_u, Sis.UI.IO.Factory, App.UI.TabSheetForm.Factory;

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

procedure TRetaguardaModuloBasForm.RetagEstProdTipoActionExecute
  (Sender: TObject);
begin
  inherited;
  //
end;

procedure TRetaguardaModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//  RetagAjuBemAction.Execute;
  RetagEstProdFabrAction.Execute;
end;

procedure TRetaguardaModuloBasForm.TabSheetAppCrie(pFunctionTabSheetGetClassName
  : TFunctionTabSheetGetClassName;
  pFunctionTabSheetFormCreate: TFunctionTabSheetFormCreate);
var
  oTabSheet: TTabSheet;
  oTabSheetBasForm: TTabSheetAppBasForm;
//  HintPoint: TPoint;
  sFormClassName: string;
  iPageIndex: Integer;
  oTRect: TRect;
  iExistenteIndex: Integer;

  oFormOwner: TComponent;
begin
  sFormClassName := pFunctionTabSheetGetClassName;

  iExistenteIndex := FFormClassNamesSL.IndexOf(sFormClassName);
  if iExistenteIndex > -1 then
  begin
    oTabSheet := TTabSheet(FFormClassNamesSL.Objects[iExistenteIndex]);
    PageControl1.ActivePage := oTabSheet;
    iPageIndex := PageControl1.ActivePageIndex;

//    HintPoint := Mouse.CursorPos;
//    oTRect := PageControl1.TabRect(iPageIndex);
//    HintPoint := CenterPoint(oTRect);

//    if HintPoint.X < 20 then
//      HintPoint.X := 20;
    // Dec(HintPoint.Y, 3);

    FOutputNotify.Exibir('Opção já aberta');

    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oTabSheetBasForm := pFunctionTabSheetFormCreate(oFormOwner, FFormClassNamesSL,
    AppInfo, SisConfig, DBMS, Output, ProcessLog, FOutputNotify);
  oTabSheetBasForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := oTabSheetBasForm.Titulo;
  oTabSheetBasForm.Show;
end;

end.

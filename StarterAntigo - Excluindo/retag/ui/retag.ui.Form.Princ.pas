unit retag.ui.Form.Princ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, usu_u, Vcl.Buttons
  , bnt.sis.ctrls.FlatBtn, Vcl.GraphUtil, ChildForm_u, Vcl.Imaging.pngimage;

type
  TRetagPrincForm = class(TForm)
    TopoPanel: TPanel;

    TopoToolBar: TToolBar;
    ToolButton1: TToolButton;
    TopoActionList: TActionList;
    FecharAction: TAction;
    LoginAction: TAction;
    LogoffAction: TAction;
    MinimizarAction: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    basePanel: TPanel;
    MenuActionList: TActionList;
    CategoriasAction: TAction;
    ToolsLeftPanel: TPanel;
    UsuLabel: TLabel;
    UsuCategAction: TAction;
    ShowTimer: TTimer;
    PageControl1: TPageControl;
    EstoqueMenuPanel: TPanel;
    EstoqueTitMenuLabel: TLabel;
    SistemaTitMenuLabel: TLabel;
    SistemaMenuPanel: TPanel;
    BalloonHint1: TBalloonHint;
    BalloonCloseTimer: TTimer;
    Label1: TLabel;
    Image2: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MinimizarActionExecute(Sender: TObject);
    procedure FecharActionExecute(Sender: TObject);
    procedure LoginActionExecute(Sender: TObject);
    procedure LogoffActionExecute(Sender: TObject);

    procedure CategoriasActionExecute(Sender: TObject);
    procedure UsuCategActionExecute(Sender: TObject);
    procedure EstoqueTitMenuLabelClick(Sender: TObject);
    procedure SistemaTitMenuLabelClick(Sender: TObject);
    procedure BalloonCloseTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FLoggedIn: boolean;
    Usu: TUsu;
    //FTDI: TTDI;

    EstoqueMenuVis: boolean;
    SistemaMenuVis: boolean;

    EstoqueCategProdFlatBtn: TFlatBtn;
    SistemaUsuCategFlatBtn: TFlatBtn;

    FormClassNames: TStringList;

    procedure SetLoggedIn(const Value: boolean);

    procedure CriaTab(pChildFormClass: TChildFormClass);overload;
    procedure CriaTab(pFormClass: TFormClass);overload;
  public
    destructor Destroy; override;
    { Public declarations }
    property LoggedIn: boolean read FLoggedIn write SetLoggedIn;

  end;

var
  RetagPrincForm: TRetagPrincForm;

implementation

{$R *.dfm}

uses btu.lib.ui.Img.DataModule, btu.sis.di.ui.constants,
  CategoriasChildForm_u, LoginDiagForm_u, retag.ui.form.defaut,
  UsuCatChildForm_u;


function AdjustLuminosity(Color: TColor; LuminosityFactor: Double): TColor;
var
  R, G, B: Byte;
begin
  Color := ColorToRGB(Color);
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);

  if LuminosityFactor < 1 then
  begin
    R := Round(R * LuminosityFactor);
    G := Round(G * LuminosityFactor);
    B := Round(B * LuminosityFactor);
  end
  else
  begin
    R := Round(R + (255 - R) * (LuminosityFactor - 1));
    G := Round(G + (255 - G) * (LuminosityFactor - 1));
    B := Round(B + (255 - B) * (LuminosityFactor - 1));
  end;

  Result := RGB(R, G, B);
end;

function AdjustSaturation(Color: TColor; SaturationFactor: Double): TColor;
var
  H, S, L: Word;
begin
  Color := ColorToRGB(Color);
  ColorRGBToHLS(Color, H, L, S);

  S := Round(S * SaturationFactor);
  if S > 240 then
    S := 240;

  Result := ColorHLSToRGB(H, L, S);
end;


procedure TRetagPrincForm.BalloonCloseTimerTimer(Sender: TObject);
begin
  BalloonHint1.HideHint;
end;

procedure TRetagPrincForm.CategoriasActionExecute(Sender: TObject);
begin
  CriaTab(TCategoriasChildForm);
//  FTDI.MostrarFormulario(TCategoriasChildForm, false);
//  FTDI := TTDI.Create(Self, TFormPadrao);
//  CategoriasChildForm := TCategoriasChildForm.Create(Self);
end;

procedure TRetagPrincForm.CriaTab(pChildFormClass: TChildFormClass);
var
  TabSheet: TTabSheet;
  F: TChildForm;
  HintPoint: TPoint;
begin
  if FormClassNames.IndexOf(UpperCase(pChildFormClass.ClassName))>-1 then
  begin
    BalloonHint1.Title := 'Opção já aberta';
    HintPoint := Mouse.CursorPos;
    if HintPoint.X < 20 then
      HintPoint.X := 20;
    Dec(HintPoint.Y, 3);
    BalloonHint1.ShowHint(HintPoint);
    BalloonCloseTimer.Enabled := false;
    BalloonCloseTimer.Enabled := true;
    exit;
  end;

  TabSheet := TTabSheet.Create(PageControl1);
  TabSheet.PageControl := PageControl1;

  F := pChildFormClass.Create(TabSheet, FormClassNames);
  F.Parent := TabSheet;

  TabSheet.Caption := F.Caption;
  F.Show;

  PageControl1.ActivePage := TabSheet;
end;

procedure TRetagPrincForm.CriaTab(pFormClass: TFormClass);
var
  TabSheet: TTabSheet;
  F: TForm;
begin
  TabSheet := TTabSheet.Create(PageControl1);
  TabSheet.PageControl := PageControl1;

  F := pFormClass.Create(TabSheet);
  F.Parent := TabSheet;

  TabSheet.Caption := F.Caption;
  F.Show;

  PageControl1.ActivePage := TabSheet;
end;

destructor TRetagPrincForm.Destroy;
begin
  FormClassNames.Free;
  inherited;
end;

procedure TRetagPrincForm.EstoqueTitMenuLabelClick(Sender: TObject);
begin
  if SistemaMenuVis then
    SistemaTitMenuLabelClick(SistemaTitMenuLabel);

  if EstoqueMenuVis then
  begin
    EstoqueMenuVis := False;
    EstoqueCategProdFlatBtn.Visible := false;
  end
  else
  begin
    EstoqueMenuVis := True;
    EstoqueCategProdFlatBtn.Visible := true;
  end;
end;

procedure TRetagPrincForm.FecharActionExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TRetagPrincForm.FormCreate(Sender: TObject);
begin
  FormClassNames := TStringList.Create;
  TopoToolBar.Top := 0;
  TopoToolBar.Left := 496;
  SisImgDataModule := TSisImgDataModule.Create(Application);
  TopoPanel.Color := COR_AZUL_VIVO;
  ToolsLeftPanel.Color := COR_AZUL_VIVO;
  UsuLabel.Caption := '';
  Usu := TUsu.Create;
  Usu.UserName := 'ADM';
  Usu.NomeExib := 'Administrador';
  Usu.Password := '123';

end;

procedure TRetagPrincForm.FormDestroy(Sender: TObject);
begin
  Usu.Free;
end;

procedure TRetagPrincForm.FormShow(Sender: TObject);
begin
  FLoggedIn := false;
  LoginAction.Visible := true;
  LogoffAction.Visible := false;

  LoginAction.Execute;
  if not LoggedIn then
    Application.Terminate;
//  FTDI := TTDI.Create(Self, TTabDefaultForm);
//  FTDI.MostrarMenuPopup := False;
//  LoginAction.Execute;

  ShowTimer.Enabled := true;
end;

procedure TRetagPrincForm.LoginActionExecute(Sender: TObject);
begin
  if not LoginDiagForm_u.fezlogin(usu) then
    exit;
  LoggedIn := true;
end;

procedure TRetagPrincForm.LogoffActionExecute(Sender: TObject);
begin
  LoggedIn := false;
  UsuLabel.Caption := '';
end;

procedure TRetagPrincForm.MinimizarActionExecute(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TRetagPrincForm.SetLoggedIn(const Value: boolean);
begin
  if FLoggedIn = Value then
    exit;

  FLoggedIn := Value;
  if Value then
  begin
    LoginAction.Visible := false;
    LogoffAction.Visible := true;
//    CategoriasAction.Enabled := true;
  end
  else
  begin
    LoginAction.Visible := true;
    LogoffAction.Visible := false;
//    CategoriasAction.Enabled := false;
  end;
end;

procedure TRetagPrincForm.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := false;

//  CategoriasAction.Enabled := false;

  CriaTab(TTabDefaultForm);

  EstoqueMenuVis := false;
  EstoqueCategProdFlatBtn := TFlatBtn.Create(EstoqueMenuPanel);
  EstoqueCategProdFlatBtn.Action := CategoriasAction;
  EstoqueCategProdFlatBtn.Visible := false;
  EstoqueCategProdFlatBtn.Left := 0;
  EstoqueCategProdFlatBtn.Top := EstoqueTitMenuLabel.Top + EstoqueTitMenuLabel.Height + 1;
  EstoqueCategProdFlatBtn.Width := EstoqueMenuPanel.Width;
  EstoqueCategProdFlatBtn.Height := 31;

  SistemaMenuVis := false;
  SistemaUsuCategFlatBtn := TFlatBtn.Create(SistemaMenuPanel);
  SistemaUsuCategFlatBtn.Action := UsuCategAction;
  SistemaUsuCategFlatBtn.Visible := false;
  SistemaUsuCategFlatBtn.Left := 0;
  SistemaUsuCategFlatBtn.Top := SistemaTitMenuLabel.Top + SistemaTitMenuLabel.Height + 1;
  SistemaUsuCategFlatBtn.Width := SistemaMenuPanel.Width;
  SistemaUsuCategFlatBtn.Height := 31;

end;

procedure TRetagPrincForm.SistemaTitMenuLabelClick(Sender: TObject);
begin
  if EstoqueMenuVis then
    EstoqueTitMenuLabelClick(EstoqueTitMenuLabel);

  if SistemaMenuVis then
  begin
    SistemaMenuVis := False;
    SistemaUsuCategFlatBtn.Visible := false;
  end
  else
  begin
    SistemaMenuVis := True;
    SistemaUsuCategFlatBtn.Visible := true;
  end;

end;

procedure TRetagPrincForm.UsuCategActionExecute(Sender: TObject);
begin
  CriaTab(TUsuCategChildForm);
//  FTDI.MostrarFormulario(TUsuCategChildForm, false);
end;

end.

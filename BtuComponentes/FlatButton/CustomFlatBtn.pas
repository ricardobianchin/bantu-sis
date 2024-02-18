unit CustomFlatBtn;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics;

type
  TCustomFlatBtn = class(TWinControl)
  private
    { Private declarations }
    FPaintBox1: TPaintBox;
    FCorMoldura: TColor;
    FCorFace: TColor;
    FCorMouseOver: TColor;
    FMouseIn: boolean;
    FMouseDown: boolean;
    FShowCaption: boolean;
    FShowIcon: boolean;

    procedure AjusteControles;
    procedure AjusteTamanho;

    procedure DoPaint(Sender: TObject);

    procedure DoMouseEnter(Sender: TObject);
    procedure DoMouseLeave(Sender: TObject);
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Click(Sender: TObject);

    procedure DesenheBitmap(pTopTexto: integer);
    procedure DesenheCaption(pTopTexto: integer);

  protected
    procedure Resize; override;

    property MouseIn: boolean read FMouseIn;

    { Protected declarations }

  public
    { Public declarations }
    property ShowCaption: boolean read FShowCaption write FShowCaption;
    property ShowIcon: boolean read FShowIcon write FShowIcon;

    constructor Create(AOwner: TComponent); override;

  published
    { Published declarations }
  end;

implementation

uses System.Types, Winapi.Windows, Vcl.ActnList;

{ TCustomFlatBtn }

// procedure TCustomFlatBtn.DoPaint;
// var
// R: T;
// begin
// inherited;
// R := ClientRect; // As dimensões do retângulo são o client rect do componente
// Canvas.Brush.Style := bsSolid; // O brush é solid
// Canvas.Brush.Color := Color; // A cor do preenchimento é a color
// Canvas.Pen.Style := psClear; // O pen é inexistente
// Canvas.Rectangle(R); // Desenha o retânguloend;
//
{ TCustomFlatBtn }

procedure TCustomFlatBtn.AjusteControles;
begin
  Width := 73;
  Height := 25;
  // AjusteTamanho;
  ShowHint := True;
  FPaintBox1.ShowHint := True;
  Color := RGB(49, 53, 65);
//  Color := RGB(77,83,98);

  Font.Color := clWhite;
//  ParentColor := True;
//  FPaintBox1.ParentColor := True;
  StyleElements := [seFont, seClient, seBorder];
//  StyleElements := [];
  FPaintBox1.StyleElements := [seFont, seClient, seBorder];
//  FPaintBox1.StyleElements := [];
end;

procedure TCustomFlatBtn.AjusteTamanho;
var
  R: TRect;
begin
  R := ClientRect; // As dimensões do retângulo são o client rect do componente
  FPaintBox1.SetBounds(R.Left, R.Top, R.Width, R.Bottom);
end;

constructor TCustomFlatBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowCaption := True;
  FShowIcon := True;
//  FCorMoldura := Rgb(0, 120, 215);
//  FCorMoldura := Rgb(60, 167, 255);
  FCorMoldura := Rgb(72, 121, 163);
  // FCorFace: TColor;
  FCorMouseOver := Rgb(225, 225, 225);
  Parent := TWinControl(AOwner);
  // Color := clRed;
  FPaintBox1 := TPaintBox.Create(Self);
  FPaintBox1.Parent := Self;
  FPaintBox1.OnPaint := DoPaint;
  AjusteControles;
  FMouseIn := False;
  FPaintBox1.OnMouseEnter := DoMouseEnter;
  FPaintBox1.OnMouseLeave := DoMouseLeave;
  FPaintBox1.OnMouseDown := DoMouseDown;
  FPaintBox1.OnMouseUp := DoMouseUp;
  FPaintBox1.OnClick := PaintBox1Click;
end;

procedure TCustomFlatBtn.DoPaint(Sender: TObject);
var
  R: TRect;
  AntigoPenColor, AntigoBrushColor: TColor;
  iTopTexto: integer;
begin
  inherited;
  R := ClientRect; // As dimensões do retângulo são o client rect do componente
  FPaintBox1.Canvas.Brush.Style := bsSolid; // O brush é solid
  FPaintBox1.Canvas.Brush.Color := Color; // A cor do preenchimento é a color
  FPaintBox1.Canvas.Pen.Color := FCorMoldura;

  if Focused or MouseIn then
    FPaintBox1.Canvas.Pen.Style := psSolid // psClear; // O pen é inexistente
  else
    FPaintBox1.Canvas.Pen.Style := psClear; // O pen é inexistente

  FPaintBox1.Canvas.Rectangle(R); // Desenha o retângulo

  if FMouseDown then
  begin
    R := Rect(R.Left+2, r.Top+2, r.Width-2, r.Height-2);
    FPaintBox1.Canvas.Pen.Style := psSolid;
    FPaintBox1.Canvas.Brush.Style :=  bsSolid;

    AntigoPenColor := FPaintBox1.Canvas.Pen.Color;
    AntigoBrushColor := FPaintBox1.Canvas.Brush.Color;

    FPaintBox1.Canvas.Brush.Color :=  FCorMoldura;
    FPaintBox1.Canvas.Pen.Color := FCorMoldura;
    FPaintBox1.Canvas.DrawFocusRect(R);

    FPaintBox1.Canvas.Pen.Color := AntigoPenColor;
    FPaintBox1.Canvas.Brush.Color := AntigoBrushColor;

  end;
  iTopTexto := Height - (FPaintBox1.Canvas.TextHeight('X')+2);

  DesenheBitmap(iTopTexto);
  DesenheCaption(iTopTexto);

end;

procedure TCustomFlatBtn.PaintBox1Click(Sender: TObject);
begin
  Click;
end;

procedure TCustomFlatBtn.DesenheBitmap(pTopTexto: integer);
var
  iImgLarg: integer;
  iImgAltu: integer;
  iDif: integer;
  iMargEsq: integer;
  iMargTop: integer;
begin
  if not FShowIcon then
    exit;

  if Action = nil then
    exit;

  if TAction(Action).Images = nil then
    exit;

  iImgLarg := TAction(Action).Images.Width;
  iDif := Width - iImgLarg;
  iMargEsq := iDif div 2;

  iImgAltu := TAction(Action).Images.Height;

  iDif := pTopTexto - iImgAltu - 2;

  iMargTop := iDif div 2 + 2;

  //dsNormal, dsTransparent
  TAction(Action).Images.Draw( FPaintBox1.Canvas, iMargEsq, iMargTop, TAction(Action).ImageIndex, true);
end;

procedure TCustomFlatBtn.DesenheCaption(pTopTexto: integer);
var
  R: TRect;
  sCaption: string;
  cor: tcolor;
begin
  if not FShowCaption then
    exit;
  FPaintBox1.Canvas.Font.Color := clWhite;
  cor := FPaintBox1.Canvas.Font.Color;
  sCaption := Caption;
  R := Rect(2, pTopTexto, Width -2, Height);

  FPaintBox1.Canvas.TextRect(R, sCaption, [tfCenter, tfWordBreak]);
end;

procedure TCustomFlatBtn.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = TMouseButton.mbLeft then
  begin
    if not FMouseDown then
    begin
      FMouseDown := True;
      Repaint;
    end;
  end;
end;

procedure TCustomFlatBtn.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    if FMouseDown then
    begin
      FMouseDown := False;
      Repaint;
    end;
  end;
end;

procedure TCustomFlatBtn.DoMouseEnter(Sender: TObject);
begin
  inherited;
  if not FMouseIn then
  begin
    FMouseIn := True;
    Repaint;
  end;
end;

procedure TCustomFlatBtn.DoMouseLeave(Sender: TObject);
begin
  inherited;
  if FMouseIn then
  begin
    FMouseIn := False;
    Repaint;
  end;
end;

procedure TCustomFlatBtn.Resize;
begin
  inherited;
  AjusteTamanho;
end;

end.

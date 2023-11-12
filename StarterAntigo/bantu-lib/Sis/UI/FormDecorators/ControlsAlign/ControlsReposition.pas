unit ControlsReposition;

interface

uses Vcl.Controls;

procedure RepositionControls(pWinControl: TWinControl; pLeftInicial: integer=1; pTopInicial: integer=1);

implementation

uses System.Math, Vcl.ExtCtrls;

function ControlAceito(pControl: TControl): boolean;
begin
  result := not( pControl is TBoundLabelEx);
  if not result then
    exit;

  result := pControl.Align = alNone;
  if not result then
    exit;
end;

function GetMargSup(pControl: TControl): integer;
var
  le: TLabeledEdit;
begin
  result := 0;

  if pControl is TLabeledEdit then
  begin
    le := pControl as TLabeledEdit;
    if le.LabelPosition = lpAbove then
      result := le.EditLabel.Height + le.LabelSpacing
  end;
end;

function GetMargEsq(pControl: TControl): integer;
var
  le: TLabeledEdit;
begin
  result := 0;

  if pControl is TLabeledEdit then
  begin
    le := pControl as TLabeledEdit;
    if le.LabelPosition = lpLeft then
      result := le.EditLabel.Width + le.LabelSpacing
  end;
end;

procedure RepositionControls(pWinControl: TWinControl; pLeftInicial: integer=1; pTopInicial: integer=1);
var
  CurrLeft, CurrTop, i, MaxLow: Integer;
  Control: TControl;
  ProximoLeft: integer;
  ProximoTop: integer;
  ProximoRight: integer;
  ProximoLow: integer;
begin
  {
  falta fazer
  inicialmente monta um tlist<> com os controls aceitos
  percorrer controls sem ajustá-los
  percorre até ver que estourará o left da linha atual
  saberá o max marg sup e o max low
  todos os controls desta linha terao top := max marg sup
  proxima linha terá top := max low
  cada control que é posicionado, é removido da lista
  }
  CurrLeft := pLeftInicial;
  CurrTop := pTopInicial;
  MaxLow := 0;
  for i := 0 to pWinControl.ControlCount - 1 do
  begin
    Control := pWinControl.Controls[i];
    if not ControlAceito(Control) then
      continue;

    ProximoLeft := CurrLeft + GetMargEsq(Control);
    ProximoTop := CurrTop + GetMargSup(Control);

    ProximoLow := ProximoTop + Control.Height;
    MaxLow := Max(MaxLow, ProximoLow);

    ProximoRight := ProximoLeft + Control.Width + 20;
    if ProximoRight > pWinControl.ClientWidth then
    begin
      CurrLeft := pLeftInicial;
      ProximoLeft := CurrLeft + GetMargEsq(Control);
      CurrTop := MaxLow + 5;
      ProximoTop := CurrTop + GetMargSup(Control);
      MaxLow := 0;
    end;

    Control.Left := ProximoLeft;
    Control.Top := ProximoTop ;

    CurrLeft := ProximoRight;
  end;
end;

end.

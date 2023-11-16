unit ControlsAlign_u;

interface

uses System.Generics.Collections, Vcl.Controls;

type
  TControlsAlign = class
  private
    FWinControlsList: TList<TWinControl>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PegarWinControl(pWinControl: TWinControl);
    procedure Execute;
  end;

implementation

uses controls.reposition;

{ TControlsAlign }

constructor TControlsAlign.Create;
begin
  FWinControlsList := TList<TWinControl>.Create;
end;

destructor TControlsAlign.Destroy;
begin
  FWinControlsList.Free;
  inherited;
end;

procedure TControlsAlign.Execute;
var
  wc: TWinControl;
begin
  for wc in FWinControlsList do
    controls.reposition.RepositionControls(wc);
end;

procedure TControlsAlign.PegarWinControl(pWinControl: TWinControl);
begin
  FWinControlsList.Add(pWinControl);
end;

end.

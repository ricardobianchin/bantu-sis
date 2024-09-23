unit Sis.UI.Controls.Alinhador.ADireita_u;

interface

uses Vcl.Controls, Sis.UI.Controls.Alinhador_u, System.Generics.Collections;

type
  TControlsAlinhadorADireita = class(TControlsAlinhador)
  public
    procedure Execute; override;
  end;

implementation

{ TControlsAlinhadorADireita }

procedure TControlsAlinhadorADireita.Execute;
var
  oParent: TWinControl;
  c: TControl;
  iX: integer;
  i: integer;
begin
  if ControlsList.Count = 0 then
    Exit;

  oParent := TWinControl(ControlsList[0].Parent);

  iX := oParent.Width;

//  for i := ControlsList.Count -1 downto 0 do
  for i := 0 to ControlsList.Count -1 do
  begin
    c := ControlsList[i];
    Dec(iX, (c.Width + 5));
    c.Left := iX;
  end;
end;

end.

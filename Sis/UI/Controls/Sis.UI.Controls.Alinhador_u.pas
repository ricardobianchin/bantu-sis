unit Sis.UI.Controls.Alinhador_u;

interface

uses Vcl.Controls, Sis.UI.Controls.Alinhador, System.Generics.Collections;

type
  TControlsAlinhador = class(TInterfacedObject, IControlsAlinhador)
  private
    FControlsList: TList<TControl>;
  protected
    property ControlsList: TList<TControl> read FControlsList;
  public
    procedure PegarControl(pControl: TControl);
    procedure Execute; virtual; abstract;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TControlsAlinhador }

constructor TControlsAlinhador.Create;
begin
  FControlsList := TList<TControl>.Create;
end;

destructor TControlsAlinhador.Destroy;
begin
  FControlsList.Free;
  inherited;
end;

procedure TControlsAlinhador.PegarControl(pControl: TControl);
begin
  FControlsList.Add(pControl);
end;

end.

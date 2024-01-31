unit Sis.Types.Contador_u;

interface

uses Sis.Types.Contador;

type
  TContador = class(TInterfacedObject, IContador)
  private
    FValue: Cardinal;
  public
    procedure Reset;
    function GetNext: Cardinal;
    constructor Create;
  end;

implementation

{ TContador }

constructor TContador.Create;
begin
  Reset;
end;

function TContador.GetNext: Cardinal;
begin
  Result := FValue;
  Inc(FValue);
end;

procedure TContador.Reset;
begin
  FValue := 0;
end;

end.

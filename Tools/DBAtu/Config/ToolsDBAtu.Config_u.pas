unit ToolsDBAtu.Config_u;

interface

uses
  ToolsDBAtu.Config;

type
  TToolsDBAtuConfig = class(TInterfacedObject, IToolsDBAtuConfig)
  private
    FArqTypeBalancaPas: string;
    function GetArqTypeBalancaPas: string;
    procedure SetArqTypeBalancaPas(const Value: string);
  public
    property ArqTypeBalancaPas: string read GetArqTypeBalancaPas write SetArqTypeBalancaPas;
  end;

implementation

{ TToolsDBAtuConfig }

function TToolsDBAtuConfig.GetArqTypeBalancaPas: string;
begin
  Result := FArqTypeBalancaPas;
end;

procedure TToolsDBAtuConfig.SetArqTypeBalancaPas(const Value: string);
begin
  FArqTypeBalancaPas := Value;
end;

end.

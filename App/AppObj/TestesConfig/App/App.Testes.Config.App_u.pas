unit App.Testes.Config.App_u;

interface

uses App.Testes.Config.App;

type
  TTesteConfigApp = class(TInterfacedObject, ITesteConfigApp)
  private
    FExecsAtu: boolean;
    function GetExecsAtu: boolean;
    procedure SetExecsAtu(Value: boolean);
  public
    property ExecsAtu: boolean read GetExecsAtu write SetExecsAtu;
    constructor Create;
  end;

implementation

{ TTesteConfigApp }

constructor TTesteConfigApp.Create;
begin
  FExecsAtu := True;
end;

function TTesteConfigApp.GetExecsAtu: boolean;
begin
  Result := FExecsAtu;
end;

procedure TTesteConfigApp.SetExecsAtu(Value: boolean);
begin
  FExecsAtu := Value;
end;

end.

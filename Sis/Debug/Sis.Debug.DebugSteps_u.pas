unit Sis.Debug.DebugSteps_u;

interface

uses Sis.Debug.DebugSteps, Sis.Sis.Executavel_u;

type
  TDebugSteps = class(TExecutavel, IDebugSteps)
  private
    FTeclas: string;
    FNomeArqSteps: string;

    function GetTeclas: string;
    procedure SetTeclas(const Value: string);

  protected
    function GetRootNodeName: string; virtual; abstract;
    function GetNomeArqSteps: string;
    procedure SetNomeArqSteps(Values: string);

  public
    property RootNodeName: string read GetRootNodeName;
    property Teclas: string read GetTeclas write SetTeclas;
    property NomeArqSteps: string read GetNomeArqSteps write SetNomeArqSteps;
  end;

implementation

{ TDebugSteps }

function TDebugSteps.GetNomeArqSteps: string;
begin
  Result := FNomeArqSteps;
end;

function TDebugSteps.GetTeclas: string;
begin
  Result := FTeclas;
end;

procedure TDebugSteps.SetNomeArqSteps(Values: string);
begin
  FNomeArqSteps := Values;
end;

procedure TDebugSteps.SetTeclas(const Value: string);
begin
  FTeclas := Value;
end;

end.

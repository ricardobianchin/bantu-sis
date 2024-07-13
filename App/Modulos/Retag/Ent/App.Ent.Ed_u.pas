unit App.Ent.Ed_u;

interface

uses App.Ent.Ed, Data.DB, Sis.Entidade_u, App.DB.Utils;

type
  TEntEd = class(TEntidade, IEntEd)
  private
    FState: TDataSetState;

    function GetState: TDataSetState;
    procedure SetState(Value: TDataSetState);

    function GetStateAsTitulo: string;
  public
    property State: TDataSetState read GetState write SetState;
    property StateAsTitulo: string read GetStateAsTitulo;
    constructor Create(pState: TDataSetState);
  end;

implementation

{ TEntEd }

constructor TEntEd.Create(pState: TDataSetState);
begin
  inherited Create;
  FState := pState;
end;

function TEntEd.GetState: TDataSetState;
begin
  Result := FState;
end;

function TEntEd.GetStateAsTitulo: string;
begin
  Result := DataSetStateToTitulo(FState);
end;

procedure TEntEd.SetState(Value: TDataSetState);
begin
  FState := Value;
end;

end.

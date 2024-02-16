unit App.Entidade.Ed_u;

interface

uses App.Entidade.Ed, Data.DB, Sis.Entidade_u;

type
  TEntEd = class(TEntidade, IEntEd)
  private
    FState: TDataSetState;
    function GetState: TDataSetState;
  public
    property State: TDataSetState read GetState;
    constructor Create(pState: TDataSetState);
  end;

implementation

{ TEntEd }

constructor TEntEd.Create(pState: TDataSetState);
begin
  FState := pState;
end;

function TEntEd.GetState: TDataSetState;
begin
  Result := FState;
end;

end.

unit App.Entidade.Ed_u;

interface

uses App.Entidade.Ed, Data.DB, Sis.Entidade_u;

type
  TEntidadeEd = class(TEntidade, IEntidadeEd)
  private
    FState: TDataSetState;
    function GetState: TDataSetState;
  public
    property State: TDataSetState read GetState;
    constructor Create(pState: TDataSetState);
  end;

implementation

{ TEntidadeEd }

constructor TEntidadeEd.Create(pState: TDataSetState);
begin
  FState := pState;
end;

function TEntidadeEd.GetState: TDataSetState;
begin
  Result := FState;
end;

end.

unit App.Retag.Est.Prod.Unid.Ent_u;

interface

uses App.Retag.Est.Prod.Unid.Ent, App.Ent.Ed.Id_u, Data.DB, Sis.DB.DBTypes;

type
  TProdUnidEnt = class(TEntEdId, IProdUnidEnt)
  private
    FDescr: string;
    FSigla: string;

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetSigla: string;
    procedure SetSigla(Value: string);
  public
    property Descr: string read GetDescr write SetDescr;
    property Sigla: string read GetSigla write SetSigla;

    constructor Create(pState: TDataSetState; pId: integer = 0; pDescr: string = ''; pSigla: string = '');
  end;

implementation

{ TProdUnidEnt }

constructor TProdUnidEnt.Create(pState: TDataSetState; pId: integer; pDescr,
  pSigla: string);
begin
  inherited Create(State, pId);
  FDescr := pDescr;
  FSigla := pSigla;
end;

function TProdUnidEnt.GetDescr: string;
begin
  Result := FDescr;
end;

function TProdUnidEnt.GetSigla: string;
begin
  Result := FSigla;
end;

procedure TProdUnidEnt.SetDescr(Value: string);
begin
  FDescr := Value;
end;

procedure TProdUnidEnt.SetSigla(Value: string);
begin
  FSigla := Value;
end;

end.

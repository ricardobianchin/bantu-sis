unit App.Retag.Est.Prod.Fabr_u;

interface

uses App.Retag.Est.Prod.Fabr;

type
  TProdFabr = class(TInterfacedObject, IProdFabr)
  private
    FId: smallint;
    FNome: string;

    function GetId: smallint;
    procedure SetId(const Value: smallint);

    function GetNome: string;
    procedure SetNome(const Value: string);
  public
    property Id: smallint read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    constructor Create;
    procedure Clear;
  end;

implementation

{ TProdFabr }

procedure TProdFabr.Clear;
begin
  FId := 0;
  FNome := '';
end;

constructor TProdFabr.Create;
begin
  Clear;
end;

function TProdFabr.GetId: smallint;
begin
  Result := FId;
end;

function TProdFabr.GetNome: string;
begin
  Result := FNome;
end;

procedure TProdFabr.SetId(const Value: smallint);
begin
  FId := Value;
end;

procedure TProdFabr.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.

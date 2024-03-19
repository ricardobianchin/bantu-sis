unit App.Retag.Est.Prod.Balanca.Ent_u;

interface

uses App.Retag.Est.Prod.Balanca.Ent, App.Est.Types_u;

type
  TProdBalancaEnt = class(TInterfacedObject, IProdBalancaEnt)
  private
    FBalancaTipo: TBalancaTipo;
    FDptoCod: smallint;
    FValidadeDias: smallint;
    FTextoEtiq: string;

    function GetBalancaTipo: TBalancaTipo;
    procedure SetBalancaTipo(Value: TBalancaTipo);

    function GetDptoCod: smallint;
    procedure SetDptoCod(Value: smallint);

    function GetValidadeDias: smallint;
    procedure SetValidadeDias(Value: smallint);

    function GetTextoEtiq: string;
    procedure SetTextoEtiq(Value: string);

  public
    property BalancaTipo: TBalancaTipo read GetBalancaTipo write SetBalancaTipo;
    property DptoCod: smallint read GetDptoCod write SetDptoCod;
    property ValidadeDias: smallint read GetValidadeDias write SetValidadeDias;
    property TextoEtiq: string read GetTextoEtiq write SetTextoEtiq;

    procedure LimparEnt;
  end;

implementation

{ TProdBalancaEnt }

function TProdBalancaEnt.GetDptoCod: smallint;
begin
  Result := FDptoCod;
end;

function TProdBalancaEnt.GetBalancaTipo: TBalancaTipo;
begin
  Result := FBalancaTipo;
end;

function TProdBalancaEnt.GetTextoEtiq: string;
begin
  Result := FTextoEtiq;
end;

function TProdBalancaEnt.GetValidadeDias: smallint;
begin
  Result := FValidadeDias;
end;

procedure TProdBalancaEnt.LimparEnt;
begin
  FBalancaTipo := TBalancaTipo.baltNaoUtiliza;
  FDptoCod := 0;
  FValidadeDias := 0;
  FTextoEtiq := '';
end;

procedure TProdBalancaEnt.SetBalancaTipo(Value: TBalancaTipo);
begin
  FBalancaTipo := Value;
end;

procedure TProdBalancaEnt.SetDptoCod(Value: smallint);
begin
  FDptoCod := Value;
end;

procedure TProdBalancaEnt.SetTextoEtiq(Value: string);
begin
  FTextoEtiq := Value;
end;

procedure TProdBalancaEnt.SetValidadeDias(Value: smallint);
begin
  FValidadeDias := Value;
end;

end.

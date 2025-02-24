unit App.Retag.Est.Prod.Balanca.Ent_u;

interface

uses App.Retag.Est.Prod.Balanca.Ent, App.Est.Types_u;

type
  TProdBalancaEnt = class(TInterfacedObject, IProdBalancaEnt)
  private
    FBalancaExige: Boolean;
    FDptoCod: string;
    FValidadeDias: smallint;
    FTextoEtiq: string;

    function GetBalancaExige: Boolean;
    procedure SetBalancaExige(Value: Boolean);

    function GetDptoCod: string;
    procedure SetDptoCod(Value: string);

    function GetValidadeDias: smallint;
    procedure SetValidadeDias(Value: smallint);

    function GetTextoEtiq: string;
    procedure SetTextoEtiq(Value: string);

  public
    property BalancaExige: Boolean read GetBalancaExige write SetBalancaExige;
    property DptoCod: string read GetDptoCod write SetDptoCod;
    property ValidadeDias: smallint read GetValidadeDias write SetValidadeDias;
    property TextoEtiq: string read GetTextoEtiq write SetTextoEtiq;

    procedure LimparEnt;
  end;

implementation

uses System.SysUtils;

{ TProdBalancaEnt }

function TProdBalancaEnt.GetDptoCod: string;
begin
  Result := FDptoCod;
end;

function TProdBalancaEnt.GetBalancaExige: Boolean;
begin
  Result := FBalancaExige;
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
  FBalancaExige := False;
  FDptoCod := '001';
  FValidadeDias := 0;
  FTextoEtiq := '';
end;

procedure TProdBalancaEnt.SetBalancaExige(Value: Boolean);
begin
  FBalancaExige := Value;
end;

procedure TProdBalancaEnt.SetDptoCod(Value: string);
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

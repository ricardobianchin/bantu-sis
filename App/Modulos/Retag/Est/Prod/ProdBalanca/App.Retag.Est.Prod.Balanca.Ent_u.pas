unit App.Retag.Est.Prod.Balanca.Ent_u;

interface

uses App.Retag.Est.Prod.Balanca.Ent, App.Est.Types_u;

type
  TProdBalancaEnt = class(TInterfacedObject, IProdBalancaEnt)
  private
    FBalancaUso: TBalancaUso;
    FDptoCod: string;
    FValidadeDias: smallint;
    FTextoEtiq: string;

    function GetBalancaUso: TBalancaUso;
    procedure SetBalancaUso(Value: TBalancaUso);

    function GetDptoCod: string;
    procedure SetDptoCod(Value: string);

    function GetValidadeDias: smallint;
    procedure SetValidadeDias(Value: smallint);

    function GetTextoEtiq: string;
    procedure SetTextoEtiq(Value: string);

    function GetBalancaUsoStr: string;
  public
    property BalancaUso: TBalancaUso read GetBalancaUso write SetBalancaUso;
    property DptoCod: string read GetDptoCod write SetDptoCod;
    property ValidadeDias: smallint read GetValidadeDias write SetValidadeDias;
    property TextoEtiq: string read GetTextoEtiq write SetTextoEtiq;

    procedure LimparEnt;
    property BalancaUsoStr: string read GetBalancaUsoStr;
  end;

implementation

uses System.SysUtils;

{ TProdBalancaEnt }

function TProdBalancaEnt.GetBalancaUsoStr: string;
begin
  Result := Integer(FBalancaUso).ToString;
end;

function TProdBalancaEnt.GetDptoCod: string;
begin
  Result := FDptoCod;
end;

function TProdBalancaEnt.GetBalancaUso: TBalancaUso;
begin
  Result := FBalancaUso;
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
  FBalancaUso := TBalancaUso.baltNaoUtiliza;
  FDptoCod := '001';
  FValidadeDias := 0;
  FTextoEtiq := '';
end;

procedure TProdBalancaEnt.SetBalancaUso(Value: TBalancaUso);
begin
  FBalancaUso := Value;
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

unit App.FIn.PagFormaTipo_u;

interface

uses Sis.Lists.HashItem_u, App.FIn.PagFormaTipo;

type
  TPagFormaTipo = class(THashItem, IPagFormaTipo)
  private
    FDescrRed: string;
    FAtivo: Boolean;

    function GetDescrRed: string;
    procedure SetDescrRed(const Value: string);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);

  protected

  public
    procedure Zerar; override;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property DescrRed: string read GetDescrRed write SetDescrRed;
    constructor Create(pDescr: string = ''; pDescrRed: string = '';
      pAtivo: Boolean = True; pId: integer = 0);

  end;

implementation

{ TPagFormaTipo }

constructor TPagFormaTipo.Create(pDescr, pDescrRed: string; pAtivo: Boolean;
  pId: integer);
begin
  inherited Create(pDescr, pId);
  FDescrRed := pDescrRed;
  FAtivo := pAtivo;
end;

function TPagFormaTipo.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TPagFormaTipo.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

procedure TPagFormaTipo.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TPagFormaTipo.SetDescrRed(const Value: string);
begin
  FDescrRed := Value;
end;

procedure TPagFormaTipo.Zerar;
begin
  inherited;
  SetDescrRed('');
  SetAtivo(True);
end;

end.

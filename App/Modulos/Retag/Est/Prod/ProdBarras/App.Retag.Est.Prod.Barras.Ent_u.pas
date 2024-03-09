unit App.Retag.Est.Prod.Barras.Ent_u;

interface

uses App.Retag.Est.Prod.Barras.Ent;

type
  TProdBarras = class(TInterfacedObject, IProdBarras)
  private
    FOrdem: smallint;
    FBarras: string;

    function GetOrdem: smallint;
    procedure SetOrdem(Value: smallInt);

    function GetBarras: string;
    procedure SetBarras(Value: string);
  public
    property Ordem: smallint read GetOrdem write SetOrdem;
    property Barras: string read GetBarras write SetBarras;

    constructor Create(pOrdem: smallint = 0; pBarras: string = '');
  end;

implementation

{ TProdBarras }

constructor TProdBarras.Create(pOrdem: smallint; pBarras: string);
begin
  FOrdem := pOrdem;
  FBarras := pBarras;
end;

function TProdBarras.GetBarras: string;
begin
  Result := FBarras;
end;

function TProdBarras.GetOrdem: smallint;
begin
  Result := FOrdem;
end;

procedure TProdBarras.SetBarras(Value: string);
begin
  FBarras := Value;
end;

procedure TProdBarras.SetOrdem(Value: smallInt);
begin
  FOrdem := Value;
end;

end.

unit App.Retag.Est.Prod.Natu.Ent_u;

interface

uses App.Retag.Est.Prod.Natu.Ent;

type
  TProdNatuEnt = class(TInterfacedObject, IProdNatuEnt)
  private
    FId: char;
    FNome: string;

    function GetId: char;
    procedure SetId(const Value: char);

    function GetNome: string;
    procedure SetNome(const Value: string);
  public
    property Id: char read GetId write SetId;
    property Nome: string read GetNome write SetNome;

    constructor Create(pId: char = #0; pNome: string = 'NAO INDICADO');
  end;

implementation

{ TProdNatuEnt }

constructor TProdNatuEnt.Create(pId: char; pNome: string);
begin
  inherited Create;
  FId := pId;
  FNome := pNome;
end;

function TProdNatuEnt.GetId: char;
begin
  Result := FId;
end;

function TProdNatuEnt.GetNome: string;
begin
  Result := FNome;
end;

procedure TProdNatuEnt.SetId(const Value: char);
begin
  FId := Value;
end;

procedure TProdNatuEnt.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.

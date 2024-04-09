unit App.Retag.Est.Prod.Natu.Ent_u;

interface

uses App.Retag.Est.Prod.Natu.Ent, Sis.Entidade_u;

type
  TProdNatuEnt = class(TEntidade, IProdNatuEnt)
  private
    FId: char;
    FNome: string;

    function GetId: char;
    procedure SetId(const Value: char);

    function GetNome: string;
    procedure SetNome(const Value: string);
  protected
    function GetNomeEnt: string; override;
    function GetTitulo: string; override;
    function GetNomeEntAbrev: string; override;
    function GetAsStringExib: string; override;
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

function TProdNatuEnt.GetAsStringExib: string;
begin
  Result := FNome;
end;

function TProdNatuEnt.GetId: char;
begin
  Result := FId;
end;

function TProdNatuEnt.GetNome: string;
begin
  Result := FNome;
end;

function TProdNatuEnt.GetNomeEnt: string;
begin
  Result := 'Natureza do Item de Estoque';
end;

function TProdNatuEnt.GetNomeEntAbrev: string;
begin
  Result := 'ProdNatu';
end;

function TProdNatuEnt.GetTitulo: string;
begin
  Result := 'Naturezas dos Itens de Estoque';
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

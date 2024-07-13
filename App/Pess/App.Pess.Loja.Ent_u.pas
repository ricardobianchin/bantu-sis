unit App.Pess.Loja.Ent_u;

interface

uses App.Pess.Loja.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessLojaEnt = class(TPessEnt, IPessLojaEnt)
  private
    FAtivo: boolean;

    function GetAtivo: boolean;
    procedure SetAtivo(const Value: boolean);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
  public
    property Ativo: boolean read GetAtivo write SetAtivo;

    constructor Create(pPessEnderList: IPessEnderList);
    procedure LimparEnt; override;
  end;

implementation

uses Data.DB;

{ TPessLojaEnt }

constructor TPessLojaEnt.Create(pPessEnderList: IPessEnderList);
begin
  inherited Create(dsBrowse, pPessEnderList,
    TEnderQuantidadePermitida.endqtdUm, False);
end;

function TPessLojaEnt.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

function TPessLojaEnt.GetNomeEnt: string;
begin
  Result := 'Estabelecimento';
end;

function TPessLojaEnt.GetNomeEntAbrev: string;
begin
  Result := 'Estabel.';
end;

function TPessLojaEnt.GetTitulo: string;
begin
  Result := 'Estabelecimentos';
end;

procedure TPessLojaEnt.LimparEnt;
begin
  inherited;
  FAtivo := False;
end;

procedure TPessLojaEnt.SetAtivo(const Value: boolean);
begin
  FAtivo := Value;
end;

end.

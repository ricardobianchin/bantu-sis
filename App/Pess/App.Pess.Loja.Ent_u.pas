unit App.Pess.Loja.Ent_u;

interface

uses App.Pess.Loja.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Types;

type
  TPessLojaEnt = class(TPessEnt, IPessLojaEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
  public
    constructor Create(pPessEnderList: IPessEnderList);
    procedure LimparEnt; override;
  end;

implementation

uses Data.DB;

{ TPessLojaEnt }

constructor TPessLojaEnt.Create(pPessEnderList: IPessEnderList);
begin
  inherited Create(dsBrowse, pPessEnderList,
    TEnderQuantidadePermitida.endqtdUm);
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
  //
end;

end.

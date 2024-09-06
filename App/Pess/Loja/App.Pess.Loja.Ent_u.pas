unit App.Pess.Loja.Ent_u;

interface

uses App.Pess.Loja.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessLojaEnt = class(TPessEnt, IPessLojaEnt)
  private
    FSelecionado: boolean;

    function GetSelecionado: boolean;
    procedure SetSelecionado(const Value: boolean);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property Selecionado: boolean read GetSelecionado write SetSelecionado;

    procedure LimparEnt; override;
  end;

implementation

uses Data.DB;

{ TPessLojaEnt }

function TPessLojaEnt.GetSelecionado: boolean;
begin
  Result := FSelecionado;
end;

function TPessLojaEnt.GetNomeEnt: string;
begin
  Result := 'Estabelecimento';
end;

function TPessLojaEnt.GetNomeEntAbrev: string;
begin
  Result := 'Estabel';
end;

function TPessLojaEnt.GetTitulo: string;
begin
  Result := 'Estabelecimentos';
end;

procedure TPessLojaEnt.LimparEnt;
begin
  inherited;
  LojaId := 0; // : smallint;
  FSelecionado := False;
end;

procedure TPessLojaEnt.SetSelecionado(const Value: boolean);
begin
  FSelecionado := Value;
end;

end.

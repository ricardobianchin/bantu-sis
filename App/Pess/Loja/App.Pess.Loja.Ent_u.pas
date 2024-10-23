unit App.Pess.Loja.Ent_u;

interface

uses App.Pess.Loja.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessLojaEnt = class(TPessEnt, IPessLojaEnt)
  private
    FSelecionado: boolean;
    FLogLojaId: smallint;
    function GetSelecionado: boolean;
    procedure SetSelecionado(const Value: boolean);

    function GetLogLojaId: smallint;
    procedure SetLogLojaId(const Value: smallint);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property LogLojaId: smallint read GetLogLojaId write SetLogLojaId;
    property Selecionado: boolean read GetSelecionado write SetSelecionado;

    procedure LimparEnt; override;

    constructor Create( //
      pLogLojaId: smallint;//
      pLojaId: smallint;//
      pUsuarioId: integer; //
      pMachineIdentId: smallint; //
      pPessEnderList: IPessEnderList //
      ); //

  end;

implementation

uses Data.DB;

{ TPessLojaEnt }

function TPessLojaEnt.GetSelecionado: boolean;
begin
  Result := FSelecionado;
end;

constructor TPessLojaEnt.Create(pLogLojaId, pLojaId: smallint;
  pUsuarioId: integer; pMachineIdentId: smallint;
  pPessEnderList: IPessEnderList);
begin
  inherited Create(pLojaId, pUsuarioId, pMachineIdentId, pPessEnderList);
  FLogLojaId := pLogLojaId;
end;

function TPessLojaEnt.GetLogLojaId: smallint;
begin
  Result := FLogLojaId;
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

procedure TPessLojaEnt.SetLogLojaId(const Value: smallint);
begin
  FLogLojaId := Value;
end;

procedure TPessLojaEnt.SetSelecionado(const Value: boolean);
begin
  FSelecionado := Value;
end;

end.

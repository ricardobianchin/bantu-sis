unit App.Sessao.Criador.List_u;

interface

uses System.Classes, App.Sessao.Criador, App.Sessao.Criador.List;

type
  TSessaoCriadorList = class(TInterfaceList, ISessaoCriadorList)
  private
    function GetsessaoCriador(Index: integer): ISessaoCriador;
  public
    property SessaoCriador[Index: integer]: ISessaoCriador read GetsessaoCriador; default;

    procedure PegarSessaoCriador(pSessaoCriador: ISessaoCriador);
  end;



implementation

{ TSessaoCriadorList }

function TSessaoCriadorList.GetsessaoCriador(Index: integer): ISessaoCriador;
begin
  Result := ISessaoCriador(Items[Index]);
end;

procedure TSessaoCriadorList.PegarSessaoCriador(pSessaoCriador: ISessaoCriador);
begin
  Add(pSessaoCriador);
end;

end.

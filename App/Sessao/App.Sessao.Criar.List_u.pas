unit App.Sessao.Criar.List_u;

interface

uses System.Classes, App.Sessao.Criar, App.Sessao.Criar.List;

type
  TSessaoCriarList = class(TInterfaceList, ISessaoCriarList)
  private
    function GetsessaoCriar(Index: integer): ISessaoCriar;
  public
    property SessaoCriar[Index: integer]: ISessaoCriar read GetsessaoCriar;

    procedure PegarSessaoCriar(pSessaoCriar: ISessaoCriar);
  end;



implementation

{ TSessaoCriarList }

function TSessaoCriarList.GetsessaoCriar(Index: integer): ISessaoCriar;
begin
  Result := ISessaoCriar(Items[Index]);
end;

procedure TSessaoCriarList.PegarSessaoCriar(pSessaoCriar: ISessaoCriar);
begin
  Add(pSessaoCriar);
end;

end.

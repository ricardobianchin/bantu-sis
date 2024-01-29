unit App.Sessao.List_u;

interface

uses System.Classes, App.Sessao, App.Sessao.List;

type
  TSessaoList = class(TInterfaceList, ISessaoList)
  private
    function GetSessao(Index: integer): ISessao;
  public
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    procedure PegarSessao(pSessao: ISessao);
  end;

implementation

{ TSessaoList }

function TSessaoList.GetSessao(Index: integer): ISessao;
begin
  Result := ISessao(Items[Index]);
end;

procedure TSessaoList.PegarSessao(pSessao: ISessao);
begin
  Add(pSessao);
end;

end.

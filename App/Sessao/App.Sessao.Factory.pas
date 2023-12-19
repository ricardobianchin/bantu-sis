unit App.Sessao.Factory;

interface

uses App.Sessao.Criar.List;

function SessaoCriarListCreate: ISessaoCriarList;

implementation

uses App.Sessao.Criar.List_u;

function SessaoCriarListCreate: ISessaoCriarList;
begin
  Result := TSessaoCriarList.Create;
end;

end.

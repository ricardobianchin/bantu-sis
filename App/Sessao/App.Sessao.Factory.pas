unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List;

function SessaoCriadorListCreate: ISessaoCriadorList;

implementation

uses App.Sessao.Criador.List_u;

function SessaoCriadorListCreate: ISessaoCriadorList;
begin
  Result := TSessaoCriadorList.Create;
end;

end.

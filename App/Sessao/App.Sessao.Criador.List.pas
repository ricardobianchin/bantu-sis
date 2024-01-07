unit App.Sessao.Criador.List;

interface

uses System.Classes, App.Sessao.Criador;

type
  ISessaoCriadorList = interface(IInterfaceList)
    ['{495E6CFE-E32E-4283-9E7F-2B2B0DCA421C}']
    function GetsessaoCriador(Index: integer): ISessaoCriador;
    property SessaoCriador[Index: integer]: ISessaoCriador read GetSessaoCriador;

    procedure PegarSessaoCriador(pSessaoCriador: ISessaoCriador);
  end;

implementation

end.

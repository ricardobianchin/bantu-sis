unit App.Sessao.Criar.List;

interface

uses System.Classes, App.Sessao.Criar;

type
  ISessaoCriarList = interface(IInterfaceList)
    ['{495E6CFE-E32E-4283-9E7F-2B2B0DCA421C}']
    function GetsessaoCriar(Index: integer): ISessaoCriar;
    property SessaoCriar[Index: integer]: ISessaoCriar read GetsessaoCriar;

    procedure PegarSessaoCriar(pSessaoCriar: ISessaoCriar);
  end;

implementation

end.

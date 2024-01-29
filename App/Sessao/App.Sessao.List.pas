unit App.Sessao.List;

interface

uses System.Classes, App.Sessao;

type
  ISessaoList = interface(IInterfaceList)
    ['{69E01122-D7EB-4B96-9805-028068147313}']

    function GetSessao(Index: integer): ISessao;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    procedure PegarSessao(pSessao: ISessao);
  end;

implementation

end.

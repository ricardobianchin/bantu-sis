unit App.Sessao.List;

interface

uses App.Sessao;

type
  ISessaoList = interface(IInterface)
    ['{69E01122-D7EB-4B96-9805-028068147313}']

    function GetSessao(Index: integer): ISessao;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    function GetCount: integer;
    property Count: integer read GetCount;

    function GetSessaoByIndex(pIndex: Cardinal): ISessao;

    procedure DeleteByIndex(pIndex: Cardinal);

  end;

implementation

end.

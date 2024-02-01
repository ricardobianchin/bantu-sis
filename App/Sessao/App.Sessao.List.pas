unit App.Sessao.List;

interface

uses App.Sessao, App.Constants;

type
  ISessaoList = interface(IInterface)
    ['{69E01122-D7EB-4B96-9805-028068147313}']

    function GetSessao(Index: integer): ISessao;
    property Sessao[Index: integer]: ISessao read GetSessao; default;

    function GetCount: integer;
    property Count: integer read GetCount;

    procedure DeleteByIndex(pIndex: TSessaoIndex);

    function GetSessaoByIndex(pIndex: TSessaoIndex): ISessao;
    function GetSessaoVisivelIndex: TSessaoIndex;
  end;

implementation

end.

unit Sis.Sis.Nomeavel;

interface

type
  INomeavel = interface(IInterface)
    ['{F6565727-DD53-441E-8A8A-6DED1B5A55CA}']
    function GetNome: string;
    property Nome: string read GetNome;
  end;

implementation

end.

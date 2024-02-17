unit Sis.Lists.Lista;

interface

type
  ILista=interface(IInterface)
    ['{44FE5A38-E175-478E-AFD0-60A6561B6EDE}']
    procedure Clear;

    function GetCount:integer;
    property Count:integer read GetCount;
  end;

implementation

end.

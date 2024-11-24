unit Sis.Lists.IdCharItem;

interface

type
  IIdCharItem = interface(IInterface)
    ['{46806D56-873A-4C5B-96AA-8C831E9BB9C9}']
    function GetId: Char;
    procedure SetId(Value: Char);
    property Id: Char read GetId write SetId;
  end;

implementation

end.

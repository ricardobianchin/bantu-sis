unit btu.lib.lists.IdItem_i;

interface

type
  IIdItem=interface(IInterface)
    procedure SetId(Value:integer);
    function GetId:integer;
    property Id:integer read GetId write SetId;
    function IgualA(pId:integer):boolean;overload;
    function IgualA(pIdItem:IIdItem):boolean;overload;
    procedure Pegar(pId: Integer);
    procedure PegarDe( pIdItem:IIdItem);
    procedure Zerar;
    function GetToStrZero(pNCasas:integer=0):string;
  end;

implementation

end.

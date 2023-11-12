unit btu.lib.lists.IdItem;

interface

type
  IIdItem=interface(IInterface)
    ['{96FF79B2-FFC5-4E8F-BE40-772C5EC598ED}']
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

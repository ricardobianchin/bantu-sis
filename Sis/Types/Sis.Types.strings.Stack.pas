unit Sis.Types.strings.Stack;

interface

type
  IStrStack = interface(IInterface)
    ['{7D35F8B2-2CDF-428B-A971-A91331997099}']
    procedure Push(const Value: string);
    procedure Pop(out Value: string); overload;
    function Pop: string; overload;

    function GetCaminho: string;
    property Caminho: string read GetCaminho;

  end;

implementation

end.

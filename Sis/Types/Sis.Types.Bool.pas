unit Sis.Types.Bool;

interface

type
  ISisBool = interface(IInterface)
    ['{B68BE76B-EF89-4E40-BB9A-09CC51B23F7F}']
    function BooleanToStr(pBoolValue: boolean): string;
    function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string; overload;
  end;

implementation

end.

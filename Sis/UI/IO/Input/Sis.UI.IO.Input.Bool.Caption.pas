unit Sis.UI.IO.Input.Bool.Caption;

interface

uses Sis.UI.IO.Input, Sis.Types.Utils_u;

type
  IInputBooleanCaption = interface(IInput)
    ['{18392A30-398B-4196-A19C-1344492C550B}']
    function Perg(pPergunta: string; pCaption: string = '';
      pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
  end;

implementation

end.

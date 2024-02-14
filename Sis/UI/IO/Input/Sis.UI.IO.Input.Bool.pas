unit Sis.UI.IO.Input.Bool;

interface

uses Sis.UI.IO.Input;

type
  IInputBoolean = interface(IInput)
    ['{18392A30-398B-4196-A19C-1344492C550B}']
    function Perg(pCaption, pFrase: string): boolean;
  end;

implementation

end.

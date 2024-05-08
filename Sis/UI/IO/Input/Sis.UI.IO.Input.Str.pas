unit Sis.UI.IO.Input.Str;

interface

uses Sis.UI.IO.Input;

type
  IInputStr = interface(IInput)
    ['{18392A30-398B-4196-A19C-1344492C550B}']
    function EditStr(var Value: string; pTit: string = ''; pCaption: string = ''): boolean;
  end;

implementation

end.

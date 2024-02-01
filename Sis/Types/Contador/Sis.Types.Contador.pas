unit Sis.Types.Contador;

interface

type
  IContador = interface(IInterface)
    ['{AFF8731F-F101-4376-BE03-372CF5D51DD6}']
    procedure Reset;
    function GetNext: Cardinal;
  end;

implementation

end.

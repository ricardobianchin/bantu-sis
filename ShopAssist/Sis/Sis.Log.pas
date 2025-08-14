unit Sis.Log;

interface

type
  ILog = interface(IInterface)
    ['{FEE422E2-8447-4D13-BCD8-244A458701DF}']
    procedure Escreva(pFrase: string);
  end;
var
  Log: ILog;
implementation

initialization
  Log := nil;
end.

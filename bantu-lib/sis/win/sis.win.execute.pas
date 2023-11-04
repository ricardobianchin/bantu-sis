unit sis.win.execute;

interface

uses Sis.UI.IO.Output;

type
  IWinExecute = interface(IInterface)
    ['{8A317294-ADC4-4445-96FE-F24C5D5BF3C6}']
    function Execute: boolean;
    function Executando: boolean;
    procedure EspereExecucao(pOutput: IOutput; pQtdIntervals: integer = 8);
  end;

implementation

end.

unit btu.lib.win.execute;

interface

uses btu.sis.ui.io.output;

type
  IWinExecute = interface(IInterface)
    ['{8A317294-ADC4-4445-96FE-F24C5D5BF3C6}']
    function Execute: boolean;
    function Executando: boolean;
  end;

implementation

end.

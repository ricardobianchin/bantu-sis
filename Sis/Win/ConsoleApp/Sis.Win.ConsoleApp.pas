unit Sis.Win.ConsoleApp;

interface

type
  IConsoleApp = interface(IInterface)
    ['{5367AAAA-D163-4E0F-A66E-12D6E35FEEC7}']
    function ExecutarComando(DosApp: string): string;
  end;

implementation

end.

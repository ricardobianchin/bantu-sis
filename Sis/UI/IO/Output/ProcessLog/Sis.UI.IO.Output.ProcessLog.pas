unit Sis.UI.IO.Output.ProcessLog;

interface

uses Sis.UI.IO.Output.ProcessLog.Types, Sis.UI.IO.Output;

type
  IProcessLog = interface(IOutput)
    ['{795278C3-FC27-412F-ADCA-2B3E8A3A5986}']

    procedure PushProperties(pTipo: TProcessLogTipo;
      pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
    procedure PopProperties;
  end;


implementation

end.

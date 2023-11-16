unit Sis.UI.IO.Output.ProcessLog.Properties.Stack;

interface

uses Sis.UI.IO.Output.ProcessLog.Types;

type
  IProcessLogPropertiesStack = interface(IInterface)
    ['{FF37DC79-3B2F-4B78-9DD1-787105E62250}']
    procedure PushProperties(pTipo: TProcessLogTipo;
      pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
    procedure PopProperties(out pTipo: TProcessLogTipo;
      out pAssunto: TProcessLogAssunto; out pNome: TProcessLogNome);
  end;

implementation

end.

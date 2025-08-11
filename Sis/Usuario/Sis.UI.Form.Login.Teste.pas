unit Sis.UI.Form.Login.Teste;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, Sis.ModuloSistema.Types,
  Sis.Entities.Types;

type
  ILoginTeste = interface(IInterface)
    ['{65A60C4E-EF35-4CCD-BB1C-E59F592CB48E}']
    function PodeIniciar(pOpcaoSisIdModulo: TOpcaoSisIdModulo;
      pTerminalId: TTerminalId; pOutput: IOutPut;
      pProcessLog: IProcessLog): Boolean;
  end;

implementation

end.

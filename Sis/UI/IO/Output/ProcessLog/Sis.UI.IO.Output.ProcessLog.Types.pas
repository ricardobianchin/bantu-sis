unit Sis.UI.IO.Output.ProcessLog.Types;

interface

type
  TProcessLogTipo = (lptNaoDefinido, lptProcess, lptExecExternal, lptDB);
  TProcessLogLocal = string;
  TProcessLogAssunto = string;
  TProcessLogNome = String;
  TProcessLogTexto = string;

const
  ProcessLogTipoStr: array[TProcessLogTipo] of string = (
    'NaoDefinido', 'Process', 'ExecExternal', 'DB');

implementation

end.


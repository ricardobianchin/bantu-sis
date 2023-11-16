unit Sis.UI.IO.Output.ProcessLog.Types;

interface

type
  TProcessLogTipo = (lptNaoDefinido, lptProcess, lptExecExternal, lptDB);
  TProcessLogAssunto = string;
  TProcessLogNome = String;
  TProcessLogTexto = string;

const
  ProcessLogTipoNames: array[TProcessLogTipo] of string = (
    'NaoDefinido', 'Process', 'ExecExternal', 'DB');

implementation

end.


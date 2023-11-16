unit Sis.UI.IO.ProcessLog.Constants;

interface

type
  TProcessLogTipo = (lptNaoDefinido, lptProcess, lptExecExternal, lptDB);

const
  ProcessLogTipoNames: array[TProcessLogTipo] of string = (
    'NaoDefinido', 'Process', 'ExecExternal', 'DB');

implementation

end.

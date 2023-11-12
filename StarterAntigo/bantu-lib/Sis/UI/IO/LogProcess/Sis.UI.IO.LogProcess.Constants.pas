unit Sis.UI.IO.LogProcess.Constants;

interface

type
  TLogProcessTipo = (lptNaoDefinido, lptProcess, lptExecExternal, lptDB);

const
  LogProcessTipoNames: array[TLogProcessTipo] of string = (
    'NaoDefinido', 'Process', 'ExecExternal', 'DB');

implementation

end.

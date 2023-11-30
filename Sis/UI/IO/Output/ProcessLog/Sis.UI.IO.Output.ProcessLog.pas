unit Sis.UI.IO.Output.ProcessLog;

interface

type
  TProcessLogTipo = (lptNaoDefinido, lptProcess, lptExecExternal, lptDB, lptWeb);
  TProcessLogLocal = string;
  TProcessLogAssunto = string;
  TProcessLogNome = String;
  TProcessLogTexto = string;

const
  ProcessLogTipoStr: array [TProcessLogTipo] of string = ('NaoDefinido',
    'Process', 'ExecExternal', 'DB', 'Web');

type
  IProcessLog = interface(IInterface)
    ['{795278C3-FC27-412F-ADCA-2B3E8A3A5986}']

    procedure PegueAssunto(pAssunto: TProcessLogAssunto);
    procedure RetorneAssunto;

    procedure PegueLocal(pLocal: TProcessLogLocal);
    procedure RetorneLocal;

    procedure RegistreLog(pTexto: string; pDtH: TDateTime = 0;
      pTipo: TProcessLogTipo = TProcessLogTipo.lptNaoDefinido;
      pNome: TProcessLogNome = '');
  end;

implementation

end.

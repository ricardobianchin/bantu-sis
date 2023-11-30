unit Sis.UI.IO.Output.ProcessLog.Factory;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord,
  Sis.UI.IO.Output.ProcessLog.Registrador,
  Sis.UI.IO.Output.ProcessLog;

function ProcessLogRegistradorCreate(pProcessLog: IProcessLog;
  pProcessLogTipo: TProcessLogTipo; pNome: TProcessLogNome)
  : IProcessLogRegistrador;

function ProcessLogRecordCreate: IProcessLogRecord;
function ProcessLogFileCreate(pAssunto: string; pAcrescentaDtH: boolean = True;
  pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.txt'): IProcessLog;

function MudoProcessLogCreate: IProcessLog;

implementation

uses Sis.UI.IO.Output.ProcessLog.LogRecord_u,
  Sis.UI.IO.Output.ProcessLog.Registrador_u,
  Sis.UI.IO.Output.ProcessLog.ProcessLogFile_u, Sis.UI.IO.Output.ProcessLog.Mudo;

function ProcessLogRecordCreate: IProcessLogRecord;
begin
  Result := TProcessLogRecord.Create;
end;

function ProcessLogFileCreate(pAssunto: string; pAcrescentaDtH: boolean = True;
  pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.txt'): IProcessLog;
begin
  Result := TProcessLogFile.Create(pAssunto, pAcrescentaDtH, pPasta,
    pDtH, pExt);
end;

function ProcessLogRegistradorCreate(pProcessLog: IProcessLog;
  pProcessLogTipo: TProcessLogTipo; pNome: TProcessLogNome)
  : IProcessLogRegistrador;
begin
  Result := TProcessLogRegistrador.Create(pProcessLog, pProcessLogTipo, pNome);
end;

function MudoProcessLogCreate: IProcessLog;
begin
  Result := TMudoProcessLog.Create;
end;

end.

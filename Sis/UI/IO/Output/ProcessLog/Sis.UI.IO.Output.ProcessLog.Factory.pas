unit Sis.UI.IO.Output.ProcessLog.Factory;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord,
  Sis.UI.IO.Output.ProcessLog.Types, Sis.UI.IO.Output.ProcessLog;

function ProcessLogRecordCreate: IProcessLogRecord;
function ProcessLogFileCreate(pAssunto: string; pAcrescentaDtH: boolean = True;
  pPasta: string = ''; pDtH: TDateTime = 0; pExt: string = '.txt'): IProcessLog;

implementation

uses Sis.UI.IO.Output.ProcessLog.LogRecord_u,
  Sis.UI.IO.Output.ProcessLog.ProcessLogFile_u;

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

end.

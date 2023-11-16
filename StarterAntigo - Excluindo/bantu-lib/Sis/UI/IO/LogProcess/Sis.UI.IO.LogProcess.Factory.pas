unit Sis.UI.IO.ProcessLog.Factory;

interface

uses sis.ui.io.ProcessLogRecord, sis.ui.io.ProcessLog;

function ProcessLogRecordCreate: IProcessLogRecord;
function ProcessLogFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): IProcessLog;

implementation

uses sis.ui.io.ProcessLogRecord_u, sis.ui.io.ProcessLogFile_u;

function ProcessLogRecordCreate: IProcessLogRecord;
begin
  result := TProcessLogRecord.Create;
end;

function ProcessLogFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): IProcessLog;
begin
  result := TProcessLogFile.Create(pAssunto, pAcrescentaDtH, pPasta, pDtH, pExt);
end;

end.

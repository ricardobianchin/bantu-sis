unit sis.ui.io.log.factory;

interface

uses sis.ui.io.log.LogRecord, sis.ui.io.log;

function LogRecordCreate: ILogRecord;
function LogFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): ILog;

implementation

uses sis.ui.io.log.LogRecord_u, sis.ui.io.log.LogFile_u;

function LogRecordCreate: ILogRecord;
begin
  result := TLogRecord.Create;
end;

function LogFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): ILog;
begin
  result := TLogFile.Create(pAssunto, pAcrescentaDtH, pPasta, pDtH, pExt);
end;

end.

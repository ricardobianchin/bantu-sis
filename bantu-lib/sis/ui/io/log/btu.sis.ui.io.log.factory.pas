unit btu.sis.ui.io.log.factory;

interface

uses btu.sis.ui.io.log.LogRecord, btu.sis.ui.io.log;

function LogRecordCreate: ILogRecord;
function LogFileCreate(pAssunto: string; pAcrescentaDtH: boolean=True; pPasta: string=''; pDtH: TDateTime=0; pExt: string='.txt'): ILog;

implementation

uses btu.sis.ui.io.log.LogRecord_u, btu.sis.ui.io.log.LogFile_u;

function LogRecordCreate: ILogRecord;
begin
  result := TLogRecord.Create;
end;

function LogFileCreate(pAssunto: string; pAcrescentaDtH: boolean=True; pPasta: string=''; pDtH: TDateTime=0; pExt: string='.txt'): ILog;
begin
  result := TLogFile.Create(pAssunto, pAcrescentaDtH, pPasta, pDtH, pExt);
end;

end.

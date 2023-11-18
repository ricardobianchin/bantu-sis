unit Sis.UI.IO.Output.ProcessLog.Factory;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord,
  Sis.UI.IO.Output.ProcessLog.Types;

function ProcessLogRecordCreate: IProcessLogRecord;

implementation

uses Sis.UI.IO.Output.ProcessLog.LogRecord_u
  ;

function ProcessLogRecordCreate: IProcessLogRecord;
begin
  Result := TProcessLogRecord.Create;
end;

end.

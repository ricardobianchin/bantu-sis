unit Sis.UI.IO.Output.ProcessLog.Factory;

interface

uses Sis.UI.IO.Output.ProcessLog.LogRecord,
  Sis.UI.IO.Output.ProcessLog.Properties.Stack,
  Sis.UI.IO.Output.ProcessLog.Types, Sis.UI.IO.Output.ProcessLog.Properties;

function ProcessLogRecordCreate: IProcessLogRecord;
function ProcessLogPropertiesCreate(pTipo: TProcessLogTipo;
  pAssunto: TProcessLogAssunto; pNome: TProcessLogNome): IProcessLogProperties;
function ProcessLogPropertiesStackCreate: IProcessLogPropertiesStack;

implementation

uses Sis.UI.IO.Output.ProcessLog.LogRecord_u,
  Sis.UI.IO.Output.ProcessLog.Properties.Stack_u,
  Sis.UI.IO.Output.ProcessLog.Properties_u;

function ProcessLogRecordCreate: IProcessLogRecord;
begin
  Result := TProcessLogRecord.Create;
end;

function ProcessLogPropertiesCreate(pTipo: TProcessLogTipo;
  pAssunto: TProcessLogAssunto; pNome: TProcessLogNome): IProcessLogProperties;
begin
  Result := TProcessLogProperties.Create(pTipo, pAssunto, pNome);
end;

function ProcessLogPropertiesStackCreate: IProcessLogPropertiesStack;
begin
  Result := TProcessLogPropertiesStack.Create;
end;

end.

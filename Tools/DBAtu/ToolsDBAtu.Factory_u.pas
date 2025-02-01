unit ToolsDBAtu.Factory_u;

// ToolsDBAtu.ConfigXMLI
interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, ToolsDBAtu.Config,
  Sis.Config.ConfigXMLI;

function ToolsDBAtuConfigCreate: IToolsDBAtuConfig;

function ToolsDBAtuConfigXMLICreate(pToolsDBAtuConfig: IToolsDBAtuConfig;
  pProcessLog: IProcessLog = nil; pOutput: IOutput = nil): IConfigXMLI;


implementation

uses ToolsDBAtu.Config_u, ToolsDBAtu.ConfigXMLI_u;

function ToolsDBAtuConfigCreate: IToolsDBAtuConfig;
begin
  Result := TToolsDBAtuConfig.Create;
end;

function ToolsDBAtuConfigXMLICreate(pToolsDBAtuConfig: IToolsDBAtuConfig;
  pProcessLog: IProcessLog = nil; pOutput: IOutput = nil): IConfigXMLI;
begin
  Result := TToolsDBAtuConfigXMLI.Create(pToolsDBAtuConfig,
    pProcessLog, pOutput);
end;

end.

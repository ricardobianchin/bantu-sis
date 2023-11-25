unit App.AppObj_u_VaParaPasta;

interface

uses App.AppInfo, Sis.UI.IO.Output.ProcessLog;

procedure VaParaPastaExe(pAppInfo: IAppInfo; pProcessLog: IProcessLog);

implementation

uses Sis.UI.IO.Files;

procedure VaParaPastaExe(pAppInfo: IAppInfo; pProcessLog: IProcessLog);
begin
  Sis.UI.IO.Files.VaParaPastaDoArquivo(pAppInfo.ExeName, pProcessLog)
end;

end.

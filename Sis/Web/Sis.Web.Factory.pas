unit Sis.Web.Factory;

interface

uses Sis.Web.HTTP.Download, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

function HTTPDownloadCreate(pArqLocal, pArqRemoto: string;
  pProcessLog: IProcessLog; pOutput: IOutput;
  pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;

implementation

uses Sis.Web.HTTP.Download_u;

function HTTPDownloadCreate(pArqLocal, pArqRemoto: string;
  pProcessLog: IProcessLog; pOutput: IOutput;
  pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;
begin
  Result := THTTPDownload.Create(pArqLocal, pArqRemoto, pProcessLog, pOutput,
    pExluiDestinoAntesDeBaixar);
end;

end.

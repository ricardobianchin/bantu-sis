unit Sis.Web.Factory;

interface

uses Sis.Web.HTTP.Download, sis.ui.io.ProcessLog, sis.ui.io.output;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;

implementation

uses Sis.Web.HTTP.Download_u;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;
begin
  Result := THTTPDownload.Create(pArqLocal, pArqRemoto, pProcessLog, pOutput, pExluiDestinoAntesDeBaixar);
end;

end.

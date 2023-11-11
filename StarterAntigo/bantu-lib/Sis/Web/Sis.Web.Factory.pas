unit Sis.Web.Factory;

interface

uses Sis.Web.HTTP.Download, sis.ui.io.LogProcess, sis.ui.io.output;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;

implementation

uses Sis.Web.HTTP.Download_u;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;
begin
  Result := THTTPDownload.Create(pArqLocal, pArqRemoto, pLogProcess, pOutput, pExluiDestinoAntesDeBaixar);
end;

end.

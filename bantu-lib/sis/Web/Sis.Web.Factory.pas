unit Sis.Web.Factory;

interface

uses Sis.Web.HTTP.Download, sis.ui.io.log;

function IHTTPDownloadCreate(pArqRemoto, pArqLocal: string; pLog: ILog): IHTTPDownload;

implementation

uses Sis.Web.HTTP.Download_u;

function IHTTPDownloadCreate(pArqRemoto, pArqLocal: string; pLog: ILog): IHTTPDownload;
begin
  Result := THTTPDownload.Create(pArqRemoto, pArqLocal, pLog);
end;

end.

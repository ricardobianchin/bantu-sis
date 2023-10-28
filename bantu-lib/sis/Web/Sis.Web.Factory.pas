unit Sis.Web.Factory;

interface

uses Sis.Web.HTTP.Download, sis.ui.io.log, sis.ui.io.output;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pLog: ILog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;

implementation

uses Sis.Web.HTTP.Download_u;

function IHTTPDownloadCreate(pArqLocal, pArqRemoto: string; pLog: ILog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): IHTTPDownload;
begin
  Result := THTTPDownload.Create(pArqLocal, pArqRemoto, pLog, pOutput, pExluiDestinoAntesDeBaixar);
end;

end.

unit Sis.Web.Factory;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Sis.Executavel;

function HTTPDownloadCreate(pArqLocal, pArqRemoto: string;
  pExluiDestinoAntes: Boolean; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil): IExecutavel;

function HTTPUploadCreate(pArqLocal, pArqRemoto: string;
  pExluiDestinoAntes: Boolean; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil): IExecutavel;

implementation

uses Sis.Web.HTTP.Download_u, Sis.Web.HTTP.Upload_u;

function HTTPDownloadCreate(pArqLocal, pArqRemoto: string;
  pExluiDestinoAntes: Boolean; pOutput: IOutput; pProcessLog: IProcessLog)
  : IExecutavel;
begin
  Result := THTTPDownload.Create(pArqLocal, pArqRemoto,
  pExluiDestinoAntes, pOutput, pProcessLog);
end;

function HTTPUploadCreate(pArqLocal, pArqRemoto: string;
  pExluiDestinoAntes: Boolean; pOutput: IOutput; pProcessLog: IProcessLog)
  : IExecutavel;
begin
  Result := THTTPUpload.Create(pArqLocal, pArqRemoto,
  pExluiDestinoAntes, pOutput, pProcessLog);
end;

end.

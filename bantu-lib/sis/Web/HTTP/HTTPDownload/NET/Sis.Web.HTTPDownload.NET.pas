unit Sis.Web.HTTPDownload.NET;

interface

uses sis.ui.io.log, sis.ui.io.output;

function Execute(pArqLocal, pArqRemoto: string; pLog: ILog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;

implementation

uses
  System.Net.HttpClient, System.Net.URLClient, System.SysUtils, System.Classes,
  Sis.Types.Times, Sis.Files.Sync, System.IOUtils, dialogs;

function GetValueByName(pName: string; pNetHeaders: TNetHeaders): string;
var
  Header: TNameValuePair;
  LastModifiedValue: string;

begin
  for Header in pNetHeaders do
  begin
    if Header.Name = pName then
    begin
      LastModifiedValue := Header.Value;
      Result := LastModifiedValue;
      Break;
    end;
  end;
end;

function Execute(pArqLocal, pArqRemoto: string; pLog: ILog; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;
var
  HTTPClient: THTTPClient;
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
  RemoteFileURL, LocalFilePath: string;

  DtHRemoto: TDateTime;
  DtHLocal: TDateTime;
  sGMT: string;
begin
  pLog.Exibir('Sis.Web.HTTPDownload.NET.Execute inicio');
  pLog.Exibir('THTTPClient.Create');
  HTTPClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pLog.Exibir('RemoteFileURL='+RemoteFileURL);
    HTTPResponse := HTTPClient.Head(RemoteFileURL);

    Result := HTTPResponse.StatusCode = 200;
    if not Result then
    begin
      pLog.Exibir('HTTPResponse.StatusCode='+HTTPResponse.StatusCode.ToString+', precisava ser 200');
      exit;
    end;

    sGMT := GetValueByName('Last-Modified', HTTPResponse.Headers);
    pLog.Exibir('sGMT='+sGMT);
    DtHRemoto := ConvertGMTToTDateTime(sGMT);
    pLog.Exibir('DtHRemoto='+DateTimeToStr(DtHRemoto));

    LocalFilePath := pArqLocal;
    pLog.Exibir('LocalFilePath='+LocalFilePath);

    DtHLocal := GetDataArquivo(pArqLocal);
    pLog.Exibir('DtHLocal='+DateTimeToStr(DtHLocal));

    Result := DtHRemoto > DtHLocal;
    if not Result then
    begin
      pLog.Exibir('nao precisava atualizar');
      exit;
    end;

    if pExluiDestinoAntesDeBaixar then
    begin
      if FileExists(LocalFilePath) then
      begin
        pLog.Exibir('vai apagar');
        TFile.Delete(LocalFilePath);
        pLog.Exibir('apagou');
      end;
    end;

    FileStream := TFileStream.Create(LocalFilePath, fmCreate);
    try
      pLog.Exibir('HTTPClient.Get');
      pOutput.Exibir('Baixando atualização...');
      try
        //showmessage(RemoteFileURL);
        HTTPResponse := HTTPClient.Get(RemoteFileURL, FileStream);
        //showmessage('baixou');
      except on E: Exception do
      begin
        //showmessage('HTTPClient.Get '+E.Message+' statuscode='+HTTPResponse.StatusCode.ToString);
        pLog.Exibir('HTTPClient.Get '+E.Message);
      end;
      end;
      Result := HTTPResponse.StatusCode = 200;
      pLog.Exibir('HTTPResponse.StatusCode='+HTTPResponse.StatusCode.ToString+', precisava ser 200');
    finally
      FileStream.Free;
    end;
  finally
    HTTPClient.Free;
    pLog.Exibir('Sis.Web.HTTPDownload.NET.Execute fim');
  end;
end;

end.

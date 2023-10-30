unit Sis.Web.HTTPDownload.NET;

interface

uses sis.ui.io.LogProcess, sis.ui.io.output;

function Execute(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;

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

function Execute(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess; pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;
var
  HTTPClient: THTTPClient;
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
  RemoteFileURL, LocalFilePath: string;

  DtHRemoto: TDateTime;
  DtHLocal: TDateTime;
  sGMT: string;
begin
  pLogProcess.Exibir('Sis.Web.HTTPDownload.NET.Execute inicio');
  pLogProcess.Exibir('THTTPClient.Create');
  HTTPClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pLogProcess.Exibir('RemoteFileURL='+RemoteFileURL);
    HTTPResponse := HTTPClient.Head(RemoteFileURL);

    Result := HTTPResponse.StatusCode = 200;
    if not Result then
    begin
      pLogProcess.Exibir('HTTPResponse.StatusCode='+HTTPResponse.StatusCode.ToString+', precisava ser 200');
      exit;
    end;

    sGMT := GetValueByName('Last-Modified', HTTPResponse.Headers);
    pLogProcess.Exibir('sGMT='+sGMT);
    DtHRemoto := ConvertGMTToTDateTime(sGMT);
    pLogProcess.Exibir('DtHRemoto='+DateTimeToStr(DtHRemoto));

    LocalFilePath := pArqLocal;
    pLogProcess.Exibir('LocalFilePath='+LocalFilePath);

    DtHLocal := GetDataArquivo(pArqLocal);
    pLogProcess.Exibir('DtHLocal='+DateTimeToStr(DtHLocal));

    Result := DtHRemoto > DtHLocal;
    if not Result then
    begin
      pLogProcess.Exibir('nao precisava atualizar');
      exit;
    end;

    if pExluiDestinoAntesDeBaixar then
    begin
      if FileExists(LocalFilePath) then
      begin
        pLogProcess.Exibir('vai apagar');
        TFile.Delete(LocalFilePath);
        pLogProcess.Exibir('apagou');
      end;
    end;

    FileStream := TFileStream.Create(LocalFilePath, fmCreate);
    try
      pLogProcess.Exibir('HTTPClient.Get');
      pOutput.Exibir('Baixando atualização...');
      try
        //showmessage(RemoteFileURL);
        HTTPResponse := HTTPClient.Get(RemoteFileURL, FileStream);
        //showmessage('baixou');
      except on E: Exception do
      begin
        //showmessage('HTTPClient.Get '+E.Message+' statuscode='+HTTPResponse.StatusCode.ToString);
        pLogProcess.Exibir('HTTPClient.Get '+E.Message);
      end;
      end;
      Result := HTTPResponse.StatusCode = 200;
      pLogProcess.Exibir('HTTPResponse.StatusCode='+HTTPResponse.StatusCode.ToString+', precisava ser 200');
    finally
      FileStream.Free;
    end;
  finally
    HTTPClient.Free;
    pLogProcess.Exibir('Sis.Web.HTTPDownload.NET.Execute fim');
  end;
end;

end.

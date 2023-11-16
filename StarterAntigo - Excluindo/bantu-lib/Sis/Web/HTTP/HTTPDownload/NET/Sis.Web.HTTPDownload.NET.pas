unit Sis.Web.HTTPDownload.NET;

interface

uses Sis.ui.io.ProcessLog, Sis.ui.io.output;

function Execute(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;

implementation

uses
  System.NET.HttpClient, System.NET.URLClient, System.SysUtils, System.Classes,
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

function Execute(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;
var
  HttpClient: THTTPClient;
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
  RemoteFileURL, LocalFilePath: string;

  DtHRemoto: TDateTime;
  DtHLocal: TDateTime;
  sGMT: string;
begin
  pProcessLog.Exibir('Sis.Web.HTTPDownload.NET.Execute inicio');
  pProcessLog.Exibir('THTTPClient.Create');
  HttpClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pProcessLog.Exibir('RemoteFileURL=' + RemoteFileURL);

    try
      HTTPResponse := HttpClient.Head(RemoteFileURL);
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        pProcessLog.Exibir('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Head,' + E.Message);
      end;
    end;

    if not Result then
      exit;

    Result := HTTPResponse.StatusCode = 200;
    if not Result then
    begin
      pProcessLog.Exibir('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
      exit;
    end;

    sGMT := GetValueByName('Last-Modified', HTTPResponse.Headers);
    pProcessLog.Exibir('sGMT=' + sGMT);
    DtHRemoto := ConvertGMTToTDateTime(sGMT);
    pProcessLog.Exibir('DtHRemoto=' + DateTimeToStr(DtHRemoto));

    LocalFilePath := pArqLocal;
    pProcessLog.Exibir('LocalFilePath=' + LocalFilePath);

    DtHLocal := GetDataArquivo(pArqLocal);
    pProcessLog.Exibir('DtHLocal=' + DateTimeToStr(DtHLocal));

    Result := DtHRemoto > DtHLocal;
    if not Result then
    begin
      pProcessLog.Exibir('nao precisava atualizar');
      exit;
    end;

    if pExluiDestinoAntesDeBaixar then
    begin
      if FileExists(LocalFilePath) then
      begin
        pProcessLog.Exibir('vai apagar');
        TFile.Delete(LocalFilePath);
        pProcessLog.Exibir('apagou');
      end;
    end;

    FileStream := TFileStream.Create(LocalFilePath, fmCreate);
    try
      pProcessLog.Exibir('HTTPClient.Get');
      pOutput.Exibir('Baixando atualização...');
      try
        // showmessage(RemoteFileURL);
        HTTPResponse := HttpClient.Get(RemoteFileURL, FileStream);
        Result := True;
        // showmessage('baixou');
      except
        on E: Exception do
        begin
          // showmessage('HTTPClient.Get '+E.Message+' statuscode='+HTTPResponse.StatusCode.ToString);
          pProcessLog.Exibir('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Get,' + E.Message);
          Result := False;
        end;
      end;
      if not Result then
        exit;

      Result := HTTPResponse.StatusCode = 200;
      pProcessLog.Exibir('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
    finally
      FileStream.Free;
    end;
  finally
    if assigned(HttpClient) then
      HttpClient.Free;
    pProcessLog.Exibir('Sis.Web.HTTPDownload.NET.Execute fim');
  end;
end;

end.

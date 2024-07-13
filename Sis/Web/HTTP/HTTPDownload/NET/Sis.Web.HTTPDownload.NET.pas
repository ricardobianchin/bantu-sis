unit Sis.Web.HTTPDownload.NET;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

function Execute(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;

implementation

uses
  System.NET.HttpClient, System.NET.URLClient, System.SysUtils, System.Classes,
  Sis.Types.Dates, Sis.UI.IO.Files.Sync, System.IOUtils, dialogs;

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
  pProcessLog.PegueLocal('Sis.Web.HTTPDownload.NET,function Execute');

  pProcessLog.RegistreLog('HttpClient := THTTPClient.Create');
  HttpClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pProcessLog.RegistreLog('RemoteFileURL=' + RemoteFileURL);

    try
      pProcessLog.RegistreLog
        ('vai HTTPResponse := HttpClient.Head(RemoteFileURL)');
      HTTPResponse := HttpClient.Head(RemoteFileURL);
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        pProcessLog.RegistreLog('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Head,'
          + E.Message);
      end;
    end;

    if not Result then
    begin
      pProcessLog.RegistreLog('not Result, vai abortar');
      exit;
    end;

    Result := HTTPResponse.StatusCode = 200;
    if not Result then
    begin
      pProcessLog.RegistreLog('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
      exit;
    end;

    sGMT := GetValueByName('Last-Modified', HTTPResponse.Headers);
    pProcessLog.RegistreLog('sGMT=' + sGMT);
    DtHRemoto := ConvertGMTToTDateTime(sGMT);
    pProcessLog.RegistreLog('DtHRemoto=' + DateTimeToStr(DtHRemoto));

    LocalFilePath := pArqLocal;
    pProcessLog.RegistreLog('LocalFilePath=' + LocalFilePath);

    DtHLocal := GetDataArquivo(pArqLocal);
    pProcessLog.RegistreLog('DtHLocal=' + DateTimeToStr(DtHLocal));

    Result := DtHRemoto > DtHLocal;
    if not Result then
    begin
      pProcessLog.RegistreLog('nao precisava atualizar');
      exit;
    end;

    if pExluiDestinoAntesDeBaixar then
    begin
      if FileExists(LocalFilePath) then
      begin
        pProcessLog.RegistreLog('vai apagar LocalFilePath=' + LocalFilePath);
        TFile.Delete(LocalFilePath);
        pProcessLog.RegistreLog('apagou');
      end;
    end;

    FileStream := TFileStream.Create(LocalFilePath, fmCreate);
    try
      pProcessLog.RegistreLog('HTTPClient.Get');
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
          pProcessLog.RegistreLog
            ('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Get,' + E.Message);
          Result := False;
        end;
      end;

      if not Result then
      begin
        pProcessLog.RegistreLog('nao precisava atualizar');
        exit;
      end;

      Result := HTTPResponse.StatusCode = 200;
      pProcessLog.RegistreLog('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
    finally
      FileStream.Free;
    end;
  finally
    if assigned(HttpClient) then
      HttpClient.Free;
    pProcessLog.RegistreLog('Fim');
    pProcessLog.RetorneLocal;
  end;
end;

end.

unit Sis.Web.HTTP.Upload.NET;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

function NETUpload(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;

implementation

uses
  System.NET.HttpClient, System.NET.URLClient, System.SysUtils, System.Classes,
  Sis.Types.Dates, Sis.UI.IO.Files.Sync, System.IOUtils, dialogs, Sis.Web.HTTP.Net.Utils_u;

function NETUpload(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;
var
  HttpClient: THTTPClient;
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
  RemoteFileURL, LocalFilePath: string;
  DtHRemoto: TDateTime;
  DtHLocal: TDateTime;
  sGMT: string;
begin
  pProcessLog.PegueLocal('Sis.Web.HTTPUpload.NET,function Execute');

  pProcessLog.RegistreLog('HttpClient := THTTPClient.Create');
  HttpClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pProcessLog.RegistreLog('RemoteFileURL=' + RemoteFileURL);

    // Verifica se o arquivo remoto existe e pega informações
    try
      pProcessLog.RegistreLog
        ('vai HTTPResponse := HttpClient.Head(RemoteFileURL)');
      HTTPResponse := HttpClient.Head(RemoteFileURL);
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        pProcessLog.RegistreLog('Sis.Web.HTTPUpload.NET,Erro,HTTPClient.Head,' +
          E.Message);
      end;
    end;

    if not Result then
    begin
      // Se não conseguiu HEAD, assume que o arquivo não existe e prossegue com upload
      Result := True;
    end
    else
    begin
      Result := HTTPResponse.StatusCode = 200;
      if Result then
      begin
        // Arquivo remoto existe, verifica datas
        sGMT := NETGetValueByName('Last-Modified', HTTPResponse.Headers);
        pProcessLog.RegistreLog('sGMT=' + sGMT);
        DtHRemoto := ConvertGMTToTDateTime(sGMT);
        pProcessLog.RegistreLog('DtHRemoto=' + DateTimeToStr(DtHRemoto));

        LocalFilePath := pArqLocal;
        pProcessLog.RegistreLog('LocalFilePath=' + LocalFilePath);

        DtHLocal := GetDataArquivo(pArqLocal);
        pProcessLog.RegistreLog('DtHLocal=' + DateTimeToStr(DtHLocal));

        Result := DtHLocal > DtHRemoto;
        if not Result then
        begin
          pProcessLog.RegistreLog('nao precisava atualizar');
          exit;
        end;
      end;
    end;

    // Preparação para upload
    LocalFilePath := pArqLocal;
    if not FileExists(LocalFilePath) then
    begin
      pProcessLog.RegistreLog('Arquivo local não existe: ' + LocalFilePath);
      Result := False;
      exit;
    end;

    FileStream := TFileStream.Create(LocalFilePath, fmOpenRead);
    try
      pProcessLog.RegistreLog('HTTPClient.Put');
      pOutput.Exibir('Enviando atualização...');
      try
        HTTPResponse := HttpClient.Put(RemoteFileURL, FileStream);
        Result := HTTPResponse.StatusCode = 200;
        pProcessLog.RegistreLog('HTTPResponse.StatusCode=' +
          HTTPResponse.StatusCode.ToString + ', precisava ser 200');
      except
        on E: Exception do
        begin
          pProcessLog.RegistreLog('Sis.Web.HTTPUpload.NET,Erro,HTTPClient.Put,'
            + E.Message);
          Result := False;
        end;
      end;
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

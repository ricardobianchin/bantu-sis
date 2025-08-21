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
  DtHRemoto, DtHLocal: TDateTime;
  sGMT: string;
begin
  Result := False; // mais seguro iniciar falso

  pProcessLog.PegueLocal('Sis.Web.HTTPUpload.NET,function Execute');
  HttpClient := THTTPClient.Create;

  try
    RemoteFileURL := pArqRemoto;
    LocalFilePath := pArqLocal;

    pProcessLog.RegistreLog('RemoteFileURL=' + RemoteFileURL);
    pProcessLog.RegistreLog('LocalFilePath=' + LocalFilePath);

    // 1. Se arquivo local não existe, aborta imediatamente
    if not FileExists(LocalFilePath) then
    begin
      pProcessLog.RegistreLog('Arquivo local não existe: ' + LocalFilePath);
      Exit;
    end;

    // 2. Faz HEAD para checar se já existe remoto (opcional)
    HTTPResponse := nil;
    try
      pProcessLog.RegistreLog('Fazendo HEAD...');
      HTTPResponse := HttpClient.Head(RemoteFileURL);
    except
      on E: Exception do
      begin
        pProcessLog.RegistreLog('HEAD falhou: ' + E.Message +
          ' -> seguirá com upload mesmo assim');
      end;
    end;

    if Assigned(HTTPResponse) and (HTTPResponse.StatusCode = 200) then
    begin
      // Arquivo remoto existe, compara datas
      sGMT := NETGetValueByName('Last-Modified', HTTPResponse.Headers);
      pProcessLog.RegistreLog('sGMT=' + sGMT);

      if sGMT <> '' then
      begin
        DtHRemoto := ConvertGMTToTDateTime(sGMT);
        DtHLocal  := GetDataArquivo(LocalFilePath);

        pProcessLog.RegistreLog('DtHRemoto=' + DateTimeToStr(DtHRemoto));
        pProcessLog.RegistreLog('DtHLocal='  + DateTimeToStr(DtHLocal));

        // só envia se local for mais novo
        if DtHLocal <= DtHRemoto then
        begin
          pProcessLog.RegistreLog('Arquivo remoto já atualizado, upload desnecessário.');
          Exit;
        end;
      end
      else
      begin
        pProcessLog.RegistreLog('Sem cabeçalho Last-Modified remoto, seguirá upload.');
      end;
    end;

    // 3. Faz upload
    FileStream := TFileStream.Create(LocalFilePath, fmOpenRead);
    try
      pOutput.Exibir('Enviando atualização...');
      try
        HTTPResponse := HttpClient.Put(RemoteFileURL, FileStream);
      except
        on E: Exception do
        begin
          pProcessLog.RegistreLog('Erro no PUT: ' + E.Message);
          Exit;
        end;
      end;

      if (HTTPResponse.StatusCode = 200) then
      begin
        pProcessLog.RegistreLog('Upload concluído com sucesso.');
        Result := True;
      end
      else
      begin
        pProcessLog.RegistreLog('PUT retornou StatusCode=' +
          HTTPResponse.StatusCode.ToString + ', esperado=200');
      end;
    finally
      FileStream.Free;
    end;

  finally
    HttpClient.Free;
    pProcessLog.RegistreLog('Fim');
    pProcessLog.RetorneLocal;
  end;
end;

end.

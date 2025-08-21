unit Sis.Web.HTTP.Download.NET;

interface

uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

function NETDownload(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;

implementation

uses
  System.NET.HttpClient, System.NET.URLClient, System.SysUtils, System.Classes,
  Sis.Types.Dates, Sis.UI.IO.Files.Sync, System.IOUtils, dialogs, Sis.Web.HTTP.Net.Utils_u;

function NETDownload(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean): boolean;
var
  HttpClient: THTTPClient;
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
  RemoteFileURL, LocalFilePath: string;
  DtHRemoto, DtHLocal: TDateTime;
  sGMT: string;
begin
  Result := False; // inicia como falso -> mais seguro contra retornos errados

  pProcessLog.PegueLocal('Sis.Web.HTTP.Download_u,function Execute');
  HttpClient := THTTPClient.Create;

  try
    RemoteFileURL := pArqRemoto;
    LocalFilePath := pArqLocal;

    pProcessLog.RegistreLog('RemoteFileURL=' + RemoteFileURL);
    pProcessLog.RegistreLog('LocalFilePath=' + LocalFilePath);

    // 1. Tenta obter HEAD para validar e checar Last-Modified
    try
      pProcessLog.RegistreLog('Fazendo HEAD...');
      HTTPResponse := HttpClient.Head(RemoteFileURL);
    except
      on E: Exception do
      begin
        // Se o HEAD falhar, ainda podemos tentar um GET direto
        pProcessLog.RegistreLog('HEAD falhou: ' + E.Message + ' -> tentando GET direto');
        HTTPResponse := nil;
      end;
    end;

    // 2. Se teve resposta válida no HEAD, analisa código e data
    if Assigned(HTTPResponse) then
    begin
      if HTTPResponse.StatusCode <> 200 then
      begin
        pProcessLog.RegistreLog('HEAD retornou StatusCode=' +
          HTTPResponse.StatusCode.ToString + ', esperado=200');
        Exit; // aborta sem baixar
      end;

      sGMT := NETGetValueByName('Last-Modified', HTTPResponse.Headers);
      pProcessLog.RegistreLog('sGMT=' + sGMT);

      if sGMT <> '' then
      begin
        DtHRemoto := ConvertGMTToTDateTime(sGMT);
        pProcessLog.RegistreLog('DtHRemoto=' + DateTimeToStr(DtHRemoto));

        DtHLocal := GetDataArquivo(pArqLocal);
        pProcessLog.RegistreLog('DtHLocal=' + DateTimeToStr(DtHLocal));

        // só baixa se remoto for mais novo
        if DtHRemoto <= DtHLocal then
        begin
          pProcessLog.RegistreLog('Arquivo local já está atualizado, download desnecessário.');
          Exit;
        end;
      end
      else
      begin
        pProcessLog.RegistreLog('Cabeçalho Last-Modified não informado, seguirá para download.');
      end;
    end;

    // 3. Apaga destino antes de baixar (se configurado)
    if pExluiDestinoAntesDeBaixar and FileExists(LocalFilePath) then
    begin
      try
        pProcessLog.RegistreLog('Excluindo arquivo antigo: ' + LocalFilePath);
        TFile.Delete(LocalFilePath);
      except
        on E: Exception do
        begin
          pProcessLog.RegistreLog('Erro ao apagar arquivo: ' + E.Message);
          Exit;
        end;
      end;
    end;

    // 4. Faz o download com GET
    FileStream := TFileStream.Create(LocalFilePath, fmCreate);
    try
      pOutput.Exibir('Baixando arquivo...');
      try
        HTTPResponse := HttpClient.Get(RemoteFileURL, FileStream);
      except
        on E: Exception do
        begin
          pProcessLog.RegistreLog('Erro no GET: ' + E.Message);
          Exit;
        end;
      end;

      if (HTTPResponse.StatusCode = 200) then
      begin
        pProcessLog.RegistreLog('Download concluído com sucesso.');
        Result := True;
      end
      else
      begin
        pProcessLog.RegistreLog('GET retornou StatusCode=' +
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

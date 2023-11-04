unit Sis.Web.HTTPDownload.NET;

interface

uses Sis.ui.io.LogProcess, Sis.ui.io.output;

function Execute(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess;
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

function Execute(pArqLocal, pArqRemoto: string; pLogProcess: ILogProcess;
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
  pLogProcess.Exibir('Sis.Web.HTTPDownload.NET.Execute inicio');
  pLogProcess.Exibir('THTTPClient.Create');
  HttpClient := THTTPClient.Create;
  try
    RemoteFileURL := pArqRemoto;
    pLogProcess.Exibir('RemoteFileURL=' + RemoteFileURL);

    try
      HTTPResponse := HttpClient.Head(RemoteFileURL);
      Result := True;
    except
      on E: Exception do
      begin
        Result := False;
        pLogProcess.Exibir('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Head,' + E.Message);
      end;
    end;

    if not Result then
      exit;

    Result := HTTPResponse.StatusCode = 200;
    if not Result then
    begin
      pLogProcess.Exibir('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
      exit;
    end;

    sGMT := GetValueByName('Last-Modified', HTTPResponse.Headers);
    pLogProcess.Exibir('sGMT=' + sGMT);
    DtHRemoto := ConvertGMTToTDateTime(sGMT);
    pLogProcess.Exibir('DtHRemoto=' + DateTimeToStr(DtHRemoto));

    LocalFilePath := pArqLocal;
    pLogProcess.Exibir('LocalFilePath=' + LocalFilePath);

    DtHLocal := GetDataArquivo(pArqLocal);
    pLogProcess.Exibir('DtHLocal=' + DateTimeToStr(DtHLocal));

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
        // showmessage(RemoteFileURL);
        HTTPResponse := HttpClient.Get(RemoteFileURL, FileStream);
        Result := True;
        // showmessage('baixou');
      except
        on E: Exception do
        begin
          // showmessage('HTTPClient.Get '+E.Message+' statuscode='+HTTPResponse.StatusCode.ToString);
          pLogProcess.Exibir('Sis.Web.HTTPDownload.NET,Erro,HTTPClient.Get,' + E.Message);
          Result := False;
        end;
      end;
      if not Result then
        exit;

      Result := HTTPResponse.StatusCode = 200;
      pLogProcess.Exibir('HTTPResponse.StatusCode=' +
        HTTPResponse.StatusCode.ToString + ', precisava ser 200');
    finally
      FileStream.Free;
    end;
  finally
    if assigned(HttpClient) then
      HttpClient.Free;
    pLogProcess.Exibir('Sis.Web.HTTPDownload.NET.Execute fim');
  end;
end;

end.

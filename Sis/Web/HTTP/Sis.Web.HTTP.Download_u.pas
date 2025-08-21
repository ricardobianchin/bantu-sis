unit Sis.Web.HTTP.Download_u;

interface

uses Sis.Web.HTTP.FileTranser_u, IdHTTP, System.Classes, IdSSL, IdSSLOpenSSL,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, sis.sis.Executavel_u;

type
  THTTPDownload = class(THTTPFileTranser)
  private
  public
    function Execute: boolean; override;
  end;

implementation

uses System.DateUtils, System.SysUtils, Sis.Types.Dates, Sis.UI.IO.Files.Sync,
  Sis.Web.HTTP.Download.NET;

{ THTTPDownload }

function THTTPDownload.Execute: boolean;
begin
  {
  WEB_LIB_INDY = 1;
  WEB_LIB_NET = 2;
  WEB_LIB_USADA = WEB_LIB_NET;

    case WEB_LIB_USADA of
    WEB_LIB_INDY: Result := ExecuteIndy;
    WEB_LIB_NET: Result := Sis.Web.HTTPDownload.NET.Execute(FArqLocal, FArqRemoto, ProcessLog, Output, FExluiDestinoAntes);
    end;
  }
  ProcessLog.PegueLocal('THTTPDownload.Execute');
  try
    ProcessLog.RegistreLog('vai chamar Sis.Web.HTTPDownload.NET.Execute');
    Result := Sis.Web.HTTP.Download.NET.NETDownload(ArqLocal, ArqRemoto,
      ProcessLog, Output, ExluiDestinoAntes);
    ProcessLog.RegistreLog('retornou de Sis.Web.HTTPDownload.NET.Execute,Fim');
  finally
    ProcessLog.RetorneLocal;
  end;
end;

{
  function THTTPDownload.ExecuteIndy: Boolean;
  var
  sLog: string;
  sGMT: string;
  //  sDtH: string;
  begin
  result := false;
  exit;

  sLog := 'THTTPDownload.Execute,TIdHTTP.Create';
  Result := True;

  IdHTTP1 := TIdHTTP.Create(nil);

  IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP1);
  IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  try
  try
  sLog := sLog + ',HTTP.Head';
  IdHTTP1.Head(FArqRemoto);

  sLog := sLog + ',vai ler dth remoto';
  sGMT := IdHTTP1.Response.RawHeaders.Values['Last-Modified'];
  FDtHRemoto := ConvertGMTToTDateTime(sGMT);

  sLog := sLog + ',vai ler dth local';
  FDtHLocal := GetDataArquivo(FArqLocal);

  if FDtHRemoto > FDtHLocal then
  begin
  sLog := sLog + ',FDtHRemoto > FDtHLocal';

  MS := TMemoryStream.Create;
  try
  sLog := sLog + ',Get para MS';
  IdHTTP1.Get(FArqRemoto, MS);
  sLog := sLog + ',MS.SaveToFile';
  MS.SaveToFile(FArqLocal);
  finally
  sLog := sLog + ',MS.Free';
  MS.Free;
  end;
  end;
  except
  on E: EIdHTTPProtocolException do
  begin
  sLog := sLog + 'Erro ' + E.ClassName + ' ' + E.Message;
  Result := False;
  // ShowMessage('O arquivo não existe.');
  end;
  end;
  finally
  sLog := sLog + ',HTTP.Free';
  IdHTTP1.Free;
  sLog := sLog + ',Result=' + BooleanToStr(Result);
  ProcessLog.Exibir(sLog);
  end;
  end;
}

end.

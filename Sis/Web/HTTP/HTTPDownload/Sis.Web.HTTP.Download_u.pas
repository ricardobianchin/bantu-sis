unit Sis.Web.HTTP.Download_u;

interface

uses Sis.Web.HTTP.Download, IdHTTP, System.Classes, IdSSL, IdSSLOpenSSL,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  THTTPDownload = class(TInterfacedObject, IHTTPDownload)
  private
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FExluiDestinoAntesDeBaixar: boolean;
    // FDtHLocal, FDtHRemoto : TDateTIme;
    FArqLocal, FArqRemoto: string;

    // IdHTTP1: TIdHTTP;
    // IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    // MS: TMemoryStream;
    // function ExecuteIndy: Boolean;
  public
    function Execute: boolean;
    constructor Create(pArqLocal, pArqRemoto: string; pProcessLog: IProcessLog;
      pOutput: IOutput; pExluiDestinoAntesDeBaixar: boolean);
  end;

implementation

uses System.DateUtils, System.SysUtils, Sis.Types.Times, Sis.UI.IO.Files.Sync,
  Sis.Web.HTTPDownload.NET;

{ THTTPDownload }

constructor THTTPDownload.Create(pArqLocal, pArqRemoto: string;
  pProcessLog: IProcessLog; pOutput: IOutput;
  pExluiDestinoAntesDeBaixar: boolean);
begin
  FArqLocal := pArqLocal;
  FArqRemoto := pArqRemoto;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FExluiDestinoAntesDeBaixar := pExluiDestinoAntesDeBaixar;

  FProcessLog.PegueLocal('THTTPDownload.Create');
  FProcessLog.RegistreLog('Local=' + FArqLocal + ',Remoto=' + FArqRemoto);
  FProcessLog.RetorneLocal;
end;

function THTTPDownload.Execute: boolean;
begin
  {
  WEB_LIB_INDY = 1;
  WEB_LIB_NET = 2;
  WEB_LIB_USADA = WEB_LIB_NET;

    case WEB_LIB_USADA of
    WEB_LIB_INDY: Result := ExecuteIndy;
    WEB_LIB_NET: Result := Sis.Web.HTTPDownload.NET.Execute(FArqLocal, FArqRemoto, FProcessLog, FOutput, FExluiDestinoAntesDeBaixar);
    end;
  }
  FProcessLog.PegueLocal('THTTPDownload.Execute');
  try
    FProcessLog.RegistreLog('vai chamar Sis.Web.HTTPDownload.NET.Execute');
    Result := Sis.Web.HTTPDownload.NET.Execute(FArqLocal, FArqRemoto,
      FProcessLog, FOutput, FExluiDestinoAntesDeBaixar);
    FProcessLog.RegistreLog('retornou de Sis.Web.HTTPDownload.NET.Execute,Fim');
  finally
    FProcessLog.RetorneLocal;
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
  FProcessLog.Exibir(sLog);
  end;
  end;
}

end.

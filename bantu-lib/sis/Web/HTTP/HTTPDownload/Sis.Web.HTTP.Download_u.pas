unit Sis.Web.HTTP.Download_u;

interface

uses Sis.Web.HTTP.Download, Sis.ui.io.log, Sis.ui.io.output, IdHTTP,
  System.Classes, IdSSL, IdSSLOpenSSL;

type
  THTTPDownload = class(TInterfacedObject, IHTTPDownload)
  private
    FLog: ILog;
    FDtHLocal, FDtHRemoto : TDateTIme;
    FArqLocal, FArqRemoto : string;

    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    MS: TMemoryStream;
  public
    function Execute: Boolean;
    constructor Create(pArqLocal, pArqRemoto: string; pLog: ILog);
  end;

implementation

uses System.DateUtils, System.SysUtils, Sis.types.bool.utils, Sis.Types.Times,
  sis.sis.clipb_u, Sis.Files.Sync;

{ THTTPDownload }

constructor THTTPDownload.Create(pArqLocal, pArqRemoto: string; pLog: ILog);
var
  sLog: string;
begin
  FArqLocal := pArqLocal;
  FArqRemoto := pArqRemoto;
  FLog := pLog;

  sLog := 'THTTPDownload.Create,Local=' + FArqLocal+ ',Remoto=' + FArqRemoto;
  FLog.Exibir(sLog)
end;

function THTTPDownload.Execute: Boolean;
var
  sLog: string;
  sGMT: string;
  sDtH: string;
begin
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
      SetClipboardText(IdHTTP1.Response.RawHeaders.Text);

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
    FLog.Exibir(sLog);
  end;
end;

end.

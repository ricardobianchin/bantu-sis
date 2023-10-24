unit Sis.Web.HTTP.Download_u;

interface

uses Sis.Web.HTTP.Download, Sis.ui.io.log, Sis.ui.io.output, IdHTTP,
  System.Classes;

type
  THTTPDownload = class(TInterfacedObject, IHTTPDownload)
  private
    FLog: ILog;
    FDtHLocal, FDtHRemoto : TDateTIme;
    FArqLocal, FArqRemoto : string;

    HTTP: TIdHTTP;
    MS: TMemoryStream;
  public
    function Execute: Boolean;
    constructor Create(pArqLocal, pArqRemoto: string; pLog: ILog);
  end;

implementation

uses System.DateUtils, System.SysUtils, Sis.types.bool.utils;

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
begin
  sLog := 'THTTPDownload.Execute,TIdHTTP.Create';
  Result := True;
  HTTP := TIdHTTP.Create(nil);
  try
    try
      sLog := sLog + ',HTTP.Head';
      HTTP.Head(FArqRemoto);

      sLog := sLog + ',vai ler dth remoto';
      FDtHRemoto := StrToDateTime(HTTP.Response.RawHeaders.Values
        ['Last-Modified']);
      sLog := sLog + ',vai ler dth local';
      FDtHLocal := FileDateToDateTime(FileAge(FArqLocal));

      if FDtHRemoto > FDtHLocal then
      begin
        sLog := sLog + ',FDtHRemoto > FDtHLocal';

        MS := TMemoryStream.Create;
        try
          sLog := sLog + ',Get para MS';
          HTTP.Get(FArqRemoto, MS);
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
    HTTP.Free;
    sLog := sLog + ',Result=' + BooleanToStr(Result);
    FLog.Exibir(sLog);
  end;
end;

end.

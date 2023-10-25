unit Sta.Inst.Update_u;

interface

uses btu.lib.config, sis.ui.io.log;

function InstUpdate(pSisConfig: ISisConfig; pLog: ILog): boolean;

implementation

uses sis.Web.Factory, sis.Web.HTTP.Download, sis.types.bool.utils,
  Winapi.ShellAPI, Winapi.Windows;

function InstUpdate(pSisConfig: ISisConfig; pLog: ILog): boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
  sLog: string;
begin
  Result := False;

  sLog := 'InstUpdate';
  try
    sArqLocal := pSisConfig.PastaProduto +
      'Starter\Update\InstUpdate\MercadoUpdate.exe';
    sLog := sLog + ',sArqLocal=' + sArqLocal;

    sArqRemoto := 'https://www.bianch.in/arqs/daros/MercadoUpdate.exe';
    sLog := sLog + ',sArqRemoto=' + sArqRemoto;

    sLog := sLog + ',vai IHTTPDownloadCreate';
    oHTTPDownload := IHTTPDownloadCreate(sArqLocal, sArqRemoto, pLog);

    sLog := sLog + ',vai IHTTPDownloadExecute';

    Result := oHTTPDownload.Execute;
    sLog := sLog + ',baixou=' + BooleanToStr(Result);

    ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
  finally
    pLog.Exibir(sLog);
  end;
end;

end.

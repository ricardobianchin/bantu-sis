unit Sta.Inst.Update_u;

interface

uses btu.lib.config, sis.ui.io.log;

function  InstUpdate(pSisConfig: ISisConfig; pLog: ILog): boolean;

implementation

uses Sis.Web.Factory, Sis.Web.HTTP.Download;

function InstUpdate(pSisConfig: ISisConfig; pLog: ILog): boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload:  IHTTPDownload;
  sLog: string;
begin
  Result := False;

  sLog := 'InstUpdate';
  try
    sArqLocal := pSisConfig.PastaProduto + 'Starter\Update\InstUpdate\MercadoUpdate.exe';
    sLog := sLog + ',sArqLocal='+sArqLocal;

    sArqRemoto := 'https://www.bianch.in/arqs/daros/MercadoInstall.exe';
    sLog := sLog + ',sArqRemoto='+sArqRemoto;

    sLog := sLog + ',vai IHTTPDownloadCreate';
    oHTTPDownload := IHTTPDownloadCreate(sArqLocal, sArqRemoto, pLog);

    sLog := sLog + ',vai IHTTPDownloadCreate';

    Result := oHTTPDownload.Execute;
  finally
    pLog.Exibir(sLog);
  end;
end;

end.

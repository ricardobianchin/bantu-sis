unit Sta.Inst.Update_u;

interface

uses btu.lib.config, sis.ui.io.log, sis.ui.io.output,
  btu.lib.db.updater.constants_u, sta.constants;

function InstUpdate(pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput): boolean;

implementation

uses sis.Web.Factory, sis.Web.HTTP.Download, sis.types.bool.utils,
  Winapi.ShellAPI, Winapi.Windows, sis.win.pastas, System.SysUtils, dialogs;

function InstUpdate(pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput): boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
begin
  pLog.Exibir('InstUpdate inicio');
    sArqLocal := pSisConfig.PastaProduto +
      'Starter\Update\InstUpdate\MercadoUpdate.exe';

    GarantaPastaDoArq(sArqLocal);

    pLog.Exibir('sArqLocal=' + sArqLocal);

    sArqRemoto := 'https://www.bianch.in/arqs/daros/MercadoUpdate.exe';
    pLog.Exibir('sArqRemoto=' + sArqRemoto);

    pLog.Exibir('vai IHTTPDownloadCreate');
    oHTTPDownload := IHTTPDownloadCreate(sArqLocal, sArqRemoto, pLog, pOutput, INST_UPDATE_EXCLUI_LOCAL_ANTES_DOWNLOAD);

    pLog.Exibir('vai oHTTPDownload.Execute');

    Result := oHTTPDownload.Execute;
    pLog.Exibir('oHTTPDownload.Execute Result =' + BooleanToStr(Result));
    //showmessage('vou executar');
    if Result then
    begin
      try
        pLog.Exibir('vai executar');
        ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
        pLog.Exibir('executou');
      except on E: Exception do
        pLog.Exibir('InstUpdate, Erro ao executar sArqLocal, '+E.Message);
      end;
    end;
end;

end.

unit Sta.Inst.Update_u;

interface

uses btu.lib.config, sis.ui.io.ProcessLog, sis.ui.io.output,
  btu.lib.db.updater.constants_u, Sta.constants;

function InstUpdate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;

implementation

uses sis.Web.Factory, sis.Web.HTTP.Download, sis.types.bool.utils,
  Winapi.ShellAPI, Winapi.Windows, sis.win.pastas, System.SysUtils, dialogs;

function InstUpdate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
begin
  pProcessLog.Exibir('InstUpdate inicio');
  sArqLocal := pSisConfig.PastaProduto + ATUALIZ_ARQ_SUBPASTA;

  GarantaPastaDoArq(sArqLocal);

  pProcessLog.Exibir('sArqLocal=' + sArqLocal);

  sArqRemoto := ATUALIZ_URL;
  pProcessLog.Exibir('sArqRemoto=' + sArqRemoto);

  pProcessLog.Exibir('vai IHTTPDownloadCreate');
  oHTTPDownload := IHTTPDownloadCreate(sArqLocal, sArqRemoto, pProcessLog,
    pOutput, INST_UPDATE_EXCLUI_LOCAL_ANTES_DOWNLOAD);

  pProcessLog.Exibir('vai oHTTPDownload.Execute');

  Result := oHTTPDownload.Execute;
  pProcessLog.Exibir('oHTTPDownload.Execute Result =' + BooleanToStr(Result));
  // showmessage('vou executar');
  if Result then
  begin
    try
      pProcessLog.Exibir('vai executar');
      ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
      pProcessLog.Exibir('executou');
    except
      on E: Exception do
        pProcessLog.Exibir('InstUpdate, Erro ao executar sArqLocal, ' +
          E.Message);
    end;
  end;
end;

end.

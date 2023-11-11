unit Sta.Inst.Update_u;

interface

uses btu.lib.config, sis.ui.io.LogProcess, sis.ui.io.output,
  btu.lib.db.updater.constants_u, Sta.constants;

function InstUpdate(pSisConfig: ISisConfig; pLogProcess: ILogProcess;
  pOutput: IOutput): boolean;

implementation

uses sis.Web.Factory, sis.Web.HTTP.Download, sis.types.bool.utils,
  Winapi.ShellAPI, Winapi.Windows, sis.win.pastas, System.SysUtils, dialogs;

function InstUpdate(pSisConfig: ISisConfig; pLogProcess: ILogProcess;
  pOutput: IOutput): boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
begin
  pLogProcess.Exibir('InstUpdate inicio');
  sArqLocal := pSisConfig.PastaProduto + ATUALIZ_ARQ_SUBPASTA;

  GarantaPastaDoArq(sArqLocal);

  pLogProcess.Exibir('sArqLocal=' + sArqLocal);

  sArqRemoto := ATUALIZ_URL;
  pLogProcess.Exibir('sArqRemoto=' + sArqRemoto);

  pLogProcess.Exibir('vai IHTTPDownloadCreate');
  oHTTPDownload := IHTTPDownloadCreate(sArqLocal, sArqRemoto, pLogProcess,
    pOutput, INST_UPDATE_EXCLUI_LOCAL_ANTES_DOWNLOAD);

  pLogProcess.Exibir('vai oHTTPDownload.Execute');

  Result := oHTTPDownload.Execute;
  pLogProcess.Exibir('oHTTPDownload.Execute Result =' + BooleanToStr(Result));
  // showmessage('vou executar');
  if Result then
  begin
    try
      pLogProcess.Exibir('vai executar');
      ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
      pLogProcess.Exibir('executou');
    except
      on E: Exception do
        pLogProcess.Exibir('InstUpdate, Erro ao executar sArqLocal, ' +
          E.Message);
    end;
  end;
end;

end.

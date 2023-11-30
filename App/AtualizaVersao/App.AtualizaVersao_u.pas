unit App.AtualizaVersao_u;

interface

uses App.AtualizaVersao, Sis.Sis.Executavel_u, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.AppInfo;

type
  TAtualizaVersao = class(TExecutavel, IAtualizaVersao)
  private
    FAppInfo: IAppInfo;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
  public
    constructor Create(pAppInfo: IAppInfo; pOutput: IOutput;
      pProcessLog: IProcessLog);
    function Execute: boolean; override;
  end;

implementation

uses Sis.Web.HTTP.Download, Sis.UI.IO.Files, Sis.Web.Factory, Sis.Types.Bool_u,
  Winapi.Windows, Winapi.ShellAPI, System.SysUtils;

{ TAtualizaVersao }

constructor TAtualizaVersao.Create(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog);
begin
  FAppInfo := pAppInfo;
  FOutput := pOutput;
  FProcessLog := pProcessLog;
  FProcessLog.PegueAssunto('TAtualizaVersao.Create');
  FProcessLog.RegistreLog('TAtualizaVersao.Create');
  FProcessLog.RetorneAssunto;
end;

function TAtualizaVersao.Execute: boolean;
var
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
begin
  FProcessLog.PegueAssunto('TAtualizaVersao.Execute');
  try
    FProcessLog.RegistreLog('Inicio');
    sArqLocal := FAppInfo.Pasta + FAppInfo.AtualizExeSubPasta;

    FProcessLog.RegistreLog('GarantirPastaDoArquivo ' + sArqLocal);
    GarantirPastaDoArquivo(sArqLocal);

    sArqRemoto := FAppInfo.AtualizExeURL;
    FProcessLog.RegistreLog('sArqRemoto=' + sArqRemoto);

    FProcessLog.RegistreLog('vai IHTTPDownloadCreate');
    oHTTPDownload := HTTPDownloadCreate(sArqLocal, sArqRemoto, FProcessLog,
      FOutput, FAppInfo.InstUpdate_ExcluiLocalAntesDoDownload);

    FProcessLog.RegistreLog('vai oHTTPDownload.Execute');
    Result := oHTTPDownload.Execute;
    FProcessLog.RegistreLog('Retornou Execute,Result =' + BooleanToStr(Result));

    if Result then
    begin
      try
        FProcessLog.RegistreLog('vai executar ' + sArqLocal);
        ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
        FProcessLog.RegistreLog('Executou');
      except
        on E: Exception do
          FProcessLog.RegistreLog('InstUpdate, Erro ao executar sArqLocal, ' +
            E.Message);
      end;
    end;
  finally
    FProcessLog.RetorneAssunto;
  end;
end;

end.

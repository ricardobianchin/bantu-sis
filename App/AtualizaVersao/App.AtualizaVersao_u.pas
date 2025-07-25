unit App.AtualizaVersao_u;

interface

uses App.AtualizaVersao, Sis.Sis.Executavel_u, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.AppInfo;

const
{$IFDEF DEBUG}
  TESTA_VERSAO = False;
//  TESTA_VERSAO = True;
{$ELSE}
  TESTA_VERSAO = True;
{$ENDIF}

type
  TAtualizaVersao = class(TExecutavel, IAtualizaVersao)
  private
    FAppInfo: IAppInfo;
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
  inherited Create(pOutput, pProcessLog);
  FAppInfo := pAppInfo;
  ProcessLog.PegueAssunto('TAtualizaVersao.Create');
  ProcessLog.RegistreLog('TAtualizaVersao.Create');
  ProcessLog.RetorneAssunto;
end;

function TAtualizaVersao.Execute: boolean;
var
  dtAgora: TDateTime;
  sArqLocal: string;
  sArqRemoto: string;
  oHTTPDownload: IHTTPDownload;
  sArqLog: string;
  sLog: string;
begin
  dtAgora := Now;
  sArqLog := FAppInfo.PastaTmp + 'Logs\TAtualizaVersao.Execute\';
  ForceDirectories(sArqLog);
  sArqLog := sArqLog + DateTimeToNomeArq(dtAgora) +
    ' Log TAtualizaVersao.Execute.txt';
  sLog := '';
  try
    Result := TESTA_VERSAO;
    if not Result then
    begin
      sLog := sLog + 'TESTA_VERSAO=False'#13#10;
      exit;
    end;
    sLog := sLog + 'TESTA_VERSAO=True'#13#10;

    ProcessLog.PegueAssunto('TAtualizaVersao.Execute');
    try
      ProcessLog.RegistreLog('Inicio');
      sArqLocal := FAppInfo.Pasta + FAppInfo.AtualizExeSubPasta;

      ProcessLog.RegistreLog('GarantirPastaDoArquivo ' + sArqLocal);
      GarantirPastaDoArquivo(sArqLocal);

      sArqRemoto := FAppInfo.AtualizExeURL;
      ProcessLog.RegistreLog('sArqRemoto=' + sArqRemoto);

      sLog := sLog + 'sArqLocal=' + sArqLocal + #13#10;
      sLog := sLog + 'sArqRemoto=' + sArqRemoto + #13#10;

      ProcessLog.RegistreLog('vai IHTTPDownloadCreate');
      oHTTPDownload := HTTPDownloadCreate(sArqLocal, sArqRemoto, ProcessLog,
        Output, FAppInfo.InstUpdate_ExcluiLocalAntesDoDownload);

      ProcessLog.RegistreLog('vai oHTTPDownload.Execute');
      Result := oHTTPDownload.Execute;
      ProcessLog.RegistreLog('Retornou Execute,Result =' +
        BooleanToStr(Result));
      sLog := sLog + 'Retornou Execute,Result =' + BooleanToStr(Result)
        + #13#10;

      if Result then
      begin
        try
          ProcessLog.RegistreLog('vai executar ' + sArqLocal);
          sLog := sLog + 'vai executar ' + sArqLocal+ #13#10;

          ShellExecute(0, 'open', PChar(sArqLocal), nil, nil, SW_SHOWNORMAL);
          ProcessLog.RegistreLog('Executou');
        except
          on E: Exception do
            ProcessLog.RegistreLog('InstUpdate, Erro ao executar sArqLocal, ' +
              E.Message);
        end;
      end;
    finally
      ProcessLog.RetorneAssunto;
    end;
  finally
    sLog := sLog + 'Terminado'#13#10;
    EscreverArquivo(sLog, sArqLog);
  end;
end;

end.

unit App.AppObj_u_ExecEventos;

interface

uses App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TEventoDoSistema = (eventosisNaoIndicado, eventosisInicio, eventosisFim,
    eventosisPrincFormShow);

procedure ExecEvento(pEventoDoSistema: TEventoDoSistema; pAppInfo: IAppInfo;
  pOutput: IOutput; pProcessLog: IProcessLog);

implementation

uses Sis.UI.IO.Files, System.SysUtils, Sis.Win.Factory, Sis.Win.Execute;

procedure ExecEvento(pEventoDoSistema: TEventoDoSistema; pAppInfo: IAppInfo;
  pOutput: IOutput; pProcessLog: IProcessLog);
var
  sCaminho: string;
  sNomeArq: string;
  OWinExecute: IWinExecute;
begin
  pProcessLog.PegueLocal('App.AppObj_u_ExecEventos.ExecEvento');
  try
    sCaminho := pAppInfo.PastaComandos + 'Eventos\';

    GarantirPasta(sCaminho);

    case pEventoDoSistema of
      eventosisInicio:
        sNomeArq := 'Exec inicio.bat';
      eventosisFim:
        sNomeArq := 'Exec fim.bat';
      eventosisPrincFormShow:
        sNomeArq := 'Exec PrincForm Show.bat';
    else // eventosisNaoIndicado:
      sNomeArq := '';
    end;

    sNomeArq := sCaminho + sNomeArq;
    pProcessLog.RegistreLog('sNomeArq=' + sNomeArq + ',sCaminho=' + sCaminho);
    pProcessLog.RegistreLog('vai testar se existe');
    if not FileExists(sNomeArq) then
    begin
      pProcessLog.RegistreLog('nao existia, vai criar vazsio');
      EscreverArquivo('rem Arquivo criado automaticamente', sNomeArq);
    end;

    OWinExecute := WinExecuteCreate(sNomeArq, '', sCaminho, True, 1, pOutput);
    OWinExecute.EspereExecucao(pOutput, 16);
  finally
    pProcessLog.RetorneLocal;
  end;
end;

end.

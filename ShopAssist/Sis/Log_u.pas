unit Log_u;

interface

procedure InicieLog;
procedure EscrevaLog(pFrase: string);

implementation

uses Sis_u, System.SysUtils, Sis.UI.IO.Files, Sis.Types.Utils_u,
  System.DateUtils;

var
  dDtHoraInicio: TDateTime;
  sNomeArq: string;
  sPastaLog: string;

procedure InicieLog;
var
  sAgora: string;
  sMens: string;
begin
  dDtHoraInicio := Now;
  sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', dDtHoraInicio);

  sPastaLog := sPastaTmp + 'Assist\';
  GarantirPasta(sPastaLog);
  sNomeArq := sPastaLog + 'Log Assist ' + DateTimeToNomeArq
    (dDtHoraInicio) + '.txt';

  sMens := '--------------------------------------------' + sNOVA_LINHA + sAgora
    + ';' + 'Inicio' + sNOVA_LINHA;
  AdicioneAoArquivo(sMens, sNomeArq);
end;

procedure EscrevaLog(pFrase: string);
var
  dAgora: TDateTime;
  sAgora: string;
begin
  dAgora := Now;
  sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', dAgora);
  AdicioneAoArquivo(sAgora + ';' + pFrase + sNOVA_LINHA, sNomeArq);

end;

end.

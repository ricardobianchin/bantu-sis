unit Log_u;

interface

procedure InicieLog;
procedure EscrevaLog(pFrase: string);

implementation

uses Sis_u, System.SysUtils, Sis.UI.IO.Files, Sis.Types.Utils_u,
  System.DateUtils;

var
  sPastaLog: string;

procedure InicieLog;
var
  dAgora: TDateTime;
  sAgora: string;
  dHoje: TDateTime;
  sMens: string;
  sNomeArq: string;
begin
  sPastaLog := sPastaTmp + 'Assist\';
  GarantirPasta(sPastaLog);

  dAgora := Now;
  dHoje := Trunc(dAgora);

  sNomeArq := sPastaLog + 'Log Assist ' + DateToNomeArq(dHoje) + '.txt';

  sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', dAgora);
  sMens := '--------------------------------------------' + sNOVA_LINHA + sAgora
    + ';' + 'Inicio' + sNOVA_LINHA;

  AdicioneAoArquivo(sMens, sNomeArq);
end;

procedure EscrevaLog(pFrase: string);
var
  dAgora: TDateTime;
  sAgora: string;
  dHoje: TDateTime;
  sNomeArq: string;
begin
  dAgora := Now;
  dHoje := Trunc(dAgora);

  sNomeArq := sPastaLog + 'Log Assist ' + DateToNomeArq(dHoje) + '.txt';

  sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', dAgora);
  AdicioneAoArquivo(sAgora + ';' + pFrase + sNOVA_LINHA, sNomeArq);
end;

end.

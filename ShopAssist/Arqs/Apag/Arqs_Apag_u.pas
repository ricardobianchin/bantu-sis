unit Arqs_Apag_u;

interface

procedure ArqsApagar;

implementation

uses Sis.UI.IO.Files.ApagueAntigos_u, System.SysUtils, Sis_u, System.DateUtils;

procedure PastaApagar(pPasta: string; pOlderThan: TDateTime;
  pRemoverVazias: Boolean; pRecursivamente: Boolean);
var
  bCompletou: Boolean;
  sErro: string;
begin
  bCompletou := False;
  repeat
    sErro := '';
    DeleteOldFilesAndEmptyDirs(pPasta, pOlderThan, pRemoverVazias,
      pRecursivamente, bCompletou, sErro);
    // Aqui você pode adicionar um Sleep(10) ou Application.ProcessMessages
    // para não travar a aplicação, se o diretório for muito grande.
  until bCompletou or (sErro <> '');

//  if sErro <> '' then
//    ShowMessage(sErro);
end;

procedure ArqsApagar;
var
  dtAgora: TDateTime;
  dtHoje: TDateTime;
  dtOlderThan: TDateTime;
begin
  dtAgora := Now;
  if DaysBetween(dtUltimoApagamento, dtAgora) < 1 then
    exit;
  dtUltimoApagamento := dtAgora;
  dtHoje := Trunc(dtAgora);
  dtOlderThan := Date - 40;

  PastaApagar(sPastaTmp,            dtOlderThan, True { pRemoverVazias}, True {pRecursivamente});
  PastaApagar(sPastaBackup,         dtOlderThan, True { pRemoverVazias}, True {pRecursivamente});
  PastaApagar(sPastaComandos,       dtOlderThan, False { pRemoverVazias}, False {pRecursivamente});
  PastaApagar(sPastaComandosBackup, dtOlderThan, False { pRemoverVazias}, False {pRecursivamente});
//  PastaApagar(sPastaDocs,           dtOlderThan, True { pRemoverVazias}, True {pRecursivamente});

{    sPastaTmp := sPastaProduto + 'Tmp\';
  sPastaBackup := sPastaProduto + 'Backup\';
  sPastaComandos := sPastaProduto + 'Comandos\';
  sPastaComandosBackup := sPastaComandos + 'Backup\';
  sPastaDocs := sPastaProduto + 'Docs\';
 }
end;

end.

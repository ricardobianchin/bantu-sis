unit sis.win.pastas;

interface

function GetProgramFilesPath: string;
function PastaAcima(pPastaOrigem: string = ''): string;
function PastaAtual: string;
function DateToPath(pDtH: TDateTime = 0): string;

implementation

uses System.SysUtils, StrUtils, sis.types.strings;

function GetProgramFilesPath: string;
var
  ProgramFilesPath: string;
begin
  ProgramFilesPath := GetEnvironmentVariable('ProgramFiles');
  Result := ProgramFilesPath;
end;

function PastaAcima(pPastaOrigem: string = ''): string;
var
  rp: integer;
begin
  if pPastaOrigem = '' then
    pPastaOrigem := PastaAtual;

  pPastaOrigem := ExcludeTrailingPathDelimiter(pPastaOrigem);
  rp := RightPos('\', pPastaOrigem);
  Result := ExcludeTrailingPathDelimiter(LeftStr(pPastaOrigem, rp));
  Result := IncludeTrailingPathDelimiter(Result);
end;

function PastaAtual: string;
begin
  GetDir(0,result);
  result := IncludeTrailingPathDelimiter(result);
end;

function DateToPath(pDtH: TDateTime = 0): string;
var
  ano, mes, dia: word;
begin
  // Se o valor datetime não for informado, usa o valor atual
  if pDtH = 0 then
    pDtH := Date;

  // Extrai os componentes do valor datetime
  DecodeDate(pDtH, ano, mes, dia);

  // Formata o resultado no formato YYYY-mm-dd_hh-nn-ss-zzz
//  Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d', [ano, mes, dia, hora, minuto, segundo, milisegundo]);
  Result := Format('%.4d\%.2d\%.2d\', [ano, mes, dia]);

end;

end.

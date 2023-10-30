unit sis.win.pastas;

interface

uses System.Classes;

function GetProgramFilesPath: string;
function PastaAcima(pPastaOrigem: string = ''): string;
function PastaAtual: string;
function DateToPath(pDtH: TDateTime = 0): string;
procedure GarantaPastaDoArq(pNomeArq: string);
procedure LeDiretorio(pPasta: string; pNomesArqSL: TStrings; pZeraAntes: boolean; pMascara: string = '*.*');

implementation

uses System.SysUtils, StrUtils, sis.types.strings, System.IOUtils;

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

procedure GarantaPastaDoArq(pNomeArq: string);
var
  sPasta: string;
begin
  sPasta := IncludeTrailingPathDelimiter(ExtractFilePath(pNomeArq));
  ForceDirectories(sPasta);
end;

procedure LeDiretorio(pPasta: string; pNomesArqSL: TStrings; pZeraAntes: boolean; pMascara: string);
var
  F: TSearchRec;
begin
  if pZeraAntes then
    pNomesArqSL.Clear;

  if FindFirst(TPath.Combine(pPasta, pMascara), faAnyFile and not faDirectory, F) = 0 then
  begin
    try
      repeat
        if (F.Name <> '.') and (F.Name <> '..') then
          pNomesArqSL.Add(F.Name);
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
  end;
end;

end.

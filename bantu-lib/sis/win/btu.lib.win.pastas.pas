unit btu.lib.win.pastas;

interface

function GetProgramFilesPath: string;
function PastaAcima(pPastaOrigem: string = ''): string;
function PastaAtual: string;

implementation

uses System.SysUtils, StrUtils, btn.lib.types.strings;

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

end.

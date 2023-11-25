unit Sis.UI.IO.Files;

interface

uses System.Classes, Sis.UI.IO.Output.ProcessLog;

procedure VaParaPasta(pPasta: string);
function VaParaPastaDoArquivo(const pNomeArq: string; pProcessLog: IProcessLog): string;

function PastaCriarEntrar(const pCaminho: string): boolean;
procedure EscreverArquivo(pStr: string; pNomeArq: string);
function DateTimeToNomeArq(pDtH: TDateTime = 0): string;
function GetPastaDoArquivo(const pNomeArq: string): string;
procedure GarantirPasta(const pPasta: string);
function GarantirPastaDoArquivo(const pNomeArq: string): string;

function PastaAcima(pPastaOrigem: string = ''): string;
function PastaAtual: string;
function DateToPath(pDtH: TDateTime = 0): string;

procedure LeDiretorio(pPasta: string; pNomesArqSL: TStrings; pZeraAntes: boolean; pMascara: string = '*.*');

implementation

uses System.SysUtils, System.IOUtils, System.StrUtils, Sis.Types.Utils_u,
  Sis.Types.strings_u;

function DateTimeToNomeArq(pDtH: TDateTime): string;
var
  ano, mes, dia, hora, minuto, segundo, milisegundo: word;
begin
  // Se o valor datetime n?o for informado, usa o valor atual
  if pDtH = 0 then
    pDtH := Now;

  // Extrai os componentes do valor datetime
  DecodeDate(pDtH, ano, mes, dia);
  DecodeTime(pDtH, hora, minuto, segundo, milisegundo);

  // Formata o resultado no formato YYYY-mm-dd_hh-nn-ss-zzz
  Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d',
    [ano, mes, dia, hora, minuto, segundo, milisegundo]);
end;

function PastaCriarEntrar(const pCaminho: string): boolean;
begin
  ForceDirectories(pCaminho);

  Result := SetCurrentDir(pCaminho);
end;

procedure EscreverArquivo(pStr: string; pNomeArq: string);
var
  Arquivo: TFileStream;
  Buffer: TBytes;
begin
  Arquivo := TFileStream.Create(pNomeArq, fmCreate or fmShareDenyWrite);
  try
    Buffer := TEncoding.UTF8.GetBytes(pStr);
    Arquivo.Write(Buffer, Length(Buffer));
  finally
    Arquivo.Free;
  end;
end;

function GetPastaDoArquivo(const pNomeArq: string): string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(pNomeArq));
end;

procedure GarantirPasta(const pPasta: string);
begin
  ForceDirectories(pPasta);
end;

function GarantirPastaDoArquivo(const pNomeArq: string): string;
begin
  Result := GetPastaDoArquivo(pNomeArq);
  GarantirPasta(Result);
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
  // Se o valor datetime n?o for informado, usa o valor atual
  if pDtH = 0 then
    pDtH := Date;

  // Extrai os componentes do valor datetime
  DecodeDate(pDtH, ano, mes, dia);

  // Formata o resultado no formato YYYY-mm-dd_hh-nn-ss-zzz
//  Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d', [ano, mes, dia, hora, minuto, segundo, milisegundo]);
  Result := Format('%.4d\%.2d\%.2d\', [ano, mes, dia]);
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

procedure VaParaPasta(pPasta: string);
begin
  SetCurrentDir(pPasta);
end;

function VaParaPastaDoArquivo(const pNomeArq: string; pProcessLog: IProcessLog): string;
var
  sPasta: string;
  sLog: string;
begin
  sLog := 'NomeArq='+pNomeArq;
  pProcessLog.PegueLocal('Sis.UI.IO.Files function VaParaPastaDoArquivo');

  sPasta := GarantirPastaDoArquivo(pNomeArq);
  sLog := sLog + ',Pasta='+sPasta;
  pProcessLog.RegistreLog(sLog);
  VaParaPasta(sPasta);
  pProcessLog.RetorneLocal;
end;

end.

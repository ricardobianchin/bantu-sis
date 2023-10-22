unit Sis.Files;

interface

uses System.Classes;

function PastaCriarEntrar(const pCaminho: string): boolean;
procedure EscreverArquivo(pStr: string; pNomeArq: string);
function DateTimeToNomeArq(pDtH: TDateTime = 0): string;

implementation

uses System.SysUtils;

function DateTimeToNomeArq(pDtH: TDateTime): string;
var
  ano, mes, dia, hora, minuto, segundo, milisegundo: word;
begin
  // Se o valor datetime não for informado, usa o valor atual
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

end.

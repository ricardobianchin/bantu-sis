unit btu.lib.files;

interface

function PastaCriarEntrar(const pCaminho: string): boolean;
procedure EscreverArquivo(pStr: string; pNomeArq: string);
function DateTimeToNomeArq(pDtH: TDateTime = 0): string;

implementation

uses System.SysUtils, Classes;

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
  Result := Format('%.4d-%.2d-%.2d_%.2d-%.2d-%.2d-%.3d', [ano, mes, dia, hora, minuto, segundo, milisegundo]);
end;

function PastaCriarEntrar(const pCaminho: string): boolean;
begin
  ForceDirectories(pCaminho);

  result := SetCurrentDir(pCaminho);
end;

// Cria uma procedure chamada EscreverArquivo que recebe uma string como parâmetro
procedure EscreverArquivo(pStr: string; pNomeArq: string);
var
  Arquivo: TFileStream; // Declara uma variável do tipo TFileStream para manipular o arquivo
  Buffer: TBytes; // Declara uma variável do tipo TBytes para armazenar os bytes da string
begin
  // Cria um objeto TFileStream com o nome do arquivo, o modo de acesso e os atributos
  Arquivo := TFileStream.Create(pNomeArq, fmCreate or fmShareDenyWrite);
  try
    // Converte a string em um array de bytes usando a codificação UTF-8
    Buffer := TEncoding.UTF8.GetBytes(pStr);

    // Escreve os bytes no arquivo usando o método Write do TFileStream
    Arquivo.Write(Buffer, Length(Buffer));
  finally
    // Libera o objeto TFileStream da memória usando o método Free
    Arquivo.Free;
  end;
end;


end.

unit sis.types.strings.crypt;

interface

procedure Encriptar(pStr: string; out pEncriptado: string);
procedure Desencriptar(pEncriptado: string; out pStr: string);

implementation

uses System.SysUtils;

// Define um array de dois bytes com os três maiores primos menores do que 255
const
  Primos: array[0..2] of Byte = (239, 241, 251);

// Encripta uma string usando os primos como fatores
procedure Encriptar(pStr: string; out pEncriptado: string);
var
  i, j: Integer;
  c: Char;
  w: Word;
begin
  // Se pStr for nula, finaliza retornando pEncriptado como uma string nula
  if pStr = '' then
  begin
    pEncriptado := '';
    Exit;
  end;

  // Zera pEncriptado
  pEncriptado := '';

  // Percorre cada caractere de pStr
  j := 0; // Índice do primo a ser usado
  for i := 1 to Length(pStr) do
  begin
    c := pStr[i]; // Caractere atual

    // Multiplica o caractere pelo primo correspondente
    w := Ord(c) * Primos[j];

    // Converte o produto para um número hexadecimal de 4 casas
    pEncriptado := pEncriptado + IntToHex(w, 4);

    // Incrementa o índice do primo, voltando ao início se necessário
    Inc(j);
    if j > 2 then j := 0;
  end;
end;

// Desencripta uma string encriptada usando os primos como divisores
procedure Desencriptar(pEncriptado: string; out pStr: string);
var
  i, j: Integer;
  s: string;
  w: Word;
  c: Char;
begin
  // Se pEncriptado for uma string nula, deve abortar, retornando pStr como uma string nula
  if pEncriptado = '' then
  begin
    pStr := '';
    Exit;
  end;

  // Se o comprimento de pEncriptado não for múltiplo de 4, deve levantar uma exceção
  if Length(pEncriptado) mod 4 <> 0 then
    raise Exception.Create('String encriptada inválida');

  // Zera pStr
  pStr := '';

  // Percorre os caracteres de pEncriptado de 4 em 4
  j := 0; // Índice do primo a ser usado
  for i := 1 to Length(pEncriptado) div 4 do
  begin
    // Extrai a substring de quatro caracteres correspondente ao hexadecimal
    s := Copy(pEncriptado, (i - 1) * 4 + 1, 4);

    // Converte a substring para um número inteiro (word)
    w := StrToInt('$' + s);

    // Divide o número pelo primo correspondente
    w := w div Primos[j];

    // Converte o quociente para um caractere ASCII e adiciona em pStr
    c := Chr(w);
    pStr := pStr + c;

    // Incrementa o índice do primo, voltando ao início se necessário
    Inc(j);
    if j > 2 then j := 0;

   end;
end;

end.

-----
// Função que recebe um char e retorna verdadeiro se for um algarismo
function IsDigit(c: char): boolean;
begin
  // Verifica se o código ASCII do char está entre 48 e 57, que correspondem aos algarismos de 0 a 9
  IsDigit := (ord(c) >= 48) and (ord(c) <= 57);
end;

// Procedure que recebe uma string cujo conteúdo são dados separados por ; e substitui as sequências de # seguidas de 3 algarismos pelo caractere ASCII correspondente
procedure AsciiCodeToChar(var pStr: string);
var
  i, code: integer;
  c: char;
  // Percorre a string da esquerda para a direita
  i := 1;
  while i <= length(pStr) do
  begin
    // Se encontrar o caractere #
    if pStr[i] = '#' then
    begin
      // Verifica se os próximos três caracteres são algarismos
      if (i + 3 <= length(pStr)) and IsDigit(pStr[i+1]) and IsDigit(pStr[i+2]) and IsDigit(pStr[i+3]) then
      begin
        // Converte os três algarismos em um número inteiro
        code := StrToInt(pStr[i+1] + pStr[i+2] + pStr[i+3]);
        // Converte o número inteiro em um caractere ASCII
        c := chr(code);
        // Substitui a sequência de # e três algarismos pelo caractere ASCII na string original
        pStr := Copy(pStr, 1, i-1) + c + Copy(pStr, i+4, length(pStr) - i - 3);
      end;
    end;
    // Incrementa o índice da string
    i := i + 1;
  end;
end;

----

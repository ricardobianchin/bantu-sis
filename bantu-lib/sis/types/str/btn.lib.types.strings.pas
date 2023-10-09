unit btn.lib.types.strings;

interface

procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean = True);
function StrSemAcento(const pStr: string;
  pTudoMaiusculas: boolean = True): string;

function StrSemEspacoDuplo(pStr: string): string;

procedure CharOnlyDigit(var Key: Char);

procedure CharToName(var Key: Char);
function StrToName(const pStr: string): string;

function IsWindowsFilenameChar(c: Char): boolean;
procedure ReplaceInvalidFilenameChar(var c: Char);
function StrToNomeArq(const filename: string): string;
function IsWindowsFilenameValid(filename: string): boolean;

function RightPos(pCar: Char; pStr: string): integer;

function StrApos(pStr, pBusca: string): string;

function StrGarantirTermino(pStr, pTermino: string): string;

function IsDigit(c: char): boolean;
procedure AjusteAsciiCodeToChar(var pStr: string);

implementation

uses strutils, sysutils;

// Constantes com os caracteres imprim�veis e os de substitui��o
const
  Imprimiveis =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ��������������������������';
  SubstSemAcento =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZAaAaAaAaEeEeEeIiOoOoOoUuCc';

procedure CharOnlyDigit(var Key: Char);
begin
  if Pos(Key, '0123456789') = 0 then
    Key := #0;
end;

// Procedure que recebe um par�metro var Key: char e faz a substitui��o
procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean);
var
  Posic: integer;
begin
  // Localiza o conte�do do par�metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posi��o na segunda constante
  if Posic >= 1 then
    Key := UpCase(SubstSemAcento[Posic]);
end;

// Procedure que recebe um par�metro var s: string e faz a substitui��o de cada caractere
function StrSemAcento(const pStr: string; pTudoMaiusculas: boolean): string;
var
  i: integer;
begin
  Result := pStr;

  for i := 1 to Length(Result) do
  begin
    CharSemAcento(Result[i], pTudoMaiusculas);
  end;
  if pTudoMaiusculas then
    Result := UpperCase(Result);
end;

procedure CharToName(var Key: Char);
var
  Posic: integer;
begin
  // Localiza o conte�do do par�metro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posi��o na segunda constante

  if Posic >= 1 then
    Key := SubstSemAcento[Posic]
  else
    Key := '_';
end;

function StrToName(const pStr: string): string;
var
  i: integer;
begin
  Result := StrSemAcento(pStr);
  for i := 1 to Length(Result) do
  begin
    CharToName(Result[i]);
  end;
end;

function IsWindowsFilenameChar(c: Char): boolean;
begin
  Result := CharInSet(c, ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_', '-', '.']);
end;

function IsWindowsFilenameValid(filename: string): boolean;
var
  c: Char;
begin
  Result := True;
  for c in filename do
    if not IsWindowsFilenameChar(c) then
    begin
      Result := False;
      Break;
    end;
end;

procedure ReplaceInvalidFilenameChar(var c: Char);
begin
  if not IsWindowsFilenameChar(c) then
    c := '_';
end;

{
  procedure ReplaceInvalidFilenameChars(var filename: string);
  var
  i: Integer;
  begin
  for i := 1 to Length(filename) do
  ReplaceInvalidFilenameChar(filename[i]);
  end;
}

function StrToNomeArq(const filename: string): string;
var
  i: integer;
begin
  Result := filename;
  for i := 1 to Length(Result) do
    ReplaceInvalidFilenameChar(Result[i]);
end;

function RightPos(pCar: Char; pStr: string): integer;
var
  t: integer;
begin
  Result := 0;
  for t := Length(pStr) downto 1 do
  begin
    if pCar = pStr[t] then
    begin
      Result := t;
      exit;
    end;
  end;
end;

function StrApos(pStr, pBusca: string): string;
var
  iBuscaLen, iPosNaStr: integer;
begin
  Result := pStr;

  iBuscaLen := pBusca.Length;
  if iBuscaLen = 0 then
    exit;

  iPosNaStr := Pos(pBusca, Result);

  if iPosNaStr = 0 then
    exit;

  Delete(Result, 1, iPosNaStr);
end;

function StrSemEspacoDuplo(pStr: string): string;
var
  i, j: integer;
begin
  // Remover espa�os no in�cio e no fim da string
  pStr := Trim(pStr);

  // Inicializar os �ndices i e j
  i := 1;
  j := 1;
  // Percorrer a string da esquerda para a direita
  while i <= Length(pStr) do
  begin
    // Copiar o caractere na posi��o i para a posi��o j
    pStr[j] := pStr[i];
    // Se o caractere for um espa�o, avan�ar i at� encontrar um caractere diferente de espa�o
    if pStr[i] = ' ' then
    begin
      while (i <= Length(pStr)) and (pStr[i] = ' ') do
        Inc(i);
    end
    // Caso contr�rio, avan�ar i normalmente
    else
      Inc(i);
    // Avan�ar j tamb�m
    Inc(j);
  end;
  // Ajustar o tamanho da string para o valor de j - 1
  SetLength(pStr, j - 1);
  // Retornar a string modificada
  Result := pStr;
end;

function StrGarantirTermino(pStr, pTermino: string): string;
var
  iLenTermino: integer;
  sFinalAtual: string;
begin
  Result := pStr;

  iLenTermino := Length(pTermino);

  if iLenTermino = 0 then
    exit;

  sFinalAtual := RightStr(pStr, iLenTermino);
  if sFinalAtual = pTermino then
    exit;

  Result := Result + pTermino;
end;


// Fun��o que recebe um char e retorna verdadeiro se for um algarismo
function IsDigit(c: char): boolean;
begin
  // Verifica se o c�digo ASCII do char est� entre 48 e 57, que correspondem aos algarismos de 0 a 9
  IsDigit := (ord(c) >= 48) and (ord(c) <= 57);
end;

// Procedure que recebe uma string cujo conte�do s�o dados separados por ; e substitui as sequ�ncias de # seguidas de 3 algarismos pelo caractere ASCII correspondente
procedure AjusteAsciiCodeToChar(var pStr: string);
var
  i, code: integer;
  c: char;
begin
  // Percorre a string da esquerda para a direita
  i := 1;
  while i <= length(pStr) do
  begin
    // Se encontrar o caractere #
    if pStr[i] = '#' then
    begin
      // Verifica se os pr�ximos tr�s caracteres s�o algarismos
      if (i + 3 <= length(pStr)) and IsDigit(pStr[i+1]) and IsDigit(pStr[i+2]) and IsDigit(pStr[i+3]) then
      begin
        // Converte os tr�s algarismos em um n�mero inteiro
        code := StrToInt(pStr[i+1] + pStr[i+2] + pStr[i+3]);
        // Converte o n�mero inteiro em um caractere ASCII
        c := chr(code);
        // Substitui a sequ�ncia de # e tr�s algarismos pelo caractere ASCII na string original
        pStr := Copy(pStr, 1, i-1) + c + Copy(pStr, i+4, length(pStr) - i - 3);
      end;
    end;
    // Incrementa o �ndice da string
    i := i + 1;
  end;
end;

end.

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
  iPos: integer;
begin
  // Encontrar a posi��o da primeira ocorr�ncia da substring na string
  iPos := pStr.IndexOf(pBusca);

  // Se a posi��o for -1, significa que a substring n�o foi encontrada
  if iPos = -1 then
    // Retornar a string completa
    Result := pStr
  else
    // Retornar os caracteres que est�o depois da posi��o encontrada
    Result := pStr.Substring(iPos + pBusca.Length);
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

end.

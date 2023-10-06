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

// Constantes com os caracteres imprimíveis e os de substituição
const
  Imprimiveis =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÁáÀàÃãÂâÉéÈèÊêÍíÓóÕõÔôÚúÇç';
  SubstSemAcento =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZAaAaAaAaEeEeEeIiOoOoOoUuCc';

procedure CharOnlyDigit(var Key: Char);
begin
  if Pos(Key, '0123456789') = 0 then
    Key := #0;
end;

// Procedure que recebe um parâmetro var Key: char e faz a substituição
procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean);
var
  Posic: integer;
begin
  // Localiza o conteúdo do parâmetro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posição na segunda constante
  if Posic >= 1 then
    Key := UpCase(SubstSemAcento[Posic]);
end;

// Procedure que recebe um parâmetro var s: string e faz a substituição de cada caractere
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
  // Localiza o conteúdo do parâmetro Key na primeira constante
  Posic := Pos(Key, Imprimiveis);
  // Se encontrou, substitui Key com o caractere de mesma posição na segunda constante

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
  // Encontrar a posição da primeira ocorrência da substring na string
  iPos := pStr.IndexOf(pBusca);

  // Se a posição for -1, significa que a substring não foi encontrada
  if iPos = -1 then
    // Retornar a string completa
    Result := pStr
  else
    // Retornar os caracteres que estão depois da posição encontrada
    Result := pStr.Substring(iPos + pBusca.Length);
end;

function StrSemEspacoDuplo(pStr: string): string;
var
  i, j: integer;
begin
  // Remover espaços no início e no fim da string
  pStr := Trim(pStr);

  // Inicializar os índices i e j
  i := 1;
  j := 1;
  // Percorrer a string da esquerda para a direita
  while i <= Length(pStr) do
  begin
    // Copiar o caractere na posição i para a posição j
    pStr[j] := pStr[i];
    // Se o caractere for um espaço, avançar i até encontrar um caractere diferente de espaço
    if pStr[i] = ' ' then
    begin
      while (i <= Length(pStr)) and (pStr[i] = ' ') do
        Inc(i);
    end
    // Caso contrário, avançar i normalmente
    else
      Inc(i);
    // Avançar j também
    Inc(j);
  end;
  // Ajustar o tamanho da string para o valor de j - 1
  SetLength(pStr, j - 1);
  // Retornar a string modificada
  Result := pStr;
end;

end.

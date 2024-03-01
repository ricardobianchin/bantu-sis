unit Sis.Types.strings_u;

interface

uses
  System.UITypes
  , System.Hash
  ;

procedure CharSemAcento(var Key: Char; pTudoMaiusculas: boolean = True);
function StrSemAcento(const pStr: string;
  pTudoMaiusculas: boolean = True): string;

function StrSemStr(pStr: string; pStrARemover: string = #32): string;
function StrSemCharRepetido(pStr: string; pChar: char = #32): string;

procedure CharOnlyDigit(var Key: Char);

procedure CharToName(var Key: Char);
function StrToName(const pStr: string): string;

function StrComerNoFim(pStr: string; pQtdChars: integer): string;
function StrComerNoInicio(pStr: string; pQtdChars: integer): string;

function IsWindowsFilenameChar(c: Char): boolean;
procedure ReplaceInvalidFilenameChar(var c: Char);
function StrToNomeArq(const filename: string): string;
function IsWindowsFilenameValid(filename: string): boolean;

function RightPos(pCar: Char; pStr: string): integer;

function StrApos(pStr, pBusca: string): string;

function StrGarantirTermino(pStr, pTermino: string): string;

function IsDigit(c: char): boolean;
procedure AjusteAsciiCodeToChar(var pStr: string);

function TruncSnakeCase(pIdentifier: string; pMaxIdentifierLenght: integer): string;
//function ArrayToSnakeCase(pPalavras: TArray<string>): string;
function ArrayLargestIndex(pPalavras: TArray<string>): integer;
function SnakeCaseFutureLenght(pPalavras: TArray<string>): integer;
function StrCountCharLeft(pStr: string; pCharInicial: char = '0'): integer;
function SemCharAEsquerda(pStr: string; pCharInicial: char = '0'): string;
function TemChar(pStr: string; pChar: char): boolean;
procedure RemovaChars(pStr: string; pCharBusca: char);

procedure StrSemEnterNoFim(var pStr: string);

function StrCheckSum(const pStr: string; pSHA2Version: THashSHA2.TSHA2Version = SHA256): string;

procedure StrCheckSum32(pStr: string; out pCheckStr: string); overload;
function StrCheckSum32(pStr: string): string;  overload;

function VarToString(pValue: variant): string;

function ConvertHTMLChars(pStr: string): string;

implementation

uses
  System.SysUtils, System.StrUtils, System.Variants;

const
  Imprimiveis = ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'ÁáÀàÃãÂâÉéÈèÊêÍíÓóÕõÔôÚúÇç');
  SubstSemAcento = ('ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'AaAaAaAaEeEeEeIiOoOoOoUuCc');

  VALID_FILENAME_CHARS: TSysCharSet = ['a' .. 'z', 'A' .. 'Z', '0' .. '9',
    '_', '-', '.', '!', '@', '#', '$', '%', '&', '(', ')', '[', ']', '{', '}'];


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
  Result := CharInSet(c, VALID_FILENAME_CHARS);
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

function StrSemStr(pStr: string; pStrARemover: string = #32): string;
begin
  Result := ReplaceStr(pStr, pStrARemover, '');
end;

function StrSemCharRepetido(pStr: string; pChar: char): string;
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
    if pStr[i] = pChar then
    begin
      while (i <= Length(pStr)) and (pStr[i] = pChar) do
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


// Função que recebe um char e retorna verdadeiro se for um algarismo
function IsDigit(c: char): boolean;
begin
  // Verifica se o código ASCII do char está entre 48 e 57, que correspondem aos algarismos de 0 a 9
  IsDigit := (ord(c) >= 48) and (ord(c) <= 57);
end;

// Procedure que recebe uma string cujo conteúdo são dados separados por ; e substitui as sequências de # seguidas de 3 algarismos pelo caractere ASCII correspondente
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

function ArrayToSnaceCase(pPalavras: TArray<string>): string;
var
  I: integer;
begin
  Result := '';

  for I := 0 to Length(pPalavras) - 1 do
  begin
    if Result <> '' then
      Result := Result + '_';
    Result := Result + pPalavras[I];
  end;
end;

function TruncSnakeCase(pIdentifier: string; pMaxIdentifierLenght: integer): string;
var
  aPalavras: TArray<string>;
  iMaior, I, L: integer;
begin
  Result := pIdentifier;
  L := Result.Length;

  if l <= pMaxIdentifierLenght  then
    exit;

  Result := '';
  aPalavras := pIdentifier.Split(['_']);

  while SnakeCaseFutureLenght(aPalavras) > pMaxIdentifierLenght do
  begin
    iMaior := ArrayLargestIndex(aPalavras);
    aPalavras[iMaior] := StrComerNoFim(aPalavras[iMaior], 1);
  end;

  for I := 0 to Length(aPalavras) - 1 do
  begin
    if Result <> '' then
      Result := Result + '_';

    Result := Result + aPalavras[I];
  end;

  Result := StrSemCharRepetido(Result, '_');
end;

function ArrayLargestIndex(pPalavras: TArray<string>): integer;
var
  i, max, index: integer;
begin
  max := 0; // inicializa o comprimento máximo como zero
  index := -1; // inicializa o índice como -1 (significa que o array está vazio)
  for i := 0 to Length(pPalavras) - 1 do // percorre o array de strings
  begin
    if Length(pPalavras[i]) > max then // se a string atual é mais longa do que o máximo atual
    begin
      max := Length(pPalavras[i]); // atualiza o máximo com o comprimento da string atual
      index := i; // atualiza o índice com o índice da string atual
    end;
  end;
  Result := index; // retorna o índice da string mais longa
end;

function SnakeCaseFutureLenght(pPalavras: TArray<string>): integer;
var
  L, i, len: integer;
begin
  L := Length(pPalavras) - 1;

  len := 0;
  for i := 0 to L do
  begin
    len := len + Length(pPalavras[i]);
  end;

  len := len + L;

  Result := len;
end;

function StrComerNoFim(pStr: string; pQtdChars: integer): string;
var
  L: integer;
begin
  Result := pStr;

  L := pStr.Length;
  if L = 0 then
    exit;

  L := L - pQtdChars;
  if L < 1 then
  begin
    Result := '';
    exit;
  end;

  Result := LeftStr(pStr, L);
end;

function StrComerNoInicio(pStr: string; pQtdChars: integer): string;
var
  L: integer;
begin
  Result := pStr;

  L := pStr.Length;
  if L = 0 then
    exit;

  L := L - pQtdChars;
  if L < 1 then
  begin
    Result := '';
    exit;
  end;

  Result := RightStr(pStr, L);
{
  // Verifica se a quantidade de caracteres é válida
  if (pQtdChars > 0) and (pQtdChars < Length(pStr)) then
    // Retorna a substring a partir da posição pQtdChars + 1
    Result := Copy(pStr, pQtdChars + 1, Length(pStr) - pQtdChars)
  else
    // Retorna a string original se a quantidade de caracteres é inválida
    Result := pStr;
    }
end;

function StrCountCharLeft(pStr: string; pCharInicial: char): integer;
var
  i, count: integer;
begin
  pStr := Trim(pStr);
  if pStr = '' then
  begin
    Result := 0;
    Exit;
  end;

  if pStr[1] <> pCharInicial then
  begin
    Result := 0;
    Exit;
  end;

  count := 0;
  for i := 1 to Length(pStr) do
  begin
    if pStr[i] = pCharInicial then
      Inc(count)
    else
      Break;
  end;

  Result := count;
end;

function SemCharAEsquerda(pStr: string; pCharInicial: char = '0'): string;
var
  iQtdCharsIniciais: integer;
  sCortada: string;
begin
  pStr := Trim(pStr);

  iQtdCharsIniciais := StrCountCharLeft(pStr, pCharInicial);

  if iQtdCharsIniciais < 1 then
  begin
    Result := pStr;
    exit;
  end;

  sCortada := StrComerNoInicio(pStr, iQtdCharsIniciais);
  Result := sCortada;
end;

function TemChar(pStr: string; pChar: char): boolean;
begin
  Result := Pos(pChar, pStr) > 0;
end;

procedure RemovaChars(pStr: string; pCharBusca: char);
begin
  pStr := StringReplace(pStr, pCharBusca, '', [rfReplaceAll]);
end;

procedure StrSemEnterNoFim(var pStr: string);
// Esta procedure modifica a string passada por referência, removendo o enter (#13#10) no final, se houver
begin
  if Length(pStr) >= 2 then // Verifica se a string tem pelo menos dois caracteres
  begin
    if (pStr[Length(pStr) - 1] = #13) and (pStr[Length(pStr)] = #10) then // Verifica se os dois últimos caracteres são #13#10
    begin
      SetLength(pStr, Length(pStr) - 2); // Remove os dois últimos caracteres da string
    end;
  end;
end;

function StrCheckSum(const pStr: string; pSHA2Version: THashSHA2.TSHA2Version): string;
begin
  // Cria uma instância da classe THashSHA2 com a versão SHA-256
//  var Hasher := THashSHA2.Create(THashSHA2.TSHA2Version.SHA256);
  var Hasher := THashSHA2.Create(pSHA2Version);
  // Calcula o hash da string pStr
  Hasher.Update(pStr);
  // Retorna o hash como uma string hexadecimal
  Result := Hasher.HashAsString;
end;

procedure StrCheckSum32(pStr: string; out pCheckStr: string);
begin
  pCheckStr := StrCheckSum32(pStr);
end;

function StrCheckSum32(pStr: string): string;
var
  Hasher: THashFNV1a32;
begin
  Hasher := THashFNV1a32.Create; // cria um objeto THashFNV1a32
  Hasher.Update(pStr); // atualiza o hash com a string pStr
  Result := Hasher.HashAsString; // obtém o hash como uma string hexadecimal
end;

function VarToString(pValue: variant): string;
begin
  Result := VarToStrDef(pValue, '');
end;

function ConvertHTMLChars(pStr: string): string;
begin
  Result := pStr;
  Result := StringReplace(Result, '&atilde;', 'ã', [rfReplaceAll]);
  Result := StringReplace(Result, '&ccedil;', 'ç', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ccedil;', 'Ç', [rfReplaceAll]);
  Result := StringReplace(Result, '&eacute;', 'é', [rfReplaceAll]);
  Result := StringReplace(Result, '&Eacute;', 'É', [rfReplaceAll]);
  Result := StringReplace(Result, '&otilde;', 'õ', [rfReplaceAll]);
  {
&atilde;
&ccedil;
&Ccedil;
&eacute;
&Eacute;
&otilde;
   }
end;

end.
